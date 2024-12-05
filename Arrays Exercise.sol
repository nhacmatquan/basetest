// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraysExercise {
    // Mảng numbers chứa các số từ 1 đến 10
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    // Mảng lưu trữ địa chỉ của người gửi
    address[] public senders;
    // Mảng lưu trữ dấu thời gian (timestamp)
    uint[] public timestamps;

    // Hàm trả về toàn bộ mảng numbers
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    // Hàm reset lại mảng numbers về giá trị ban đầu (1 đến 10)
    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    // Hàm thêm mảng _toAppend vào mảng numbers
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // Hàm lưu trữ địa chỉ người gửi và dấu thời gian
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);       // Lưu địa chỉ người gửi
        timestamps.push(_unixTimestamp); // Lưu dấu thời gian
    }

    // Hàm lọc các dấu thời gian sau năm 2000 và trả về các địa chỉ người gửi tương ứng
    function afterY2K() public view returns (uint[] memory validTimestamps, address[] memory validSenders) {
        uint count = 0;
        
        // Đếm số lượng timestamps sau Y2K
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) { // Dấu thời gian của ngày 01/01/2000 00:00:00 (946702800)
                count++;
            }
        }

        // Khởi tạo các mảng với kích thước đúng
        validTimestamps = new uint[](count);
        validSenders = new address[](count);
        
        // Lọc các timestamps và addresses hợp lệ
        uint index = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                validTimestamps[index] = timestamps[i];
                validSenders[index] = senders[i];
                index++;
            }
        }

        return (validTimestamps, validSenders);
    }

    // Hàm reset lại mảng senders
    function resetSenders() public {
        delete senders;
    }

    // Hàm reset lại mảng timestamps
    function resetTimestamps() public {
        delete timestamps;
    }
}
