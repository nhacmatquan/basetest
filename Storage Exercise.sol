// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeStorage {
    // State Variables
    uint32 private salary; // Private variable for salary (0-1,000,000)
    uint16 private shares; // Private variable for shares (0-5000)
    string public name;    // Public variable for employee name
    uint256 public idNumber; // Public variable for employee ID number

    // Custom Error
    error TooManyShares(uint16 newTotalShares);

    // Constructor
    constructor(uint16 _shares, string memory _name, uint32 _salary, uint256 _idNumber) {
        require(_shares <= 5000, "Too many shares");
        require(_salary <= 1_000_000, "Invalid salary");

        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    // Function to view the salary
    function viewSalary() public view returns (uint32) {
        return salary;
    }

    // Function to view the shares
    function viewShares() public view returns (uint16) {
        return shares;
    }

    // Function to grant shares
    function grantShares(uint16 _newShares) public {
        uint16 newTotalShares = shares + _newShares;

        if (_newShares > 5000) {
            revert("Too many shares");
        }

        if (newTotalShares > 5000) {
            revert TooManyShares(newTotalShares);
        }

        shares = newTotalShares;
    }

    // Packing Debug Functions
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}


