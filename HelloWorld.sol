// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract HelloWorld {
  // Base types:
  string public myString = "hello world";
  bool public b = true;
  uint public u = 123; 
  int public minInt = type(int).min;
  int public maxInt = type(int).max;
  address public addr = 0xb794F5eA0ba39494cE839613fffBA74279579268;
  bytes32 public b32 = 0x7465737400000000000000000000000000000000000000000000000000000000; 

  // Defalt values:
  bool public isPaid; // false
  uint public dU; // 0
  uint public dI; // 0

  // Constant varibale -> save gas
  int public constant RATIO = 78;

  uint public myUint = 123;

  function add(uint x, uint y) external pure returns(uint) {
    return x + y;
  }

  function sub(uint x, uint y) external pure returns(uint) {
    return x - y;
  }

  function globalVars() external view returns(address, uint, uint) {
    address sender = msg.sender;
    uint timestamp = block.timestamp;
    uint blockNum = block.number; 

    return (sender, timestamp, blockNum);
  }

  function viewFunc() external view returns (uint) {
    return u;
  }

  function pureFunc() external pure returns (uint) {
    return 78;
  }

  function loops() external pure {
    for (uint i = 0; i < 10; i++) {
      if (i == 3) {
        continue;
      }
      if (i == 5) {
        break;
      }
      
    }

    uint j = 0;

    while (j < 10) {
      j++;
    }
  }

  function sum(uint _n) external pure returns (uint) {
    uint s;
    for (uint i = 1; i <= _n; i++) {
      s += i;
    }

    return s;
  }

  // Errors - require, revert, assert
  // custom error - save gas
  function testRquire(uint _i) public pure {
    require(_i <= 10, "I less than 10");
  }
  function testRevert(uint _i) public pure {
    if (_i > 10) {
      revert("I grater than 10");
    }
  }
  error myError(address caller, uint i);
  function testCustomError(uint _i) public view {
    if (_i > 10) {
      revert myError(msg.sender, _i);
    }
  }
}
