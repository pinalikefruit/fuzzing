pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {SimpleStorage} from "../src/2_Exercise.sol";

contract SimplestorageTest is Test {
    SimpleStorage simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function test_simpleStorage() public {
        uint8 value = 100; // But if I use 255 => revert
        (bool success, ) = address(simpleStorage).call(
            abi.encodeWithSignature("setAddition(uint8)",value)
        );
        assert(success);
    }

    function test_storageRevert(uint8 value) public {
        (bool success, ) = address(simpleStorage).call(
            abi.encodeWithSignature("setAddition(uint8)",value)
        );
        assert(success);
    }
    
}

