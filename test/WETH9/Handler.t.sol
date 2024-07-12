// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { Test, console2 } from "forge-std/Test.sol";
import { WETH9 } from "../../src/WETH9.sol";
import  "../../src/LibAddressSet.sol";


// PENDING: Creating an AddressSet

contract Handler is Test {
    WETH9 weth;
    
    struct AddressSet {
        address[] addrs;
        mapping(address => bool) saved;
    }


    using LibAddressSet for AddressSet;
    
    uint256 public ghost_depositSum;
    uint256 public ghost_withdrawSum;
    uint256 constant public  STARTING_AMOUNT = 100_000_000_000 ether;


    AddressSet internal _actors;

    constructor(WETH9 _weth) {
        weth = _weth;
        vm.deal(address(this), STARTING_AMOUNT);
    }

    modifier createActor() {
        _actors.add(msg.sender);
        _;
    }
    function fallbackETH(uint256 amount) public createActor {
        amount = bound(amount, 0, address(this).balance);

        if(msg.sender == address(weth) || msg.sender == address(this) ) {
            return;
        }

        (bool success, ) = payable(weth).call{value: amount}("");
        require(success, "send fallback failed");
        
        ghost_depositSum += amount;
    }

    function depositETH(uint256 amount) public createActor {
        amount = bound(amount, 0, address(this).balance);

        if(msg.sender == address(weth) || msg.sender == address(this) ) {
            return;
        }

        weth.deposit{value: amount}();
        
        ghost_depositSum += amount;

    }

    function withdrawETH(uint256 amount) public {
        amount = bound(amount,0, weth.balanceOf(msg.sender));
        
        weth.withdraw(amount);

        ghost_withdrawSum += amount;
    }

    function _pay(address to, uint256 amount) internal {
        (bool success, ) = payable(to).call{value:amount}("");
        require(success, "_pay revert");
    }

    function actors() external returns(address[] memory) {
        return _actors.addrs;
    }
    receive() external payable{}
}