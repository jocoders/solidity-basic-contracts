// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Counter {
  uint public count;

  function inc() external {
    count += 1;
  }

  function dec() external {
    count -= 1;
  }
}
      