# Isle Protocol

[![Foundry][foundry-badge]][foundry]

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

This repository contains the core smart contracts for the Isle Protocol.

## Getting Started

0. If you are on VS Code, install Nomicfoundation/hardhat-solidity or JuanBlanco/solidity (select one for solidity) and
   Tamasfe/even-better-toml as extensions.
   ([Learn more](https://book.getfoundry.sh/config/vscode#integrating-with-vscode))

1. Install [Forge](https://book.getfoundry.sh/getting-started/installation) and [pnpm](https://pnpm.io/installation)

2. Install npm packages

    ```sh
    pnpm install
    ```

3. Install foundry libraries

    ```sh
    forge install
    ```

## Architecture

Isle Protocol is a designed where each pool will be a set of contracts

- `PoolAddressesProvider`
- `LoanManager`
- `WithdrawalManager`
- `PoolConfigurator`
- `Pool`

That is to say, each pool will have its own set of contracts so as to maximize customisability for pool admins.

## Usage

This is a list of the most frequently needed commands.

### Build

Build the contracts:

```sh
$ forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
$ forge clean
```

### Compile

Compile the contracts:

```sh
$ forge build
```

### Coverage

Get a test coverage report:

```sh
$ forge coverage
```

Get a .lcov coverage report

```sh
$ forge coverage --report lcov
```

### Deploy

Deploy to Anvil:

```sh
$ forge script script/Deploy.s.sol --broadcast --fork-url http://localhost:8545
```

### Gas snapshot

```sh
$ forge snapshot
```

### Gas report

```sh
$ pnpm gas-report
```

### Format

Format the contracts:

```sh
$ forge fmt
```

### Gas Usage

Get a gas report:

```sh
$ forge test --gas-report
```

### Lint

Lint the contracts:

```sh
$ pnpm lint
```

### Test

Run the tests:

```sh
$ forge test
```

### Scripts

View balance of address
```sh
cast balance --rpc-url "sepolia" -e $ADDRESS
```

Send ETH to another address

```sh
cast send $ADDRESS --rpc-url "sepolia" --value 0.1ether --private-key $PRIV_KEY
```

Run deploy scripts

```sh
forge script scripts/DeployERC20Mint.s.sol --rpc-url "$RPC_URL" --sender "$SENDER" --broadcast --sig "run()" --verify -vvvv
forge script scripts/DeployCore.s.sol --rpc-url "$RPC_URL" --sender "$SENDER" --broadcast --sig "run(address)" --verify -vvvv "$ADDRESS"
forge script scripts/Init.s.sol --rpc-url "$RPC_URL" --sender "$SENDER" --broadcast --sig "run(address,address)" --verify -vvvv "$RECEIVABLE" "$PAP"
```

Run Anvil with specified Mnemonic

```sh
anvil -m "$MNEMONIC"
```

Get crurrent gas price in gwei

```sh
cast to-unit $(cast gas-price) gwei
```
