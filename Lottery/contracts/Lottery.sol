// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0<0.9.0;
contract Lottery{
    address public manager;
    address payable[] public players;
    constructor(){
        manager=msg.sender;
    }
    function invest() external payable{
        require(msg.value>=1 ether,"Minium amount is 1 ether");
        players.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function random() private view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
    function selectWinner() public returns(address payable){
        require(manager==msg.sender,"only manager can call this function");
     uint r=random();
     uint index=r%players.length;
     address payable winner=players[index];
     winner.transfer(getBalance());
     return winner;
    }

}