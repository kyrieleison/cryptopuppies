pragma solidity ^0.4.18;

contract CryptoPuppies {
  struct Puppy {
    address owner;
    uint genes;
    string name;
  }

  Puppy[] public puppies;

  function getPuppyName(uint _number) public view returns (string) {
    return puppies[_number].name;
  }

  function getPuppyOwner(uint _number) public view returns (address) {
    return puppies[_number].owner;
  }

  function createPuppies(address _owner, uint _genes, string _name) public {
    puppies.push(Puppy(_owner, _genes, _name));
  }

}
