// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Banking {
    mapping(address => uint) private balances;
    mapping(address => bool) private accounts;

    function createAccount() public payable {
        require(!accounts[msg.sender], "Account already exists");
        accounts[msg.sender] = true;
        balances[msg.sender] = msg.value;
    }

    function deposit() public payable {
        require(accounts[msg.sender], "Account does not exist");
        require(msg.value > 0, "Deposit must be greater than zero");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(accounts[msg.sender], "Account does not exist");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Withdrawal must be greater than zero");
        
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    function transfer(address to, uint amount) public {
        require(accounts[msg.sender], "Account does not exist");
        require(accounts[to], "Recipient account does not exist");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Transfer amount must be greater than zero");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function accountExists() public view returns (bool) {
        return accounts[msg.sender];
    }
}
