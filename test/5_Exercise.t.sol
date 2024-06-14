pragma solidity 0.8.20;

import { StatelessFuzzCatches } from "../src/5_Exercise.sol";
import "forge-std/Test.sol";

// INVARIANT: doMath should never return 0
contract StatelessFuzzCatchesTest is  Test {

    StatelessFuzzCatches sfc;

    function setUp() public {
        sfc = new StatelessFuzzCatches();
    } 

    function test_fuzzingDoMath(uint128 value) public {
        assert(sfc.doMath(value) != 0);
    }

}