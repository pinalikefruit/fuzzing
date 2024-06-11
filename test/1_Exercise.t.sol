// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ShouldBeZero} from "../src/1_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract ExerciseTest is StdInvariant, Test {
    ShouldBeZero public exercise;

    function setUp() public {
        exercise = new ShouldBeZero();
        exercise.doStuff(0);
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

    // Ran 1 test for test/1_Exercise.t.sol:ExerciseTest
    // [FAIL. Reason: panic: assertion failed (0x01); counterexample: calldata=0x7cc4bf1f0000000000000000000000000000000000000000000000000000000000000002 args=[2]] testIsAlwaysGetZeroFuzz(uint256) (runs: 11, μ: 30532, ~: 30532)
    // Suite result: FAILED. 0 passed; 1 failed; 0 skipped; finished in 2.49ms (1.50ms CPU time)
    // Ran 1 test suite in 6.71ms (2.49ms CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)

    function invariant_testAlwaysReturnsZero() public {
        assert(exercise.shouldAlwaysBeZero() == 0);
    }
    Ran 1 test suite in 603.65ms (602.60ms CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)

// Failing tests:
// Encountered 1 failing test in test/1_Exercise.t.sol:ExerciseTest
// [FAIL. Reason: panic: assertion failed (0x01)]
//         [Sequence]
//                 sender=0x000000e81dC915B28E8A7DA2f95095d47720470c addr=[src/1_Exercise.sol:ShouldBeZero]0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f calldata=doStuff(uint256) args=[7]
//                 sender=0x000000000000000000000000000051283091f371 addr=[src/1_Exercise.sol:ShouldBeZero]0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f calldata=doStuff(uint256) args=[559957977466960038730597734146349188226791458 [5.599e44]]
//  invariant_testAlwaysReturnsZero() (runs: 256, calls: 3827, reverts: 0)

// Encountered a total of 1 failing tests, 0 tests succeeded
}
