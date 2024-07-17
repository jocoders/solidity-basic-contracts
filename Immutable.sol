// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Immutable {
  // immutable can save gas
  address public immutable owner;

  constructor() {
    owner = msg.sender;
  }

  uint public x; 
  function foo() external {
    require(msg.sender == owner);
    x += 1;
  }
}
      