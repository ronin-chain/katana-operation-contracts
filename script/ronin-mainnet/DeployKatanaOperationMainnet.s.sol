// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { RouterParameters } from "@katana/operation-contracts/aggregate-router/base/RouterImmutables.sol";
import { UpgradeKatanaGovernance } from "../UpgradeKatanaGovernance.s.sol";

contract DeployKatanaOperationMainnet is UpgradeKatanaGovernance {
  function setUp() public override {
    params = RouterParameters({
      permit2: 0x771CA29e483Df5447E20a89e0F00E1DAF09eF534, // Permit2
      weth9: 0xe514d9DEB7966c8BE0ca922de8a064264eA6bcd4, // WRON
      governance: 0x2C1726346d83cBF848bD3C2B208ec70d32a9E44a, // KatanaGovernance
      v2Factory: 0xB255D6A720BB7c39fee173cE22113397119cB930, // KatanaV2Factory
      v3Factory: 0x1f0B70d9A137e3cAEF0ceAcD312BC5f81Da0cC0c, // KatanaV3Factory
      pairInitCodeHash: 0xe85772d2fe4ad93037659afaee57751696456eb5dd99987e43f3cf11c6e255a2,
      poolInitCodeHash: 0xb381dabeb6037396a764deb39e57a4a3f75b641ce3e9944b1e4b18d036e322e1
    });

    multisig = 0x9D05D1F5b0424F8fDE534BC196FFB6Dd211D902a; // Multisig
    proxyAdmin = 0xA3e7d085E65CB0B916f6717da876b7bE5cC92f03; // ProxyAdmin

    nonfungiblePositionManager = 0x7cF0fb64d72b733695d77d197c664e90D07cF45A; // NonfungiblePositionManager
    v3Migrator = 0x0124c9Ce7E77eD166f6d53AF679B491555b5C0F7; // V3Migrator
    legacyPermissionedRouter = 0xC05AFC8c9353c1dd5f872EcCFaCD60fd5A2a9aC7; // Legacy PermissionedRouter
    katanaGovernanceProxy = 0x2C1726346d83cBF848bD3C2B208ec70d32a9E44a;

    super.setUp();
  }
}
