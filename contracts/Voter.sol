// DEMO FOR CREATING A SIMPLE SMART CONTACT FOR VOTE

pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract Voter {
    
    
    struct OptionOps {
        uint pos;
        bool exists;
    }
    
    uint[] public votes;
    string[] public options;
    mapping(address => bool) hasVoted;
    mapping(string => OptionOps) posOfOptions;
    
    constructor(string[] _options) public {
        options = _options;
        votes.length = options.length;
        // basic posOfOptions array filling
        for(uint i=0; i< options.length;i++) {
            OptionOps memory optionsPos = OptionOps(i,true);
            string optionName = options[i];
            posOfOptions[optionName] = optionsPos;
        }
    }
    function vote(uint option) public {
        require(option >= 0 && option < options.length, "Invalid option");
        require(!hasVoted[msg.sender],"Account has already voted");
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
    }
    function vote (string optionName) public {
        require(!hasVoted[msg.sender],"Account has already voted");
        
        OptionOps  memory optionsPos = posOfOptions[optionName];
        require (optionsPos.exists, "Option that not exists");
        votes[optionsPos.pos] = votes[optionsPos.pos] + 1;
        hasVoted[msg.sender] = true;

    }
    function getOptions() public view returns (string[]) {
        return options;
        
    }
    function getVotes() public view returns(uint[]) {
        return votes;
    }
}