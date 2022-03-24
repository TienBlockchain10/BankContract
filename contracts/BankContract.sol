// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

contract Bank {

    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance;

    constructor() {
        bankOwner = msg.sender;
    }

    function setBankName(string memory _bank) external {
        require(msg.sender == bankOwner, "Only the owner may change the bank name!");
        bankName = _bank;
    }

    function depositMoney() public payable {
        require(msg.value != 0, "You must put a number besides 0");
        customerBalance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _total) public {
        require(customerBalance[msg.sender] >= _total, "You don't have enough funds to withdraw");
        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getCustomerBalance() public view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function getBankBalance() public view returns (uint256) {
        require(msg.sender == bankOwner, "You aint the owner bruh, only owner can view this");
        return address(this).balance;
    }
}