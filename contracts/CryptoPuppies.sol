pragma solidity ^0.4.18;

contract CryptoPuppies {
  struct Puppy {
    uint genes;
    string name;
  }

  Puppy[] public puppies;

  mapping (address => uint) public puppyIndexesByOwner;

  uint public mostSent;
  address public richest;

  mapping (address => uint) pendingWithdrawals;

  event NewPuppy(uint genes, string name);

  function CryptoPuppies() public payable {
    richest = msg.sender;
    mostSent = 10;
  }

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

  function buyPuppy() public payable returns (bool) {
    if (100 > mostSent) {
      pendingWithdrawals[richest] += 100;
      richest = msg.sender;
      mostSent = 100;
      return true;
    } else {
      return false;
    }
  }

  function withdraw() public payable returns (uint) {
    uint amount = pendingWithdrawals[msg.sender];
    pendingWithdrawals[msg.sender] = 0;
    return amount;
    // msg.sender.transfer(amount);
  }
}
