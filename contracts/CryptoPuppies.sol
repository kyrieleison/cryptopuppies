pragma solidity ^0.4.18;

contract CryptoPuppies {
  struct Puppy {
    uint genes;
    string name;
  }

  Puppy[] public puppies;

  mapping (address => uint) public puppyIndexesByOwner;

  function getMyPuppyName() public view returns (string) {
    return puppies[puppyIndexesByOwner[msg.sender]].name;
  }

  function createPuppy(uint _genes, string _name) public {
    uint index = puppies.push(Puppy(_genes, _name)) - 1;
    puppyIndexesByOwner[msg.sender] = index;
  }
}
