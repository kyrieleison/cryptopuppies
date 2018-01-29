pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CryptoPuppies.sol";

contract TestCryptoPuppies {
  CryptoPuppies cryptoPuppies = CryptoPuppies(DeployedAddresses.CryptoPuppies());

  function testGetMyPuppyGenes() public {
    cryptoPuppies.createPuppy(123456789, 'Shiro');

    Assert.equal(cryptoPuppies.getMyPuppyGenes(), 123456789, 'Puppy of genes 123456789 should be recorded.');
  }
}
