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

  mapping (uint => address) public idToOwner; // owner of staking position

  modifier onlyOwner(uint id) {
    require(idToOwner[id] == msg.sender, "Staking: not owner");
    _;
  }

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
    idToOwner[tokenId] = msg.sender;
  }

  function claim(uint tokenId) external onlyOwner(tokenId) {

  }

  function unstake(uint tokenId) external onlyOwner(tokenId) {

  }

  function _calculateReward(uint tokenId) internal view returns (uint) {
    return 0;
  }

  // function getPos() public {
  //     // IDCAHubPositionHandler.UserPosition memory p = _hub.userPosition(7);
  //     // console.logAddress(address(p.to));
  //     // console.logAddress(address(p.from));
  // }
}
