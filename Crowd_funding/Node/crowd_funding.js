const Web3 = require("web3");
const Mycontract = require('../build/contracts/crowd_funding.json');
const init = async () => {

  const web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));

  const netId = await web3.eth.net.getId();
  console.log(netId);
  const deployednetwork= Mycontract.networks[netId];
  let contract = new web3.eth.Contract(Mycontract.abi, deployednetwork.address);
  const addresses = await web3.eth.getAccounts();
  console.log(addresses[0]);
  //contract.methods.donate().send({from:addresses[2],value:"300"});
  contract.methods.raiseAmount().call().then(console.log);
  //contract.methods.contributor(addresses[1]).call().then(console.log);

 // await contract.methods.getRefund().send({from:addresses[1]}).then(console.log);
  //web3.eth.getBalance(addresses[1]).then(console.log);
 // await contract.methods.createRequest("Vacinr", addresses[1], 300).send({ from: addresses[0], gas: '800000' });
  // contract.methods.vote(1).send({ from: addresses[3] })
  contract.methods.request(0).call().then(console.log);
}
init();


