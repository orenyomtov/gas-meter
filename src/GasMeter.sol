// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GasMeter {
    // It's the output of: huffc --evm-version paris -r src/GasMeter.huff
    bytes internal constant _HUFF_GAS_METER_COMPILED_BYTECODE = (
        hex"5b60003560e01c8063abe770f2146100296101d8015780632b73eefa146100716101d80157600080fd5b36600460003760005131505a6000600060405160606000515afa905a60800190036000523d600060603e6100606101d801573d6060fd5b60406020523d6040523d6060016000f35b36600460003760005131505a600060006040516060346000515af1905a60820190036000523d600060603e6100a96101d801573d6060fd5b60406020523d6040523d6060016000f3"
    );
    uint256 internal constant _HUFF_GAS_METER_COMPILED_BYTECODE_OFFSET = 472;

    function meterStaticCall(
        address addr,
        bytes memory data
    ) external view returns (uint256 gasUsed, bytes memory returnData) {
        function() internal pure huffGasMeter;
        assembly {
            huffGasMeter := _HUFF_GAS_METER_COMPILED_BYTECODE_OFFSET
        }
        huffGasMeter();

        // Just to trick the compiler into including the bytecode
        // This code will never be executed, because huffGasMeter() will return or revert
        bytes memory r = _HUFF_GAS_METER_COMPILED_BYTECODE;
        return (r.length, r);
    }

    function meterCall(
        address addr,
        bytes memory data
    ) external returns (uint256 gasUsed, bytes memory returnData) {
        function() internal pure huffGasMeter;
        assembly {
            huffGasMeter := _HUFF_GAS_METER_COMPILED_BYTECODE_OFFSET
        }
        huffGasMeter();

        // Just to trick the compiler into including the bytecode
        // This code will never be executed, because huffGasMeter() will return or revert
        bytes memory r = _HUFF_GAS_METER_COMPILED_BYTECODE;
        return (r.length, r);
    }
}
