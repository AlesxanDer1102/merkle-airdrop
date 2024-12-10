// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {ContractToken} from "src/ContractToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0x8436ddc723b8cce6c11cf330cf90abeab681f3f1a18a90c487f1e51e067c0cff;

    uint256 private s_amountToTransfer = 4 * 25 * 1e18;

    function run() public returns (MerkleAirdrop, ContractToken) {
        return deployMerkleAirdrop();
    }

    function deployMerkleAirdrop() public returns (MerkleAirdrop, ContractToken) {
        vm.startBroadcast();
        ContractToken token = new ContractToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(token)));
        token.mint(token.owner(), s_amountToTransfer);
        token.transfer(address(airdrop), s_amountToTransfer);
        vm.stopBroadcast();

        return (airdrop, token);
    }
}
