// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import { ERC721Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import { ERC721EnumerableUpgradeable } from
    "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import { ERC721BurnableUpgradeable } from
    "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { UUPSUpgradeable } from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

import { Errors } from "./libraries/Errors.sol";
import { Receivable as RCV } from "./libraries/types/DataTypes.sol";

import { IIsleGlobals } from "./interfaces/IIsleGlobals.sol";
import { IReceivable } from "./interfaces/IReceivable.sol";
import { IGovernable } from "./interfaces/IGovernable.sol";

import { Governable } from "./abstracts/Governable.sol";
import { ReceivableStorage } from "./ReceivableStorage.sol";

contract Receivable is
    ReceivableStorage,
    Initializable,
    ERC721Upgradeable,
    ERC721EnumerableUpgradeable,
    ERC721BurnableUpgradeable,
    UUPSUpgradeable,
    Governable,
    IReceivable
{
    /*//////////////////////////////////////////////////////////////////////////
                            UUPS FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    function _authorizeUpgrade(address newImplementation) internal override onlyGovernor { }

    /// @custom:oz-upgrades-unsafe-allow constructor
    // constructor() {
    // _disableInitializers();
    // }

    /// @inheritdoc IReceivable
    function initialize(address initialGovernor_) external override initializer {
        __ERC721_init("Receivable", "RECV");
        __ERC721Enumerable_init();
        __ERC721Burnable_init();

        governor = initialGovernor_;
        emit IGovernable.TransferGovernor({ oldGovernor: address(0), newGovernor: initialGovernor_ });
    }

    /// @inheritdoc IReceivable
    function createReceivable(RCV.Create calldata params_) external override returns (uint256 tokenId_) {
        tokenId_ = _tokenIdCounter;
        _tokenIdCounter += 1;

        idToReceivableInfo[tokenId_] = RCV.Info({
            buyer: params_.buyer,
            seller: params_.seller,
            faceAmount: params_.faceAmount,
            repaymentTimestamp: params_.repaymentTimestamp,
            currencyCode: params_.currencyCode,
            isValid: true
        });

        _safeMint(params_.seller, tokenId_);
        emit AssetCreated(params_.buyer, params_.seller, tokenId_, params_.faceAmount, params_.repaymentTimestamp);

        return tokenId_;
    }

    /// @inheritdoc IReceivable
    function getReceivableInfoById(uint256 tokenId_) external view override returns (RCV.Info memory info_) {
        info_ = idToReceivableInfo[tokenId_];
    }

    function burnReceivable(uint256 tokenId_) external {
        ERC721BurnableUpgradeable.burn(tokenId_);
        emit AssetBurned(tokenId_);
    }

    // The following functions are overrides required by Solidity.

    /// @dev Hook that is called before any token transfer.
    /// @notice not support batch transfer
    function _beforeTokenTransfer(
        address from_,
        address to_,
        uint256 tokenId_,
        uint256 batchSize_
    )
        internal
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
    {
        super._beforeTokenTransfer(from_, to_, tokenId_, batchSize_);
    }

    /// @inheritdoc ERC721Upgradeable
    function supportsInterface(bytes4 interfaceId_)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId_);
    }
}
