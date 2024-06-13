pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {AlwaysEven} from "../src/3_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract AlwaysEvenTest is StdInvariant, Test {

    AlwaysEven alwaysEven;

    function setUp() public {
        alwaysEven = new AlwaysEven();
        targetContract(address(alwaysEven));
    }

    // Invariant: the number must always be even, never odd.
    function test_breakEven(uint256 value) public {
        alwaysEven.setEvenNumber(value);
        assert(alwaysEven.alwaysEvenNumber() % 2 == 0);
    }
    // Don't catch the error because is stateless

    function invariant_breakEven() public {
        assert(alwaysEven.alwaysEvenNumber() % 2 == 0);
    }
}

