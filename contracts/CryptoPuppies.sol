pragma solidity ^0.4.18;

contract CryptoPuppies {
    struct Puppy {
        uint genes;
        string name;
    }

    Puppy[] public puppies;

    mapping(address => int) public puppyIndexesByOwner;

    event NewPuppy(uint genes, string name);

    modifier onlyPuppyOwner() {
        require(puppyIndexesByOwner[msg.sender] > 0);
        _;
    }

    function CryptoPuppies() public {
        puppies.push(Puppy(0, 'General Puppy'));
    }

    function hasAnyPuppy() public view returns (bool) {
        if (puppies.length == 0) {
            return false;
        }

        int index = puppyIndexesByOwner[msg.sender];
        if (index <= 0) {
            return false;
        }

        return puppies[uint(index)].genes != 0;
    }

    function getMyPuppyGenes() public view onlyPuppyOwner returns (uint) {
        return puppies[uint(puppyIndexesByOwner[msg.sender])].genes;
    }

    function getMyPuppyName() public view onlyPuppyOwner returns (string) {
        return puppies[uint(puppyIndexesByOwner[msg.sender])].name;
    }

    function createPuppy(uint _genes, string _name) public {
        int index = int(puppies.push(Puppy(_genes, _name)) - 1);
        puppyIndexesByOwner[msg.sender] = index;
        NewPuppy(_genes, _name);
    }

    function buyPuppy(address _from, uint _price) public payable {
        payEther(_from, _price);
        puppyIndexesByOwner[msg.sender] = puppyIndexesByOwner[_from];
        puppyIndexesByOwner[_from] = -1;
    }

    function payEther(address _recipient, uint _amount) public payable {
        _recipient.transfer(_amount);
    }
}
