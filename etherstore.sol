// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;


contract EtherStore {
    mapping (address => uint) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    } 
}

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) public {
        etherStore = EtherStore(_etherStoreAddress);
    }

    function attack() external payable{
        etherStore.deposit{value: 1 ether}();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    } 
}
