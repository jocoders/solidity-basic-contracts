// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract CallOtherContracts {
  function setX(TestContract _test, uint _x) external {
    _test.setX(_x);
  }

  function getX(TestContract _test) external view returns (uint) {
    return _test.getX();
  }

  function setXandReceiverEther(address _test, uint _x) external payable {
    TestContract(_test).setXandReceiverEther{value: msg.value }(_x);
  }

  function getXandValue(address _test) external view returns (uint x, uint value) {
    (x, value) = TestContract(_test).getXandValue();
  }
}


contract TestContract {
  uint public x;
  uint public value = 123;

  function setX(uint _x) external {
    x = _x;
  }

  function getX() external view returns (uint) {
    return x;
  }

  function setXandReceiverEther(uint _x) external payable {
    x = _x;
    value = value;
  }

  function getXandValue () external view returns (uint, uint) {
    return (x, value);
  }
}
      