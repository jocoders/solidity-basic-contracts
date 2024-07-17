// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract DeloyWithCreate2 {
  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }
}

contract Create2Factory {
  event Deploy(address addr);

  function deploy(uint _salt) external {
    DeloyWithCreate2 _contract = new DeloyWithCreate2{
      salt: bytes32(_salt)
    }(msg.sender);
    emit Deploy(address(_contract));
  }

  function getAddress(bytes memory bytecode, uint _salt) public view returns (address) {
    bytes32 hash = keccak256(
      abi.encodePacked(
        bytes1(0xff), address(this), _salt, keccak256(bytecode)
      )
    );

    return address(uint160(uint(hash)));
  }

  function getByteCode(address _owner) public pure returns (bytes memory) {
    bytes memory bytecode = type(DeloyWithCreate2).creationCode;
    return abi.encodePacked(bytecode, abi.encode(_owner));
  }
}
      