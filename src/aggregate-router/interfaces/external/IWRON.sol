// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Interface for WRON
interface IWRON is IERC20 {
  /// @notice Deposit RON to get wrapped RON
  function deposit() external payable;

  /// @notice Withdraw wrapped RON to get RON
  function withdraw(uint256) external;
}
