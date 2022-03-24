const Web3=require("web3");
const Mycontract=require('../build/contracts/Erc20.json');
const init=async()=>{
    
    const web3= new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
    
    const networkId = await web3.eth.net.getId();
    console.log(networkId);
    const deployedNetwork = Mycontract.networks[networkId];
    console.log(deployedNetwork.address)
   let contract=new web3.eth.Contract(Mycontract.abi,deployedNetwork.address);
   const addresses=await web3.eth.getAccounts();
   console.log(addresses[0]);
 //  contract.methods.donate().send({from:addresses[5],value:"200"});
  contract.methods.amount().call().then(console.log);
  contract.methods.totalSupply().call().then(console.log);
   contract.methods.approve(addresses[1],20).send({from:addresses[0]});
   contract.methods.allowance(addresses[0],addresses[1]).call().then(console.log);
   contract.methods.balance(addresses[0]).call().then(console.log);
   contract.methods.allow(addresses[0],addresses[1]).call().then(console.log);
   //contract.methods.transferfrom(addresses[1],addresses[3],20).send({from:addresses[0]});
   //contract.methods.transfer(addresses[2],20).send({from:addresses[0]});
 // contract.methods.contributor(addresses[5]).call().then(console.log);
  // contract.methods.transfer(addresses[2],10).send({from:addresses[0]}); 
  //await contract.methods.getRefund().send({from:addresses[1]}).then(console.log);
 //web3.eth.getBalance(addresses[1]).then(console.log);
 //  await contract.methods.createRequest("Education",addresses[2],300).send({from:addresses[1],gas:'800000'});
 // contract.methods.vote(0).send({from:addresses[3]})
 // contract.methods.request(0).call().then(console.log);
}
init();


