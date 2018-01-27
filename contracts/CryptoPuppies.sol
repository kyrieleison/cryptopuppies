pragma solidity ^0.4.18;

contract CryptoPuppies {
  struct Puppy {
    uint genes;
    string name;
  }

  Puppy[] public puppies;

  function getFirstPuppyName() public view returns (string) {
    return puppies[0].name;
  }

  function createPuppies(uint _genes, string _name) public {
    puppies.push(Puppy(_genes, _name));
  }
}
