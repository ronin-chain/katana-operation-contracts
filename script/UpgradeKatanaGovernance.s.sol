// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { Script, console } from "forge-std/Script.sol";
import { ITransparentUpgradeableProxy } from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import { KatanaGovernance } from "@katana/operation-contracts/governance/KatanaGovernance.sol";
import { ProxyAdmin } from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import { ISpenderPermit } from "permit2/src/interfaces/ISpenderPermit.sol";
import { DeployAggregateRouter } from "./DeployAggregateRouter.s.sol";

abstract contract UpgradeKatanaGovernance is DeployAggregateRouter {
  address public nonfungiblePositionManager;
  address public v3Migrator;
  address public legacyPermissionedRouter;
  address public katanaGovernanceProxy;
  address public multisig;
  address public proxyAdmin;

  address public katanaGovernanceLogic;

  function setUp() public virtual override {
    require(nonfungiblePositionManager != address(0));
    require(v3Migrator != address(0));
    require(legacyPermissionedRouter != address(0));
    require(katanaGovernanceProxy != address(0));
    require(multisig != address(0));
    require(proxyAdmin != address(0));

    super.setUp();
  }

  function run() public override {
    super.run();

    vm.broadcast();
    katanaGovernanceLogic = address(new KatanaGovernance());
    console.log("Katana Governance (logic) deployed:", katanaGovernanceLogic);
    console.log("");

    console.log("----------------------------------------------------------------");
    console.log("[Proposal] Upgrade to Katana Governance");
    console.log("From:", multisig);
    console.log("To:", proxyAdmin);
    console.log(
      "Data:",
      vm.toString(
        abi.encodeCall(
          ProxyAdmin.upgradeAndCall,
          (
            ITransparentUpgradeableProxy(katanaGovernanceProxy),
            katanaGovernanceLogic,
            abi.encodeCall(
              KatanaGovernance.initializeV2,
              (params.v3Factory, nonfungiblePositionManager, v3Migrator, legacyPermissionedRouter, router)
            )
          )
        )
      )
    );
    console.log("");

    console.log("----------------------------------------------------------------");
    console.log("[Proposal] Set AggregateRouter as a permitted spender in Permit2");
    console.log("From:", multisig);
    console.log("To:", params.permit2);
    console.log("Data:", vm.toString(abi.encodeCall(ISpenderPermit.permitSpender, (router, true))));
  }

  function logParams() internal view override {
    console.log("nonfungiblePositionManager:", nonfungiblePositionManager);
    console.log("v3Migrator:", v3Migrator);
    console.log("legacyPermissionedRouter:", legacyPermissionedRouter);
    console.log("katanaGovernanceProxy:", katanaGovernanceProxy);
    console.log("proxyAdmin:", proxyAdmin);
  }
}
