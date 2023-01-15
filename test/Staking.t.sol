// SPDX-License-Identifier: MIT
pragma solidity = 0.8.17;

import "forge-std/Test.sol";
import {Staking} from "../src/Staking.sol";
import {IDCAHub} from "../src/interfaces/IDCAHub.sol";
import {IDCAPermissionManager} from "../src/interfaces/IDCAPermissionManager.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";

address constant HUB                = 0xA5AdC5484f9997fBF7D405b9AA62A7d88883C345;
address constant PERMISSION_MANAGER = 0x20bdAE1413659f47416f769a4B27044946bc9923;
address constant REWARD_TOKEN       = 0xA5AdC5484f9997fBF7D405b9AA62A7d88883C345;

contract StakingTest is Test {

  Staking public staking;

  function setUp() public {
    staking = new Staking(
      IDCAHub(HUB),
      IDCAPermissionManager(PERMISSION_MANAGER),
      IERC20(REWARD_TOKEN)
    );
  }

  function testStake() public {
    // staking.hub.
    assertTrue(true);
  }
}

