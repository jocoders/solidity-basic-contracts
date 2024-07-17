// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Event {
  event Log(string message, uint val);
  // up to 3 index
  event IndexedLog(address indexed sender, uint val);

  // it is transactional function
  function example() external {
    emit Log("foo", 12345);
    emit IndexedLog(msg.sender, 789);
  }

  event Message(address indexed _from, address indexed _to, string message);

  function sendMessage(address _to, string calldata message) external {
    emit Message(msg.sender, _to, message);
  }
}
      