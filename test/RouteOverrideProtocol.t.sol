// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/forge-std/src/Test.sol";
import "forge-std/Test.sol";
import "../contracts/RouteOverrideProtocol.sol";

contract RouteOverrideTest is Test {
    RouteOverrideProtocol protocol;

    function setUp() public {
        protocol = new RouteOverrideProtocol();
    }

    function testInitialSanctumIsChina() public view {
        address expected = 0xa13BAF47339d63B743e7Da8741db5456DAc1E556;
        assertEq(protocol.getCurrentSanctum(), expected);
    }

    function testFallbackActivation() public {
        protocol.activateFallback("Emergency reroute");
        address expected = address(0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF);
        assertEq(protocol.getCurrentSanctum(), expected);
    }
}
