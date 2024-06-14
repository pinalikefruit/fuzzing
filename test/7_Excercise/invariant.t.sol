// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../../src/7_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {MockUSDC} from "../mocks/MockUSDC.sol";
import {YeildERC20} from "../mocks/YeildERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Handler} from "./handler.t.sol";
// INVARIANT: Users must always be able to withdraw the exact balance amout out. 

contract HandlerStatefulFuzzCatchesTest is StdInvariant, Test {

    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    MockUSDC mockUSDC;
    YeildERC20 yeildERC20;
    address user = makeAddr("user");
    IERC20[] supportsToken;
    uint256 startAmount;
    Handler handler;

    function setUp() public {
        vm.startPrank(user);

        vm.deal(user, 100 ether);

        yeildERC20 = new YeildERC20();
        startAmount = yeildERC20.INITIAL_SUPPLY();

        mockUSDC = new MockUSDC();
        mockUSDC.mint(user,startAmount);
        
        supportsToken.push(mockUSDC);
        supportsToken.push(yeildERC20);

        handlerStatefulFuzzCatches = new HandlerStatefulFuzzCatches(supportsToken);
        vm.stopPrank();

        handler = new Handler(handlerStatefulFuzzCatches,mockUSDC,yeildERC20 );

        bytes4[] memory selectors = new bytes4[](4);

        selectors[0] = handler.depositYeildERC20.selector;
        selectors[1] = handler.depositMockUSDC.selector;
        selectors[2] = handler.withdrawYeildERC20.selector;
        selectors[3] = handler.withdrawMockUSDC.selector;

        targetSelector(FuzzSelector({addr: address(handler), selectors : selectors}));
        targetContract(address(handler));
    }

    function test_startAmount() public view {
        assert(mockUSDC.balanceOf(user) == startAmount);
        assert(yeildERC20.balanceOf(user) == startAmount);
    }

    function statefulFuzz_breakInvariant() public {
        vm.startPrank(user);
        handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        vm.stopPrank();

        assert(mockUSDC.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
        assert(yeildERC20.balanceOf(address(handlerStatefulFuzzCatches)) == 0);

        assert(mockUSDC.balanceOf(user) == startAmount);
        assert(yeildERC20.balanceOf(user) == startAmount);
        
    }
}