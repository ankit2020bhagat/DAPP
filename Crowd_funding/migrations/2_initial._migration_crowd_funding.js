const crowd_funding = artifacts.require("crowd_funding");

module.exports = function (deployer) {
  deployer.deploy(crowd_funding,1000,50);
};
