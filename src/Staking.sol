// SPDX-License-Identifier: MIT
pragma solidity = 0.8.17;

import {IDCAHub, IDCAHubPositionHandler} from "../src/interfaces/IDCAHub.sol";
import "forge-std/console.sol";

contract Staking {

  constructor(IDCAHub _hub) {
    IDCAHubPositionHandler.UserPosition memory p = _hub.userPosition(7);
    console.logAddress(address(p.to));
    console.logAddress(address(p.from));
  }

}
