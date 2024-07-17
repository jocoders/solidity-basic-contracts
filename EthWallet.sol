// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract EthWallet {
  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
  }

  receive() external payable {}

  function withdraw(uint _amount) external {
    require(msg.sender == owner, "caller is not owner");
    payable(msg.sender).transfer(_amount);
  }

  function getBalance() external view returns (uint) {
    return address(this).balance;
  }
}
      