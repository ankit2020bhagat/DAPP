// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract Auction{
    address payable public beneficiary;
    uint public highest_bid;
    address payable highest_bider;
    uint public auctionEndtime;
    mapping(address=>uint ) public pending;

     /// The auction has already ended.
    error AuctionAlreadyEnded();
    /// There is already a higher or equal bid.
    error BidNotHighEnough(uint highestBid);
    
      error AuctionNotYetEnded();
    constructor(uint setTime,address _beneficiary){
        auctionEndtime=block.timestamp+setTime;
        beneficiary=payable(_beneficiary);
    }
    function Bid() payable external{
       if(block.timestamp>auctionEndtime){
           revert AuctionAlreadyEnded();
       }
       if(msg.value<highest_bid){
           revert BidNotHighEnough(highest_bid);
       }
      
       if(highest_bid!=0){
       pending[highest_bider]=highest_bid;
       }
       highest_bid=msg.value;
       highest_bider=payable(msg.sender);
    }
    modifier onlyOwner(){
        require(msg.sender==beneficiary,"Only beneficiary can call this function");
        _;
    }
    function Anuction_End() public onlyOwner{
        require(block.timestamp>auctionEndtime,"Auction not yet ended");
        beneficiary.transfer(highest_bid);
        
    }
    function withdraw() public {
        require(block.timestamp>auctionEndtime,"Auction not yet ended");
        uint amount=pending[msg.sender];
        require(amount>0,"You are not bider");
        address payable receiver=payable(msg.sender);
        receiver.transfer(amount);
        pending[msg.sender]=0;
    }
}//origin  https://github.com/ankit2020bhagat/Smart_Contract.git 