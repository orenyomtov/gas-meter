// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GasMeter} from "../src/GasMeter.sol";

// Example contract to test the GasMeter with
contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}

contract CounterTest is Test {
    GasMeter gasMeter = new GasMeter();
    Counter counter = new Counter();

    function setUp() public {
        counter.setNumber(1234);
    }

    function test_number() view public {
        (uint256 gasUsed, bytes memory returnData) = gasMeter.meterStaticCall(
            address(counter),
            abi.encodeWithSignature("number()")
        );
        uint256 returnedNumber = abi.decode(returnData, (uint256));
        console.log("gas measured for number() was %s, and the value returned was %s", gasUsed, returnedNumber);
    }

    function test_setNumber() public {
        (uint256 gasUsed,) = gasMeter.meterCall(
            address(counter),
            abi.encodeWithSignature("setNumber(uint256)", 0)
        );
        console.log("gas measured for setNumber(0) was %s", gasUsed);

        (gasUsed,) = gasMeter.meterCall(
            address(counter),
            abi.encodeWithSignature("setNumber(uint256)", 1)
        );
        console.log("gas measured for setNumber(1) was %s", gasUsed);
    }

    function test_Increment() public {
        (uint256 gasUsed,) = gasMeter.meterCall(
            address(counter),
            abi.encodeWithSignature("increment()")
        );
        console.log("gas measured for increment() was %s", gasUsed);
    }
}
