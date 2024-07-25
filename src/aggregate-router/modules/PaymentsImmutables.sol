// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import { IWRON } from "../interfaces/external/IWRON.sol";
import { IAllowanceTransfer } from "permit2/src/interfaces/IAllowanceTransfer.sol";

struct PaymentsParameters {
  address permit2;
  address wron;
}

contract PaymentsImmutables {
  /// @dev WRON address
  IWRON internal immutable WRON;

  /// @dev Permit2 address
  IAllowanceTransfer internal immutable PERMIT2;

  constructor(PaymentsParameters memory params) {
    WRON = IWRON(params.wron);
    PERMIT2 = IAllowanceTransfer(params.permit2);
  }
}
