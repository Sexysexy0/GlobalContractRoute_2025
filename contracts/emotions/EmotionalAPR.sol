// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmotionalAPR {
    address public owner;

    mapping(address => uint256) public aprScores;
    mapping(address => string) public sanctumNotes;

    event APRUpdated(address sanctum, uint256 score, string note);

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized scrollsmith");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function updateAPR(address sanctum, uint256 score, string memory note) public onlyOwner {
        require(score <= 100, "APR must be <= 100");
        aprScores[sanctum] = score;
        sanctumNotes[sanctum] = note;
        emit APRUpdated(sanctum, score, note);
    }

    function getAPR(address sanctum) public view returns (uint256, string memory) {
        return (aprScores[sanctum], sanctumNotes[sanctum]);
    }
}
