// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract SimpleStorage {
  string public text;

  function set(string calldata _text) external {
    text = _text;
  }

  function get() external view returns (string memory) {
    return text;
  }

}
      