// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test } from "forge-std/Test.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import { ERC20Mock } from "../mocks/ERC20Mock.sol";
import { PoolFactory } from "../../src/PoolFactory.sol";
import { TSwapPool } from "../../src/TSwapPool.sol";

// INVARIANT: The product should always be the same x*y should always equal the same k
contract Invariant is StdInvariant, Test {
    ERC20Mock poolToken;
    ERC20Mock WETH;
    address owner = makeAddr("owner");
    
    int256 constant STARTING_Y =  50e18;
    int256 constant STARTING_X = 100e18;
    
    PoolFactory factory;
    TSwapPool pool;

    function setUp() public {
        // poolToken = new ERC20Mock();
        // WETH = new ERC20Mock();
        // factory = new PoolFactory(address(WETH));
        // pool = TSwapPool(poolFactory.createPool(address(poolToken)));

        // poolToken.mint(address(this),uint256(STARTING_X));
        // WETH.mint(address(this), uint256(STARTING_Y));

        // poolToken.approve(pool,uint256(STARTING_X));
        // WETH.approve(pool,uint256(STARTING_Y));

        // poolToken.deposit(uint256(STARTING_Y),uint256(STARTING_Y),uint256(STARTING_X), uint64(block.timestamp));
   
    }


    function statefulFuzz_constantProductFormulaStaysTheSame() public {
        // The change in the pool size of WETH should follow this function:
        // ∆x = (β/(1-β)) * x
    }
}
