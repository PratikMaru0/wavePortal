// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

// Some magic given to us by Hardhat to do some console logs in our contract. It's actually challenging to debug smart contracts but this is one of the goodies Hardhat gives us to make life easier.
import "hardhat/console.sol";

contract WavePortal{

    uint256 totalWaves;
    address[] arr;

    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string hash;
        string message;
        uint256 timestamp;
    }

    // Declared a variable that lets me store an array of structs.
    Wave[] waves;

    // Here I'm keeping track of the users so that no one can spam and fill my wall with spam messages. 
    mapping(address => uint256) public lastWavedAt;
    
    constructor() payable{
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message,string memory hash) public{

        // We need to make sure the current timestamp is at least 15-minutes bigger than the lasr timestamp we stored 
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp,"Wait atleast 15 minutes");

        // We we are updating timestamp with latest one.
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log('%s posted %s with message %s',msg.sender,hash,_message);
        arr.push(msg.sender);
        // console.log("%s has waved",msg.sender);
        // console.log("The array element push %s ",arr[arr.length-1]);
        waves.push(Wave(msg.sender,hash,_message,block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d",seed);

        if(seed < 50){
            console.log("%s you won",msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance);
            // This part is actually very cool! Its magical this is the line where it will send prizeAmount to the msg.sender (ie:- Our waver) Automatically. 😉
            (bool success,) = (msg.sender).call{value:prizeAmount}("");
            require(success,"Failed to withdraw money from contract.");
        }
        emit NewWave(msg.sender,block.timestamp,_message);
    }

    function getAllWaves() public view returns(Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns(uint256){
        console.log("We have %d total waves 0",totalWaves);
        return totalWaves;
    }



}