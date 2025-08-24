// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/forge-std/src/Test.sol";
import "../contracts/RouteOverrideProtocol.sol";

contract SanctumDefenseSuite is Test {
    RouteOverrideProtocol protocol;
    address chinaSanctum = 0xa13BAF47339d63B743e7Da8741db5456DAc1E556;
    address canadaSanctum = 0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF;
    address rogueSanctum = 0x1111111111111111111111111111111111111111;

    function setUp() public {
        protocol = new RouteOverrideProtocol();
    }

    function testRerouteToTrustedSanctum() public {
        protocol.tagTrustedSanctum(canadaSanctum);
        protocol.reroute("China", "Canada", canadaSanctum, "Diplomatic override");
        assertEq(protocol.getCurrentSanctum(), canadaSanctum);
    }

    function testFallbackActivationLogsCorrectly() public {
        protocol.activateFallback("Emergency breach detected");
        assertEq(protocol.getCurrentSanctum(), canadaSanctum);
    }

    function testUntrustedSanctumRejection() public {
        vm.expectRevert("Untrusted sanctum");
        protocol.reroute("China", "Rogue", rogueSanctum, "Malicious reroute attempt");
    }

    function testSanctumRevocation() public {
        protocol.tagTrustedSanctum(rogueSanctum);
        protocol.revokeSanctum(rogueSanctum);
        vm.expectRevert("Untrusted sanctum");
        protocol.reroute("China", "Rogue", rogueSanctum, "Revoked sanctum reroute");
    }

    function testOwnerOnlyAccess() public {
        vm.prank(address(0xBEEF));
        vm.expectRevert("Unauthorized scrollsmith");
        protocol.activateFallback("Unauthorized fallback attempt");
    }
}
