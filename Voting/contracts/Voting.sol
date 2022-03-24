// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Vote1{
      address public manager;
      struct  Voter  {
          bool isvoted;
          uint weight;
      }
      mapping(address => Voter) public Voters;
      struct  Proposal {

          string name;
          uint votecount;
      }
      uint totalNoofVoter;
      Proposal[] public proposal;
      constructor(){
          manager=msg.sender;
      }

       modifier OnlyManager(){
        require(msg.sender==manager,"Only manager can call\n");
        _;
    }
      function giveRighttoVote( address _to) public  OnlyManager{
          require(!Voters[_to].isvoted,"You have already Voted");
          require(Voters[_to].weight==0);
          Voters[_to].weight=1;
      }
      function createPropodsal(string memory _proposal) public{
          proposal.push(Proposal({
              name : _proposal,
              votecount:0
          })); 
      }
      function Vote(uint i) public{
          Voter storage voters=Voters[msg.sender];
          require(!voters.isvoted,"You have already Voted");
          require(voters.weight==1);
          voters.isvoted=true;
          proposal[i].votecount++;
          totalNoofVoter++;
      }
      function selectWinner() public OnlyManager view returns(string memory winner) {
          for(uint i=0;i<proposal.length;i++){
              if(proposal[i].votecount>totalNoofVoter/2){
                  winner =proposal[i].name;
              }
          }
      }
}
//origin  https://github.com/ankit2020bhagat/Smart_Contract.git