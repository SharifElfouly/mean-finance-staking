// SPDX-License-Identifier: MIT
pragma solidity = 0.8.17;

import {IDCAHub, IDCAHubPositionHandler} from "../src/interfaces/IDCAHub.sol";
import {IDCAPermissionManager} from "../src/interfaces/IDCAPermissionManager.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";
import "forge-std/console.sol";

contract Staking {
  IDCAHub               public immutable hub;
  IDCAPermissionManager public immutable permissionManager;
  IERC20                public immutable rewardToken;

  constructor(
      IDCAHub               _hub,
      IDCAPermissionManager _permissionManager,
      IERC20               _rewardToken
  ) {
      hub               = _hub;
      permissionManager = _permissionManager;
      rewardToken       = _rewardToken;
  }

  function stake(uint tokenId) external {
    permissionManager.transferFrom(msg.sender, address(this), tokenId);

  }

  function claim() external {

  }

  function unstake() external {

  }

  // function getPos() public {
  //     // IDCAHubPositionHandler.UserPosition memory p = _hub.userPosition(7);
  //     // console.logAddress(address(p.to));
  //     // console.logAddress(address(p.from));
  // }
}
