pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Safe} from "../src/4_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract SafeTest is StdInvariant, Test {

    Safe safe;

    function setUp() public {
        safe = new Safe();
        targetContract(address(safe));
        vm.deal(address(safe), 100 ether);
    }

    function testWithdraw() public {
        payable(address(safe)).transfer(1 ether);
        uint256 prevBalance = address(this).balance;
        safe.withdraw();
        uint256 actualBalance = address(this).balance;
        assertEq(prevBalance + 1 ether, actualBalance);
    }

    function test_fuzzWithdraw(uint256 amount) public {
        vm.deal(address(this), amount);
        payable(address(safe)).transfer(amount);
        uint256 prevBalance = address(this).balance;
        safe.withdraw();
        uint256 actualBalance = address(this).balance;
        assertEq(prevBalance + amount , actualBalance);
    }

    // the amount withdrawn must always be the same as the amount deposited.
    function invariant_withdraw() public {
        safe.deposit{value: 1 ether}();
        uint256 prevBalance = safe.balance(address(this));
        assert(prevBalance == 1 ether);
        safe.withdraw();
        uint256 actualBalance = safe.balance(address(this));
        assertGt(prevBalance,actualBalance);
    }

    receive() external payable{}
}