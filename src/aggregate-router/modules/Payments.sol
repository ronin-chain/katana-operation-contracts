// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import { Constants } from "../libraries/Constants.sol";
import { PaymentsImmutables } from "../modules/PaymentsImmutables.sol";
import { SafeTransferLib } from "solmate/src/utils/SafeTransferLib.sol";
import { ERC20 } from "solmate/src/tokens/ERC20.sol";

/// @title Payments contract
/// @notice Performs various operations around the payment of RON and tokens
abstract contract Payments is PaymentsImmutables {
  using SafeTransferLib for ERC20;
  using SafeTransferLib for address;

  error InsufficientToken();
  error InsufficientRON();
  error InvalidBips();
  error InvalidSpender();

  uint256 internal constant FEE_BIPS_BASE = 10_000;

  /// @notice Pays an amount of RON or ERC20 to a recipient
  /// @param token The token to pay (can be RON using Constants.RON)
  /// @param recipient The address that will receive the payment
  /// @param value The amount to pay
  function pay(address token, address recipient, uint256 value) internal {
    if (token == Constants.RON) {
      recipient.safeTransferETH(value);
    } else {
      if (value == Constants.CONTRACT_BALANCE) {
        value = ERC20(token).balanceOf(address(this));
      }

      ERC20(token).safeTransfer(recipient, value);
    }
  }

  /// @notice Pays a proportion of the contract's RON or ERC20 to a recipient
  /// @param token The token to pay (can be RON using Constants.RON)
  /// @param recipient The address that will receive payment
  /// @param bips Portion in bips of whole balance of the contract
  function payPortion(address token, address recipient, uint256 bips) internal {
    if (bips == 0 || bips > FEE_BIPS_BASE) revert InvalidBips();
    if (token == Constants.RON) {
      uint256 balance = address(this).balance;
      uint256 amount = (balance * bips) / FEE_BIPS_BASE;
      recipient.safeTransferETH(amount);
    } else {
      uint256 balance = ERC20(token).balanceOf(address(this));
      uint256 amount = (balance * bips) / FEE_BIPS_BASE;
      ERC20(token).safeTransfer(recipient, amount);
    }
  }

  /// @notice Sweeps all of the contract's ERC20 or RON to an address
  /// @param token The token to sweep (can be RON using Constants.RON)
  /// @param recipient The address that will receive payment
  /// @param amountMinimum The minimum desired amount
  function sweep(address token, address recipient, uint256 amountMinimum) internal {
    uint256 balance;
    if (token == Constants.RON) {
      balance = address(this).balance;
      if (balance < amountMinimum) revert InsufficientRON();
      if (balance > 0) recipient.safeTransferETH(balance);
    } else {
      balance = ERC20(token).balanceOf(address(this));
      if (balance < amountMinimum) revert InsufficientToken();
      if (balance > 0) ERC20(token).safeTransfer(recipient, balance);
    }
  }

  /// @notice Wraps an amount of RON into WRON
  /// @param recipient The recipient of the WRON
  /// @param amount The amount to wrap (can be CONTRACT_BALANCE)
  function wrapRON(address recipient, uint256 amount) internal {
    if (amount == Constants.CONTRACT_BALANCE) {
      amount = address(this).balance;
    } else if (amount > address(this).balance) {
      revert InsufficientRON();
    }
    if (amount > 0) {
      WRON.deposit{ value: amount }();
      if (recipient != address(this)) {
        WRON.transfer(recipient, amount);
      }
    }
  }

  /// @notice Unwraps all of the contract's WRON into RON
  /// @param recipient The recipient of the RON
  /// @param amountMinimum The minimum amount of RON desired
  function unwrapWRON(address recipient, uint256 amountMinimum) internal {
    uint256 value = WRON.balanceOf(address(this));
    if (value < amountMinimum) {
      revert InsufficientRON();
    }
    if (value > 0) {
      WRON.withdraw(value);
      if (recipient != address(this)) {
        recipient.safeTransferETH(value);
      }
    }
  }
}
