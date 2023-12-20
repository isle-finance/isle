// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { LoanManager_Integration_Shared_Test } from "./LoanManager.t.sol";

abstract contract Callable_Integration_Shared_Test is LoanManager_Integration_Shared_Test {
    function setUp() public virtual override {
        changePrank(users.poolAdmin);
    }

    modifier whenNotPaused() {
        _;
    }

    modifier whenCallerPoolAdminOrGovernor() {
        changePrank({ msgSender: users.poolAdmin });
        _;
    }
}
