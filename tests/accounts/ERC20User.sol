// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.19;

import { IERC20Permit } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20User {
    function erc20_approve(address token_, address spender_, uint256 amount_) external {
        IERC20(token_).approve(spender_, amount_);
    }

    function erc20_permit(
        address token_,
        address owner_,
        address spender_,
        uint256 amount_,
        uint256 deadline_,
        uint8 v_,
        bytes32 r_,
        bytes32 s_
    )
        external
    {
        IERC20Permit(token_).permit(owner_, spender_, amount_, deadline_, v_, r_, s_);
    }

    function erc20_transfer(address token_, address recipient_, uint256 amount_) external returns (bool success_) {
        return IERC20(token_).transfer(recipient_, amount_);
    }

    function erc20_transferFrom(
        address token_,
        address owner_,
        address recipient_,
        uint256 amount_
    )
        external
        returns (bool success_)
    {
        return IERC20(token_).transferFrom(owner_, recipient_, amount_);
    }
}
