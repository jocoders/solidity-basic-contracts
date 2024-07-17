// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;



interface ICounter {
  function count() external view returns (uint);
  function inc() external;
}

contract CallInterface {
  uint public count;

  function examples(address _counter) external {
    ICounter(_counter).inc();
    ICounter(_counter).count();
  }
}
      