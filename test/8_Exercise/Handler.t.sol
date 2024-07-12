// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol"; 
import {TSwapPool} from "../../src/TSwapPool.sol";

contract Handler is Test {

    TSwapPool pool;

    constructor(TSwapPool _pool) {
        pool = _pool;
    }
}