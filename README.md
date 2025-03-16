# TodoList Smart Contract

This repository contains the **TodoList Smart Contract**, a simple Solidity-based contract that allows users to create, update, mark, and retrieve tasks. This smart contract was deployed on the Base Sepolia Testnet.

## Features
- **Add Tasks:** Users can create new tasks with a description.
- **Mark Tasks as Completed:** Allows marking tasks as done.
- **Retrieve Tasks:** Users can retrieve all tasks, including completed and pending ones.
- **Update Task Description:** Modify the description of an existing task.
- **Delete Tasks:** Users can remove tasks from the list.

## Deployment Information
- **Testnet:** Base Sepolia
- **Contract Address:** `0x6af608d03BB268280B8f7a161E666fD7bcdCf0F5`
- **Verified Smart Contract:** [BaseScan Contract Link](https://sepolia.basescan.org/address/0x6af608d03BB268280B8f7a161E666fD7bcdCf0F5#code)
- **Transaction Hash:** `0x7558b846569c266086c20ec8d44bba60c4f72242b29de9246a6b752c185722cb`

## Development & Deployment Setup

### Prerequisites
Ensure you have the following installed:
- **Node.js**
- **NPM**
- **Hardhat** (Ethereum development framework)

### Installation
Clone the repository and install dependencies:
```sh
npm install
```

### Compilation
To compile the contract, run:
```sh
npx hardhat compile
```

### Deployment
To deploy the contract to Base Sepolia:
```sh
npx hardhat run scripts/deploy.js --network baseSepolia
```

### Verification
To verify the contract on BaseScan:
```sh
npx hardhat verify --network baseSepolia <DEPLOYED_CONTRACT_ADDRESS>
```
## Screenshots

 > Successfully deployed and verified the smart contract on the Base Testnet..
![TodoListSmartContractScreenshot](<TodoListSmartContractScreenshot.png>)