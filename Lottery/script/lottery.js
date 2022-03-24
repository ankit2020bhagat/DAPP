const Web3=require("web3");
const Mycontract=require('../build/contracts/Lottery.json');
const init=async()=>{
    
    const web3= new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
    
    const netId = await web3.eth.net.getId();
    console.log(netId);
    
    const deployednetwork=Mycontract.networks[netId];
    console.log(deployednetwork.address);
    const addresses=await web3.eth.getAccounts();
   //console.log(addresses[0]);
    web3.eth.defaultAccount =addresses[1];
    const defautaddress=await web3.eth.defaultAccount;
    console.log(defautaddress);
    
   let contract=new web3.eth.Contract(Mycontract.abi,deployednetwork.address);
   
   
   contract.methods.manager().call().then(console.log);
 
  //await contract.methods.selectWinner().send({from:addresses[1]}).then(console.log);
 
}
init();


