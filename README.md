# DEGEN Token Smart Contract

This project creates an ERC20 Token named "Degen" (symbol: DGN) on the Avalanche Network. It supports minting by the owner, transfers, and NFT redemption using DGN tokens.

## Description

The DEGEN Token is built with Solidity, utilizing the OpenZeppelin library to ensure secure and standardized ERC20 functionality. It includes features like minting, burning, and balance management. Additionally, the contract allows the owner to register NFTs, which users can redeem using DGN tokens.

## Getting Started

### Prerequisites

- Node.js and npm
- Hardhat
- Avalanche Fuji testnet private key
- Snowtrace API key

### Installation

1. Clone the repository and navigate to the project directory.
2. Install dependencies:

   ```bash
   npm install
2. Deploy and Verify
   ```bash
   npx hardhat run scripts/deploy.js --network fuji
   npx hardhat verify <Contract Address> --network fuji

### Contract Features-

1. Minting: Only the owner can mint new tokens.
2. Burning: Token holders can burn their own tokens.
3. NFT Redeem: The owner can register NFTs, and users can redeem them using DGN tokens.

### License
This project is licensed under the MIT License. 

### Author
Divyansh Sandhu
