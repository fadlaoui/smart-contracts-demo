// Second demo create a simplified version of multi signature wallet
pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract MultiSigWallet {
    uint minApprovers;
    
    address beneficiary;
    address owner;
    
    mapping(address => bool) approvedBy;
    mapping(address => bool) isApprover;
    uint approvalsNum;
    
    constructor(address[] _approvers,uint _minApprovers,address _beneficiary) public payable {
        require(_minApprovers <= _approvers.length,"Require number of approvers should should be less than number of approvers");
        
        minApprovers = _minApprovers;
        beneficiary = _beneficiary;
        owner = msg.sender;
        
        for (uint i= 0 ; i< _approvers.length ; i++) {
            address approvers = _approvers[i];
            isApprover[approvers] = true;
        }
    }
    
    function approve() public {
        require(isApprover[msg.sender] , "Not an approver");
        if(!approvedBy[msg.sender]){
            approvalsNum++;
            approvedBy[msg.sender] = true;
        }
        
        if(approvalsNum == minApprovers) {
            beneficiary.send(address(this).balance);
            selfdestruct(owner);
        }
    }
    
    function reject() {
         require(isApprover[msg.sender] , "Not an approver");
         selfdestruct(owner);
    }
}