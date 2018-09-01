pragma solidity ^0.4.24;

contract Election {
    // 候选人信息结构
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // 选举Mapping
    mapping(address => bool) public voters;

    mapping(uint => Candidate) public candidates;
    // 票数
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("候选人 1");
        addCandidate("候选人 2");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        require(!voters[msg.sender]);

        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;

        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }
}