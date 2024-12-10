// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";

contract ClaimAirdrop is Script {
    error __ClaimAirdropScript_InvalidSignatureLength();

    address CLAIMING_ADDRESS = 0xC624E1cC3865Da5f90ff908dD3dDB963b70eC335;
    uint256 CLAIMING_AMOUNT = 25 * 1e18;
    bytes32 PROOF_ONE = 0x4f7ed06ac4caf11b858c1e8bbe708161de9798917875f9e55b533b9bfa63aaa6;
    bytes32 PROOF_TWO = 0x81f0e530b56872b6fc3e10f8873804230663f8407e21cef901b8aeb06a25e5e2;
    bytes32[] proof = [PROOF_ONE, PROOF_TWO];
    bytes private SIGNATURE =
        hex"b7582de71a47d6536e188955e6e74e3a5acf666b1358c15c5702660a36b7b74c740aa3adc9883f31643733e2a57a26b7a9be911524b25fd554fb51e92884c8921c";

    function claimAirdrop(address airdrop) public {
        vm.startBroadcast();
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(SIGNATURE);
        MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS, CLAIMING_AMOUNT, proof, v, r, s);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentDeploy = DevOpsTools.get_most_recent_deployment("MerkleAirdrop", block.chainid);
        claimAirdrop(mostRecentDeploy);
    }

    function splitSignature(bytes memory sig) public pure returns (uint8 v, bytes32 r, bytes32 s) {
        if (sig.length != 65) {
            revert __ClaimAirdropScript_InvalidSignatureLength();
        }

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}
