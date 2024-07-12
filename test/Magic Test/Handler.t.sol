// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol";
import { Math } from "../../src/Magic/Math.sol";

// INVARIANT: mathematical operations with overflow and underflow checks.
// The result must be greater than or equal to 0 and less than or equal to MAX_INT256.



contract Handler is Test {
    

    function convertToInt(uint256 x) public {
        x = bound(x, 0, Math.MAX_INT256);
        int256 y = Math.toInt256(x);
        assert(y>= 0);
    }
}