# Katana V3 Smart Contracts

This repository contains the router and governance contracts for the Katana decentralized exchange.

## Development

### Prerequisites

To work with this repository, ensure you have the following tools installed:
- Node.js (version 16 or later)
- Yarn or npm
- Hardhat

After cloning the repository, install the required JavaScript dependencies for testing by running:
```
yarn
```
And Foundry dependencies:
```
forge install
forge soldeer update
```

### Compiling

To compile the contracts, run:
```
forge build
```
This will generate the compiled artifacts in the out directory.

### Testing

You can run tests to ensure the contracts work as expected.
```
forge test
```
With Hardhat tests, run:
```
yarn test
```
