// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract GasGolf {
  // start - 50760 gas
  // use calldata - 49076 gas
  // load state variables to memory - 48952 gas
  // short circuit - 48531 gas
  // loop increments - 47457 gas
  // cache array length - 47421 gas
  // load array elements to memory - 47253 gas

  uint public total;

  // [1, 2, 3, 4, 5, 100]

  // EXPENSIVE:
  // function sumIfEventAndLessThan99(uint[] memory nums) external {
  //   for (uint i = 0; i < nums.length; i += 1) {
  //     bool isEven = nums[i] % 2 == 0;
  //     bool isLessThan99 = nums[i] < 99;
  //     if (isEven && isLessThan99) {
  //       total += nums[1];
  //     }
  //   }
  // }

  // CHEAPER:
  function sumIfEventAndLessThan99Cheaper(uint[] calldata nums) external {
    uint _total = total;
    uint length = nums.length;

    for (uint i = 0; i < length; ++i) {
      uint num = nums[i];
      if (num % 2 == 0 && num < 99) {
        _total += num;
      }
    }

    total = _total;
  }
}
      