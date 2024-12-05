// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GarageManager {
    // Define the Car struct
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    // Mapping to store a list of cars for each address
    mapping(address => Car[]) public garage;

    // Custom error for invalid car index
    error BadCarIndex(uint index);

    // Function to add a car to the user's garage
    function addCar(string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        Car memory newCar = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });

        garage[msg.sender].push(newCar);
    }

    // Function to get all cars for the calling user
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // Function to get all cars for any given user
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    // Function to update a car for the calling user
    function updateCar(uint _index, string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        // Check if the user has a car at the given index
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        // Update the car at the specified index
        Car storage carToUpdate = garage[msg.sender][_index];
        carToUpdate.make = _make;
        carToUpdate.model = _model;
        carToUpdate.color = _color;
        carToUpdate.numberOfDoors = _numberOfDoors;
    }

    // Function to reset the garage for the calling user
    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}
