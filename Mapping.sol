// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Mapping {
  mapping(address => uint) public balances;
  mapping(address => bool) public inserted;
  address[] public keys;

  mapping(address => mapping(address => bool)) public isFriend;

  function examples() external {
    balances[msg.sender] = 123;
    uint bal = balances[msg.sender];
    uint bal2 = balances[address(1)];

    balances[msg.sender] += 456;

    delete balances[msg.sender];

    isFriend[msg.sender][address(this)] = true;
  }

  function set(address _key, uint _val) external {
    balances[_key] = _val;

    if (!inserted[_key]) {
      inserted[_key] = true;
      keys.push(_key);
    }
  }

  function getSize() external view returns (uint) {
    return keys.length;
  }

  function first() external view returns (uint) {
    return balances[keys[0]];
  }

  function last() external view returns (uint) {
    return balances[keys[keys.length - 1]];
  }

  function getItemByindex(uint _i) external view returns (uint) {
    return balances[keys[_i]];
  }

}
      