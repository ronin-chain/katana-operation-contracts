// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { RouterParameters } from "@katana/operation-contracts/aggregate-router/base/RouterImmutables.sol";
import { UpgradeKatanaGovernance } from "../UpgradeKatanaGovernance.s.sol";

contract DeployKatanaOperationMainnet is UpgradeKatanaGovernance {
  function setUp() public override {
    params = RouterParameters({
      permit2: 0x000000000022D473030F116dDEE9F6B43aC78BA3,
      weth9: 0xe514d9DEB7966c8BE0ca922de8a064264eA6bcd4, // WRON
      governance: 0x2C1726346d83cBF848bD3C2B208ec70d32a9E44a,
      v2Factory: 0xB255D6A720BB7c39fee173cE22113397119cB930, // KatanaV2Factory
      v3Factory: address(0), // TODO: To be deployed
      pairInitCodeHash: 0xe85772d2fe4ad93037659afaee57751696456eb5dd99987e43f3cf11c6e255a2,
      poolInitCodeHash: 0x90d38463811f82243daaae5a54acd3ee61bdfb1d1d217b3ddab704257da37936
    });

    proxyAdmin = 0xA3e7d085E65CB0B916f6717da876b7bE5cC92f03; // Proxy Admin

    nonfungiblePositionManager = address(0); // TODO: To be deployed
    katanaGovernanceProxy = 0x2C1726346d83cBF848bD3C2B208ec70d32a9E44a;

    vm.rememberKey(vm.envUint("MAINNET_PK"));

    super.setUp();
  }
}
