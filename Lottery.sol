//SPDX-License-Identifier: GPL-3.0
//Roy D Gregori Ayon - 201830011, Md. Mahadi Hasan - 201810157

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{

    address public manager;
    address payable[] public players;


    constructor(){
        manager = msg.sender; //global variable
    }

    receive () external payable{
        require(msg.value==1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function selectWinner() public{
        require(msg.sender==manager);
        require (players.length >= 3);

        uint r=random();
        address payable winner;
        uint index = r % players.length;
        winner=players[index];
        winner.transfer(getBalance());
    }

    // function selectWinner() public view returns(address){
    //     require(msg.sender==manager);
    //     require (players.length >= 3);

    //     uint r=random();
    //     address payable winner;
    //     uint index = r % players.length;
    //     winner=players[index];
    //     return winner;

    //     // winner.transfer(getBalance());
    // }

}