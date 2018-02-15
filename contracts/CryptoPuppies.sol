pragma solidity ^0.4.18;

contract CryptoPuppies {
  struct Puppy {
    uint genes;
    string name;
  }

  Puppy[] public puppies;

  mapping (address => uint) public puppyIndexesByOwner;

  event NewPuppy(uint genes, string name);

  function getMyPuppyGenes() public view returns (uint) {
    return puppies[puppyIndexesByOwner[msg.sender]].genes;
  }

  function getMyPuppyName() public view returns (string) {
    return puppies[puppyIndexesByOwner[msg.sender]].name;
  }

  function createPuppy(uint _genes, string _name) public {
    uint index = puppies.push(Puppy(_genes, _name)) - 1;
    puppyIndexesByOwner[msg.sender] = index;
    NewPuppy(_genes, _name);
  }

  function payEther(address _recipient, uint _amount) public payable {
    _recipient.transfer(_amount);
  }
}
