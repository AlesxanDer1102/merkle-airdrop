# Merkle Airdrop

A professional-grade project leveraging **Foundry** to implement a Merkle Tree-based airdrop system. This contract ensures an efficient and secure distribution of tokens by verifying inclusion proofs using Merkle Trees. The project is deployed on the **Sepolia Testnet**.

## Features

- **Efficient Airdrop Distribution**: Uses Merkle Trees to validate recipients with minimal gas costs.
- **Secure Verification**: Only valid recipients can claim tokens using Merkle proof verification.
- **Testnet Deployment**: Deployed and operational on the Sepolia Testnet.

---

## Deployed Contracts on Sepolia Testnet

- **Merkle Airdrop Contract**:  
  Address: `0xB7fdb96c347144fc7C2D2f3AC36114Bc84E7FEc7`  
  Transaction Hash: `0xa503a65205950cfaecc23bdc18d0160d31592ce70dd831d5200800ed9ce43a82`

- **Token for Airdrop Contract**:  
 Address: `0xe27Bf400d4298021C97a5DB5f27B7659aE269bEF`  
 Transaction Hash: `0x294d4d4d787a0b2d828a479392a2dc1ba27b25b5831066b9a505d7cccfcf85c7`

---

## Prerequisites

To run this project locally, ensure you have the following:

- **Foundry**: Installed and set up. Follow the [Foundry installation guide](https://book.getfoundry.sh/getting-started/installation.html).
- **Node.js and npm**: For dependencies related to scripting and interactions.
- **Sepolia Testnet Access**: RPC URL and a funded wallet for testing.

---

## Installation and Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/AlesxanDer1102/merkle-airdrop.git
   cd merkle-airdrop
   ```

2. **Install Dependencies**:
   Install any necessary dependencies:
   ```bash
   forge install
   ```

3. **Set Environment Variables**:
   Create a `.env` file and set the following:
   ```env
   SEPOLIA_RPC_URL=<your_sepolia_rpc_url>
   PRIVATE_KEY=<your_wallet_private_key>
   ETHERSCAN_API_KEY=<your_etherscan_api_key>
   ```
   Replace `<your_sepolia_rpc_url>` with your RPC provider URL, `<your_wallet_private_key>` with the private key of your testing wallet and `<your_etherscan_api_key>` with your Etherscan API key.

4. **Compile Contracts**:
   Compile the contracts using Forge:
   ```bash
   forge build
   ```

5. **Run Tests**:
   Execute the tests to ensure functionality:
   ```bash
   forge test
   ```

---

## Running the Project Locally

1. **Deploy the Contract Locally**:
   Deploy to a local testnet using Foundry's `anvil`:
   ```bash
   anvil
   ```
   In a new terminal, deploy the contract:
   ```bash
   forge script script/MerkleAirdrop.s.sol --fork-url http://127.0.0.1:8545 --broadcast
   ```

2. **Verify Merkle Proofs**:
   Use scripts to test Merkle proofs and simulate claims:
   ```bash
   forge script script/VerifyMerkleProof.s.sol --fork-url http://127.0.0.1:8545
   ```

---
## Deploy in Sepolia Testnet

You have to use the makefile to make more easy
```bash 
    make deploy ARGS="--network sepolia"
```

---

## Finding Your Deployed Contracts

### **On the Sepolia Testnet**
- **Contract Address**: `0xB7fdb96c347144fc7C2D2f3AC36114Bc84E7FEc7`
- **View on Sepolia Explorer**: [Sepolia Etherscan](https://sepolia.etherscan.io/)

### **Locally**
- Deployed addresses are logged in the deployment script or console output.

---

## Acknowledgments

This project was built using **Foundry**, inspired by the efficiency and scalability of Merkle Trees for token distribution.
