// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Payable {
  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
  }

  function deposit() external payable {

  }

  function getBalance() external view returns (uint) {
    return address(this).balance;
  }
}
      