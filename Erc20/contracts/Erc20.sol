// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0<0.9.0;
contract Erc20{
    uint public amount;
  
    mapping(address=>uint) public balance;
    mapping(address=>mapping(address=>uint)) public allow;
    constructor(uint _amount){
        amount=_amount;
        balance[msg.sender]=amount;
    }
    function totalSupply() external view  returns(uint)  {
          return amount;
    }
    function balanceof(address _owner) external view returns (uint){
        return balance[_owner];
    }
    function approve(address spender,uint nooftocken) external  returns (bool){
        allow[msg.sender][spender]=nooftocken;
        return true;
    }
    function allowance(address _owner,address _spender) external view returns(uint){
        return allow[_owner][_spender];
    }
    function transfer(address _to,uint _amount) external returns(bool){
        require(balance[msg.sender]>_amount);
        balance[msg.sender]-=_amount;
        balance[_to]+=_amount;
        return true;
    }
    
    function transferfrom(address _delegate,address _buyer,uint no_of_tocken) external returns(bool){
        require(balance[msg.sender]>no_of_tocken);
        require(allow[msg.sender][_delegate]>=no_of_tocken);
        balance[msg.sender]-=no_of_tocken;
        allow[msg.sender][_delegate]-=no_of_tocken;
        balance[_buyer]=balance[_buyer]+no_of_tocken;
        return true;
    }
}