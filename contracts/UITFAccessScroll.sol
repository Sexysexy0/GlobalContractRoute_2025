// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UITFAccessScroll {
    address public owner;
    mapping(address => bool) public trustees;
    mapping(address => bool) public approvedBeneficiaries;

    event TrusteeTagged(address trustee);
    event FundAccessGranted(address beneficiary);
    event DamayClauseActivated(address beneficiary, string reason);

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized scrollsmith");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function tagTrustee(address trustee) public onlyOwner {
        trustees[trustee] = true;
        emit TrusteeTagged(trustee);
    }

    function grantAccess(address beneficiary) public {
        require(trustees[msg.sender], "Not a verified trustee");
        approvedBeneficiaries[beneficiary] = true;
        emit FundAccessGranted(beneficiary);
    }

    function activateDamayClause(address beneficiary, string memory reason) public onlyOwner {
        approvedBeneficiaries[beneficiary] = true;
        emit DamayClauseActivated(beneficiary, reason);
    }

    function isApproved(address beneficiary) public view returns (bool) {
        return approvedBeneficiaries[beneficiary];
    }
}
