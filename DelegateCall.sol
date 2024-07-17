// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract TestDelegateCall {
   uint public num;
   uint public value;
   address public sender;

   function setVars(uint _num) external payable {
     num = _num;
     sender = msg.sender;
     value = msg.value;
   }
}

contract DelegateCall {
   uint public num;
   uint public value;
   address public sender;

   function setVars(address _test, uint _num) external payable {
    // _test.delegatecall(
    //   abi.encodeWithSignature("setVars(uint256)", _num)
    // );
      num = 2 * num;
      (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num));
      require(success, "delegatecall failed");
   }  
}
      