// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Ownable {
  address public owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
  }

  function setOwner(address _newOwner) external onlyOwner {
    require(_newOwner != address(0), "invalid address");
    owner = _newOwner;
  }
}
      