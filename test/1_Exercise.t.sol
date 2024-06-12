// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ShouldBeZero} from "../src/1_Exercise.sol";
// import StdInvariant from forge-std and inherit it in our test contract.
import {StdInvariant} from "forge-std/StdInvariant.sol";

// You can find full explaination about this exercise here.
// https://updraft.cyfrin.io/courses/security/review/fuzzing-and-invariants

contract ExerciseTest is StdInvariant, Test {
    ShouldBeZero public exercise;

    function setUp() public {
        exercise = new ShouldBeZero();
        // Tell to foundry which contract  we'll be calling random functions on.
        targetContract(address(exercise));
    }

    // 1. Implement unit test, don't get the bugs
    // Our invariant isn't broken
    function test_shouldBeZero() public {
        uint256 data = 1;
        exercise.doStuff(data);
        assertEq(exercise.shouldAlwaysBeZero(), 0);
    }

    // 2. What is the invariant?
    // shouldAlwaysBeZero variable always be zero
    // We apply Stateless Fuzzing
    function testIsAlwaysGetZeroFuzz(uint256 data) public {
        exercise.doStuff(data);
        assert(exercise.shouldAlwaysBeZero() == 0);
    }

    // 3. Delete the conditional give the first bugs and try again. 
    function invariant_testAlwaysReturnsZero() public {
        assert(exercise.shouldAlwaysBeZero() == 0);
    }

}
