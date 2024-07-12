// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test } from "forge-std/Test.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import { Math } from "../../src/Magic/Math.sol";
import { Handler} from "./Handler.t.sol";

// INVARIANT: mathematical operations with overflow and underflow checks.
// The result must be greater than or equal to 0 and less than or equal to MAX_INT256.



contract Invariant is StdInvariant, Test {
    Handler handler;

    // function setUp() public {
    //     handler = new Handler();

    //     bytes4[] memory selectors = new bytes4[](1);

    //     selectors[0] = handler.convertToInt.selector;

    //     targetSelector(FuzzSelector({addr:address(handler), selectors: selectors}));
    //     targetContract(address(handler));
    // }

    // function invariant_toInt256() public {
    //     assert();
    // }

    function test_convertToInt(uint256 x) public {
        uint256 max_value = Math.MAX_INT256;
        x = bound(x, 0, max_value);
        int256 y = Math.toInt256(x);
        assert(y >= 0);
        assert(int256(x) == y);
    }

    // The result must be greater than or equal to 0 and less than or equal to MAX_INT256.
    function test_addDelta(uint256 x, int256 y) public {
        x = bound(x, 0, Math.MAX_INT256);
        int256 max = int256(Math.MAX_INT256 - 1);
        // y = bound(y, int256(0),  x);
        uint256 result = Math.addDelta(x,y);
        assert(result >= 0 || result <= Math.MAX_INT256);
        
    }
}
