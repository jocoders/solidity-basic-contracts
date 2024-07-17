// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract DataLocations {
  struct MyStruct {
    uint foo;
    string text;
  }

  mapping(address => MyStruct) public myStructs;

  function examplesMemory(uint[] memory y, string memory s) external returns (MyStruct memory) { 
    myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

    // use storage to update data
    MyStruct storage myStruct = myStructs[msg.sender];
    myStruct.text = "foo";

    // use storage to read data
    MyStruct memory readOnly = myStructs[msg.sender];

    return readOnly;
  }
}
      