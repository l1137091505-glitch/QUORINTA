// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Quorinta
/// @notice One support-or-oppose vote per wallet for each owner-published poll.
contract Quorinta {
    struct Poll {
        string question;
        string context;
        uint64 deadline;
        uint96 fee;
        address payable beneficiary;
        uint32 support;
        uint32 oppose;
        bool closed;
    }

    address public owner;
    uint256 public pollCount;
    uint256 private unlocked = 1;
    mapping(uint256 => Poll) private polls;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(address => bool)) public supported;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event PollOpened(uint256 indexed pollId, string question, uint64 deadline, uint96 fee, address indexed beneficiary);
    event VoteRecorded(uint256 indexed pollId, address indexed voter, bool support, uint256 fee);
    event PollClosed(uint256 indexed pollId);

    modifier onlyOwner() { require(msg.sender == owner, "owner only"); _; }
    modifier nonReentrant() { require(unlocked == 1, "reentrant"); unlocked = 2; _; unlocked = 1; }

    constructor() { owner = msg.sender; emit OwnershipTransferred(address(0), msg.sender); }

    function transferOwnership(address nextOwner) external onlyOwner {
        require(nextOwner != address(0), "zero owner");
        emit OwnershipTransferred(owner, nextOwner);
        owner = nextOwner;
    }

    function openPoll(string calldata question, string calldata context, uint64 duration, uint96 fee, address payable beneficiary) external onlyOwner returns (uint256 pollId) {
        require(bytes(question).length >= 8 && bytes(question).length <= 180, "question length");
        require(bytes(context).length <= 500, "context length");
        require(duration >= 1 hours && duration <= 90 days, "duration range");
        require(beneficiary != address(0), "zero beneficiary");
        pollId = pollCount++;
        polls[pollId] = Poll(question, context, uint64(block.timestamp) + duration, fee, beneficiary, 0, 0, false);
        emit PollOpened(pollId, question, uint64(block.timestamp) + duration, fee, beneficiary);
    }

    function vote(uint256 pollId, bool choice) external payable nonReentrant {
        Poll storage ballot = polls[pollId];
        require(ballot.deadline != 0, "poll missing");
        require(!ballot.closed && block.timestamp < ballot.deadline, "poll closed");
        require(!hasVoted[pollId][msg.sender], "already voted");
        require(msg.value == ballot.fee, "wrong fee");
        hasVoted[pollId][msg.sender] = true;
        supported[pollId][msg.sender] = choice;
        if (choice) ballot.support += 1; else ballot.oppose += 1;
        if (msg.value != 0) {
            (bool sent,) = ballot.beneficiary.call{value: msg.value}("");
            require(sent, "fee transfer failed");
        }
        emit VoteRecorded(pollId, msg.sender, choice, msg.value);
    }

    function closePoll(uint256 pollId) external onlyOwner {
        require(polls[pollId].deadline != 0, "poll missing");
        polls[pollId].closed = true;
        emit PollClosed(pollId);
    }

    function poll(uint256 pollId) external view returns (string memory question, string memory context, uint64 deadline, uint96 fee, address beneficiary, uint32 support, uint32 oppose, bool closed) {
        Poll storage p = polls[pollId];
        return (p.question, p.context, p.deadline, p.fee, p.beneficiary, p.support, p.oppose, p.closed);
    }
}
