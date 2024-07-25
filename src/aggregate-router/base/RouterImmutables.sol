// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

struct RouterParameters {
  address permit2;
  address wron;
  address v2Factory;
  address v3Factory;
  bytes32 pairInitCodeHash;
  bytes32 poolInitCodeHash;
}
