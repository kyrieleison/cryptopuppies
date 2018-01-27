var CryptoPuppies = artifacts.require("./CryptoPuppies.sol");

module.exports = function(deployer) {
  deployer.deploy(CryptoPuppies);
};
