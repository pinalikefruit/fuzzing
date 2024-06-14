// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {StatefulFuzzCatches} from "../src/6_Exercise.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

// INVARIANT: doMoreMathAgain should never return 0
contract StatefulFuzzCatchesTest is StdInvariant, Test {
    
    StatefulFuzzCatches moreMath;

    function setUp() public {
        moreMath = new StatefulFuzzCatches();
        targetContract(address(moreMath));
    }

   function test_MoreMath(uint128 value) public {
        assert(moreMath.doMoreMathAgain(value) != 0);
   }

   function invariant_moreMath() public {
        assert(moreMath.storedValue() != 0);
   }
   
}
