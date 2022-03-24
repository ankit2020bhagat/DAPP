// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

contract crowd_funding {
    address public manager;
    uint256 target;
    uint256 deadline;
    uint256 noofContributor;
    struct Request {
        string purpose;
        address payable receipient;
        uint256 amount;
        uint256 noOfvote;
        mapping(address => bool) voter;
    }
    uint256 public noOfrequest;
    mapping(uint256 => Request) public request;
    mapping(address => uint256) public contributor;

    constructor(uint256 _amount, uint256 _deadline) {
        target = _amount;
        deadline = block.timestamp + _deadline;
        manager = msg.sender;
    }

    function donate() external payable {
        require(contributor[msg.sender] == 0);
        noofContributor++;
        contributor[msg.sender] += msg.value;
    }

    function raiseAmount() public view returns (uint256) {
        return address(this).balance;
    }

    function getRefund() public {
        require(
            target > raiseAmount() && block.timestamp > deadline,
            "Sorry you are not eligible"
        );
        require(contributor[msg.sender] > 0, "You must be contributor");
        payable(msg.sender).transfer(contributor[msg.sender]);
    }

    modifier OnlyManager() {
        require(msg.sender == manager, "Only manager can call\n");
        _;
    }

    function createRequest(
        string memory _purpose,
        address _reciepient,
        uint256 _amount
    ) public OnlyManager {
        Request storage new_request = request[noOfrequest];
        noOfrequest++;
        new_request.purpose = _purpose;
        new_request.receipient = payable(_reciepient);
        new_request.amount = _amount;
    }

    function vote(uint256 _num) public {
        require(contributor[msg.sender] > 0, "You must be a contributor");
        Request storage this_request = request[_num];
        require(
            this_request.voter[msg.sender] == false,
            "You have already voted"
        );
        this_request.voter[msg.sender] = true;
        this_request.noOfvote++;
    }

    function Transfer_funds(uint256 _request) public {
        Request storage fund_request = request[_request];
        require(
            fund_request.noOfvote > noofContributor / 2,
            "Majority does't support"
        );
        payable(fund_request.receipient).transfer(fund_request.amount);
    }
}
