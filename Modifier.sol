// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Modidfier {
  bool public paused;
  uint public count;

  function setPause(bool _paused) external {
    paused = _paused;
  }

  modifier whenNotPaused() {
    require(!paused, "paused");
    _; // means modifier
  }

  function inc() external whenNotPaused {
    count += 1;
  }

    function dec() external whenNotPaused {
    count -= 1;
  }
}
      