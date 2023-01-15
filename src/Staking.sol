// SPDX-License-Identifier: MIT
pragma solidity = 0.8.17;

import {IDCAHub, IDCAHubPositionHandler as PositionHandler} from "../src/interfaces/IDCAHub.sol";
import {IDCAPermissionManager} from "../src/interfaces/IDCAPermissionManager.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";
import "forge-std/console.sol";

contract Staking {
  IDCAHub               public immutable hub;
  IDCAPermissionManager public immutable permissionManager;
  IERC20                public immutable fromToken;
  IERC20                public immutable toToken;
  uint                  public immutable minAmount;
  uint                  public immutable duration;
  IERC20                public immutable rewardToken;
  uint                  public immutable reward;

  mapping (uint => address) public idToOwner;        // owner of staking position
  mapping (uint => uint)    public idToStakingStart; 

  modifier onlyOwner(uint id) {
    require(idToOwner[id] == msg.sender, "Staking: not owner");
    _;
  }

  constructor(
      IDCAHub               _hub,
      IDCAPermissionManager _permissionManager,
      IERC20                _fromToken, 
      IERC20                _toToken, 
      uint                  _minAmount, 
      uint                  _duration, 
      IERC20                _rewardToken, 
      uint                  _reward
  ) {
      hub               = _hub;
      permissionManager = _permissionManager;
      toToken           = _toToken;
      fromToken         = _fromToken;
      minAmount         = _minAmount;
      duration          = _duration;
      rewardToken       = _rewardToken;
      reward            = _reward;
  }

  function addReward(uint amount) external {
    rewardToken.transferFrom(msg.sender, address(this), amount);
  }

  function stake(uint tokenId) external {
      PositionHandler.UserPosition memory position = hub.userPosition(tokenId);
      require(address(position.from) == address(fromToken));
      require(address(position.to)   == address(toToken));
      require(position.swapInterval * position.swapsLeft >= duration);
      require(position.remaining >= minAmount);
      permissionManager.transferFrom(msg.sender, address(this), tokenId);

      idToStakingStart[tokenId] = block.timestamp;
      idToOwner       [tokenId] = msg.sender;
  }

  function unstake(uint tokenId) external onlyOwner(tokenId) {
      require(block.timestamp >= idToStakingStart[tokenId]);
      permissionManager.transferFrom(address(this), msg.sender, tokenId);
      rewardToken.transfer(msg.sender, reward);
  }
}
