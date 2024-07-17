// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

/*
Fallback executed when:
- function doesn't exist 
- directly send ETH
*/
contract Fallback {
  event Log(string func, address sender, uint value, bytes data);

  fallback() external payable { 
    emit Log("fallback", msg.sender, msg.value, msg.data);
  } 

  receive() external payable { 
    emit Log("fallback", msg.sender, msg.value, "");
  } 
}
      