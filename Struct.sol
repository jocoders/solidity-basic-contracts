// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Struct {
   struct Car {
    string model;
    uint year;
    address owner;
   }

   Car public car;
   Car[] public cars;
   mapping(address => Car[]) public carsByOwner;

   function examples() external {
     Car memory toyota = Car("Toyota", 1190, msg.sender);
     Car memory bmw = Car({ model: "3", year: 2024, owner: msg.sender});
     Car memory tesla;
     tesla.model = "Tesla";
     tesla.year = 2025;
     tesla.owner = msg.sender;

     cars.push(toyota); 
     cars.push(bmw); 
     cars.push(tesla); 

     cars.push(Car("Ferrari", 2020, msg.sender));

     Car storage _car = cars[0];
     _car.model;
     _car.year = 1999;
     _car.owner;

     delete _car.owner;
     delete cars[1];

   }


}
      