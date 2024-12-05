// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    // Array lưu trữ tên album đã phê duyệt
    string[] public approvedRecords;

    // Mapping cho người dùng và danh sách album yêu thích của họ
    mapping(address => mapping(string => bool)) public userFavorites;
    
    // Custom error khi album không được phê duyệt
    error NotApproved(string recordName);

    // Constructor để khởi tạo các album phê duyệt
    constructor() {
        approvedRecords.push("Thriller");
        approvedRecords.push("Back in Black");
        approvedRecords.push("The Bodyguard");
        approvedRecords.push("The Dark Side of the Moon");
        approvedRecords.push("Their Greatest Hits (1971-1975)");
        approvedRecords.push("Hotel California");
        approvedRecords.push("Come On Over");
        approvedRecords.push("Rumours");
        approvedRecords.push("Saturday Night Fever");
    }
    
    // Function để lấy danh sách album đã phê duyệt
    function getApprovedRecords() public view returns (string[] memory) {
        return approvedRecords;
    }
    
    // Function để thêm album vào danh sách yêu thích của người dùng
    function addRecord(string calldata _albumName) public {
        bool isApproved = false;
        
        // Kiểm tra album có được phê duyệt không
        for (uint i = 0; i < approvedRecords.length; i++) {
            if (keccak256(bytes(approvedRecords[i])) == keccak256(bytes(_albumName))) {
                isApproved = true;
                break;
            }
        }
        
        // Nếu không phê duyệt, revert giao dịch với lỗi
        if (!isApproved) {
            revert NotApproved(_albumName);
        }
        
        // Đánh dấu album là yêu thích cho người dùng
        userFavorites[msg.sender][_albumName] = true;
    }
    
    // Function để lấy danh sách album yêu thích của một người dùng
    function getUserFavorites(address _user) public view returns (string[] memory) {
        uint256 count = 0;
        
        // Đếm số lượng album yêu thích của người dùng
        for (uint i = 0; i < approvedRecords.length; i++) {
            if (userFavorites[_user][approvedRecords[i]]) {
                count++;
            }
        }

        // Khởi tạo mảng để lưu các album yêu thích
        string[] memory favorites = new string[](count);
        uint256 index = 0;
        
        // Lưu các album yêu thích vào mảng
        for (uint i = 0; i < approvedRecords.length; i++) {
            if (userFavorites[_user][approvedRecords[i]]) {
                favorites[index] = approvedRecords[i];
                index++;
            }
        }
        return favorites;
    }
    
    // Function để reset danh sách yêu thích của người dùng
    function resetUserFavorites() public {
        for (uint i = 0; i < approvedRecords.length; i++) {
            userFavorites[msg.sender][approvedRecords[i]] = false;
        }
    }
}
