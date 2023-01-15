// SPDX-License-Identifier: MIT
pragma solidity = 0.8.17;

import "forge-std/Test.sol";
import {Staking} from "../src/Staking.sol";
import {IDCAHub} from "../src/interfaces/IDCAHub.sol";

contract StakingTest is Test {
  address HUB = 0xA5AdC5484f9997fBF7D405b9AA62A7d88883C345;

  function setUp() public {
    new Staking(IDCAHub(HUB));
  }

  function testStake() public {
    assertTrue(true);
  }
}

