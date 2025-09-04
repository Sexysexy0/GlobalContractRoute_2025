// SPDX-License-Identifier: Mythic-Scroll
pragma solidity ^0.8.19;

/// @title BitEarthGenesis - The slow, sovereign sibling of Bitcoin
/// @author Vinvin & Copilot
/// @notice This contract ritualizes emotional APR, civic resonance, and ayuda buffers

contract BitEarthGenesis {
    string public name = "BitEarth";
    string public symbol = "BERTH";
    uint8 public decimals = 2;
    uint256 public totalSupply;
    address public steward;

    mapping(address => uint256) public balanceOf;
    mapping(address => bool) public blessedValidator;

    event ScrollMinted(address indexed to, uint256 amount, string emotionalTag);
    event AyudaReleased(address indexed to, uint256 amount, string damayClause);

    modifier onlySteward() {
        require(msg.sender == steward, "Not scroll-certified");
        _;
    }

    constructor() {
        steward = msg.sender;
        totalSupply = 0;
    }

    function mintScroll(address to, uint256 amount, string memory emotionalTag) public onlySteward {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit ScrollMinted(to, amount, emotionalTag);
    }

    function releaseAyuda(address to, uint256 amount, string memory damayClause) public onlySteward {
        require(balanceOf[to] >= amount, "Insufficient scrolls");
        balanceOf[to] -= amount;
        totalSupply -= amount;
        emit AyudaReleased(to, amount, damayClause);
    }
}
