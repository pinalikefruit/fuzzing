pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../../src/7_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {MockUSDC} from "../mocks/MockUSDC.sol";
import {YeildERC20} from "../mocks/YeildERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// INVARIANT: Users must always be able to withdraw the exact balance amout out. 

contract HandlerStatefulFuzzCatchesTest is StdInvariant, Test {

    HandlerStatefulFuzzCatches sfc;
    MockUSDC usdc;
    YeildERC20 yeild;
    address user = makeAddr("user");
    IERC20[] supportsToken;
    uint256 startAmount;

    function setUp() public {
        vm.startPrank(user);
        vm.deal(user, 100 ether);
        usdc = new MockUSDC();
        yeild = new YeildERC20();
        startAmount = yeild.INITIAL_SUPPLY();
        usdc.mint(user,startAmount);
        vm.stopPrank();
        supportsToken.push(usdc);
        supportsToken.push(yeild);
        sfc = new HandlerStatefulFuzzCatches(supportsToken);
        targetContract(address(sfc));
    }

    function test_startAmount() public view {
        assert(usdc.balanceOf(user) == yeild.INITIAL_SUPPLY());
        assert(yeild.balanceOf(user) == yeild.INITIAL_SUPPLY());
    }
    //This test won't work because
    // 1. Anyone can call deposit() but don't have tokens
    // 2. The fuzzer call with random token that doen't allowed
    // 3. They don't approve to sfc use the token
    function statefulFuzz_Withdraw() public {
        vm.startPrank(user);
        sfc.withdrawToken(usdc);
        sfc.withdrawToken(yeild);
        vm.stopPrank();

        assert(usdc.balanceOf(address(sfc)) == 0);
        assert(yeild.balanceOf(address(sfc)) == 0);

        assert(usdc.balanceOf(user) == startAmount);
        assert(yeild.balanceOf(user) == startAmount);
    }
}