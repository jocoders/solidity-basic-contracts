// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Array {
  uint[] public nums = [1, 2, 3, 4, 5];
  uint[3] public numsFixed = [4, 5, 6];

  function examples() external {
    nums.push(4);
    nums[1]; 
    uint x = nums[1];
    nums[2] = 77;
    delete nums[1]; // make to 0 the first item

    nums.pop(); // remove last item
    uint length = nums.length;

    // create array in memory, have to be with fixed size
    uint[] memory a = new uint[](5);
  }

  // Remove element from array
  function remove(uint _index) public {
    require(_index < nums.length, "index out of bound");

    for (uint i = _index; i < nums.length - 1; i++) {
      nums[i] = nums[i + 1];
    }
    nums.pop();
  }

  // Remove array element by shifting elements to the left
  function remove2(uint _index) public {
    nums[_index] = nums[nums.length - 1];
    nums.pop();
  }
}
      