// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../../src/7_Exercise.sol";
import {MockUSDC} from "../mocks/MockUSDC.sol";
import {YeildERC20} from "../mocks/YeildERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Handler is Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    MockUSDC mockUSDC;
    YeildERC20 yeildERC20;
    address user;

    constructor(
        HandlerStatefulFuzzCatches _handlerStatefulFuzzCatches,
        MockUSDC _mockUSDC,
        YeildERC20 _yeildERC20
    ) {
        handlerStatefulFuzzCatches = _handlerStatefulFuzzCatches;
        mockUSDC = _mockUSDC;
        yeildERC20 = _yeildERC20;
        user = yeildERC20.owner();
    }

    function depositYeildERC20(uint256 _amount) public {
        uint256 amount = bound(_amount, 0,yeildERC20.balanceOf(user));
        vm.startPrank(user);
        yeildERC20.approve(address(handlerStatefulFuzzCatches),amount);
        handlerStatefulFuzzCatches.depositToken(IERC20(yeildERC20),amount);
        vm.stopPrank();
    }

    function depositMockUSDC(uint256 _amount) public {
        uint256 amount = bound(_amount, 0,mockUSDC.balanceOf(user));
        vm.startPrank(user);
        mockUSDC.approve(address(handlerStatefulFuzzCatches),amount);
        handlerStatefulFuzzCatches.depositToken(IERC20(mockUSDC),amount);
    }

    function withdrawYeildERC20() public {
        vm.startPrank(user);
        handlerStatefulFuzzCatches.withdrawToken(IERC20(yeildERC20));
        vm.stopPrank();
    }

    function withdrawMockUSDC() public {
        vm.startPrank(user);
        handlerStatefulFuzzCatches.withdrawToken(IERC20(mockUSDC));
        vm.stopPrank();
    }

}
