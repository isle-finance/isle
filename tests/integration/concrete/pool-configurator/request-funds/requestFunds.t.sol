// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Errors } from "contracts/libraries/Errors.sol";

import { PoolConfigurator_Integration_Shared_Test } from "../../../shared/pool-configurator/PoolConfigurator.t.sol";

contract RequestFunds_Integration_Concrete_Test is PoolConfigurator_Integration_Shared_Test {
    uint256 private _principal;

    function setUp() public virtual override(PoolConfigurator_Integration_Shared_Test) {
        PoolConfigurator_Integration_Shared_Test.setUp();

        _principal = defaults.PRINCIPAL_REQUESTED();
    }

    function test_requestFunds() external whenCoverIsSufficient {
        changePrank(address(loanManager));

        expectCallToTransferFrom({ from: address(pool), to: address(loanManager), amount: _principal });
        poolConfigurator.requestFunds({ principal_: _principal });
    }

    modifier whenCoverIsSufficient() {
        changePrank(users.poolAdmin);
        poolConfigurator.depositCover(defaults.COVER_AMOUNT());
        _;
    }
}
