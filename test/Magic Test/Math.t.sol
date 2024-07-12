// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol";
import { Math } from "../../src/Magic/Math.sol";

// INVARIANT: mathematical operations with overflow and underflow checks.

contract MathTest is Test {
    
    // Safely converts an unsigned integer to a signed integer.
    
    function test_convertToInt(uint256 x) public {
        x = bound(x, 0, Math.MAX_INT256);
        int256 y = Math.toInt256(x);
        assert(y >= 0);
        assert(int256(x) == y);
    }

    // The result must be greater than or equal to 0 and less than or equal to MAX_INT256.
     
    function test_addDelta(uint256 x, int256 y) public {
        x = bound(x, 0, Math.MAX_INT256);
        uint256 result = Math.addDelta(x,y);
        assert(result >= 0 && result <= Math.MAX_INT256);
    }

    function test_addDelta2() public {
        uint256 result = uint(type(int256).min);
        console2.log(result);
        assert(result >= 0 && result <= Math.MAX_INT256);
    }

}
