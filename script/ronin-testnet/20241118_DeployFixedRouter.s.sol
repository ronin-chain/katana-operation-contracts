// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { Script, console } from "forge-std/Script.sol";
import { RouterParameters } from "@katana/operation-contracts/aggregate-router/base/RouterImmutables.sol";
import { AggregateRouter } from "@katana/operation-contracts/aggregate-router/AggregateRouter.sol";

contract Migration__20241118_DeployFixedRouter is Script {
  function run() public {
    RouterParameters memory params = RouterParameters({
      permit2: 0xCcf4a457E775f317e0Cf306EFDda14Cc8084F82C,
      weth9: 0xA959726154953bAe111746E265E6d754F48570E6,
      governance: 0x247F12836A421CDC5e22B93Bf5A9AAa0f521f986,
      v2Factory: 0x86587380C4c815Ba0066c90aDB2B45CC9C15E72c,
      v3Factory: 0x4E7236ff45d69395DDEFE1445040A8f3C7CD8819,
      pairInitCodeHash: 0x1cc97ead4d6949b7a6ecb28652b21159b9fd5608ae51a1960224099caab07dca,
      poolInitCodeHash: 0xb381dabeb6037396a764deb39e57a4a3f75b641ce3e9944b1e4b18d036e322e1
    });

    vm.rememberKey(vm.envUint("TESTNET_PK"));
    vm.broadcast();

    address router = address(new AggregateRouter(params));
    console.log("Aggregate Router deployed:", router);
  }
}
