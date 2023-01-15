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
address constant WETH               = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant USDC               = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
address constant USDC_WHALE         = 0x28C6c06298d514Db089934071355E5743bf21d60;

contract StakingTest is Test {

  Staking public staking;

  function setUp() public {
    staking = new Staking(
      IDCAHub(HUB),
      IDCAPermissionManager(PERMISSION_MANAGER),
      IERC20(USDC), 
      IERC20(WETH), 
      1000,         // minAmount
      1 days,       // duration
      IERC20(USDC), // rewardToken
      40            // reward
    );
  }

  function testStake() public {
    uint AMOUNT = 1000;

    vm.prank(USDC_WHALE);
    IERC20(USDC).transfer(address(this), AMOUNT*2);

    IERC20(USDC).approve(address(staking), AMOUNT);
    staking.addReward(AMOUNT);

    vm.prank(address(this));
    IERC20(USDC).approve(address(HUB), AMOUNT);

    uint positionId = IDCAHub(HUB).deposit(
      USDC,
      WETH,
      AMOUNT,
      uint32(10),    // amountOfSwaps
      1 days,        // swapInterval
      address(this), // owner
      new IDCAPermissionManager.PermissionSet[](0)
    );

    IDCAPermissionManager(PERMISSION_MANAGER).approve(
      address(staking),
      positionId
    );

    staking.stake(positionId);

    vm.warp(block.timestamp + 1 days);
    staking.unstake(positionId);
  }
}

