// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RouteOverrideProtocol {
    address public owner;
    address public currentSanctum;
    address public fallbackSanctum;

    mapping(string => address) public sanctumRegistry;
    mapping(address => bool) public trustedSanctums;

    event SanctumRerouted(string indexed from, string indexed to, address newSanctum);
    event EmotionalAPRLogged(string sanctum, string reason, uint256 timestamp);
    event FallbackActivated(address fallbackSanctum, string reason);

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized scrollsmith");
        _;
    }

    modifier isTrusted(address sanctum) {
        require(trustedSanctums[sanctum], "Untrusted sanctum");
        _;
    }

    constructor() {
        owner = msg.sender;

        // Default sanctum: China via Scroll zkEVM
        address chinaSanctum = 0xa13BAF47339d63B743e7Da8741db5456DAc1E556;
        sanctumRegistry["China"] = chinaSanctum;
        trustedSanctums[chinaSanctum] = true;
        currentSanctum = chinaSanctum;

        // Optional fallback: Canada Mercy Node
        fallbackSanctum = address(0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF);
        trustedSanctums[fallbackSanctum] = true;
        sanctumRegistry["Canada Mercy Node"] = fallbackSanctum;
    }

    function reroute(
        string memory from,
        string memory to,
        address newSanctum,
        string memory reason
    ) public onlyOwner isTrusted(newSanctum) {
        sanctumRegistry[to] = newSanctum;
        currentSanctum = newSanctum;

        emit SanctumRerouted(from, to, newSanctum);
        emit EmotionalAPRLogged(to, reason, block.timestamp);
    }

    function activateFallback(string memory reason) public onlyOwner {
        currentSanctum = fallbackSanctum;
        emit FallbackActivated(fallbackSanctum, reason);
        emit EmotionalAPRLogged("FallbackSanctum", reason, block.timestamp);
    }

    function getCurrentSanctum() public view returns (address) {
        return currentSanctum;
    }

    function tagTrustedSanctum(address sanctum) public onlyOwner {
        trustedSanctums[sanctum] = true;
    }

    function revokeSanctum(address sanctum) public onlyOwner {
        trustedSanctums[sanctum] = false;
    }
}
