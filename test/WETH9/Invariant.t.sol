// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test } from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import { WETH9 } from "../../src/WETH9.sol";
import { Handler} from "./Handler.t.sol";

// INVARIANT: WETH tokens for Ether at a 1:1 exchange rate always
// INVARIANT II : solvency.

contract Invariant is StdInvariant, Test {
    WETH9 weth;
    Handler handler;
   

    function setUp() public {
        weth = new WETH9();
        handler = new Handler(weth);

        bytes4[] memory selectors = new bytes4[](3);

        selectors[0] = handler.depositETH.selector;
        selectors[1] = handler.withdrawETH.selector;
        selectors[2] = handler.fallbackETH.selector;
        // selectors[3] = handler.fallbackETH.selector;
        // excludeSender(address(handler));
        // excludeSender(address(weth));
        targetSelector(FuzzSelector({addr:address(handler), selectors: selectors}));
        targetContract(address(handler));
    }
    
    function statefulFuzz_totalSupply() public {
        assertEq(handler.STARTING_AMOUNT() , address(handler).balance + weth.totalSupply());
    }
   
   function statefulFuzz_solvencyDeposits() public {
        assertEq(
          address(weth).balance,
          handler.ghost_depositSum() - handler.ghost_withdrawSum()
        );
    }

    // The WETH contract's Ether balance should always be
    // at least as much as the sum of individual balances
    function invariant_solvencyBalances() public {
        uint256 sumOfBalances;
        address[] memory actors = handler.actors();
        for(uint256 i = 0; i < actors.length; i++){
            sumOfBalances += weth.balanceOf(actors[i]);
        }

        assertEq(
            address(weth).balance,
            sumOfBalances
        );
    }
}
