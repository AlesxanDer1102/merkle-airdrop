// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {ContractToken} from "src/ContractToken.sol";
import {DeployMerkleAirdrop} from "script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is Test {
    MerkleAirdrop public airdrop;
    ContractToken public token;
    DeployMerkleAirdrop deployer;

    bytes32 public ROOT = 0x8436ddc723b8cce6c11cf330cf90abeab681f3f1a18a90c487f1e51e067c0cff;

    uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
    uint256 public AMOUNT_TO_SENT = AMOUNT_TO_CLAIM * 4;

    bytes32 public proofOne = 0x4f7ed06ac4caf11b858c1e8bbe708161de9798917875f9e55b533b9bfa63aaa6;
    bytes32 public proofTwo = 0x81f0e530b56872b6fc3e10f8873804230663f8407e21cef901b8aeb06a25e5e2;
    bytes32[] public PROOF = [proofOne, proofTwo];

    address public gasPayer;
    address user;
    uint256 userPrivateKey;

    function setUp() public {
        deployer = new DeployMerkleAirdrop();
        (airdrop, token) = deployer.deployMerkleAirdrop();

        // token = new ContractToken();
        // airdrop = new MerkleAirdrop(ROOT, token);
        // token.mint(token.owner(), AMOUNT_TO_SENT);
        // token.transfer(address(airdrop), AMOUNT_TO_SENT);
        (user, userPrivateKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gasPayer");
    }

    function testUserCanClaim() public {
        uint256 startingBalance = token.balanceOf(user);
        bytes32 digest = airdrop.getMessageHash(user, AMOUNT_TO_CLAIM);

        //sing a message
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);

        //gasPayer calls claim using the signed message
        vm.prank(gasPayer);
        airdrop.claim(user, AMOUNT_TO_CLAIM, PROOF, v, r, s);

        uint256 endingBalance = token.balanceOf(user);
        console.log("Ending balance:", endingBalance);
        assertEq(endingBalance - startingBalance, AMOUNT_TO_CLAIM);
    }
}
