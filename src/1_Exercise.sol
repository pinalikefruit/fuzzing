// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ShouldBeZero {

    uint256 public shouldAlwaysBeZero;
    uint256 public hiddenValue;
    
    function doStuff(uint256 data) public {
        if (data == 2) {
            shouldAlwaysBeZero = 1;
        }
        if (hiddenValue == 7) {
            shouldAlwaysBeZero = 1;
        }
        hiddenValue = data;
    }
}
