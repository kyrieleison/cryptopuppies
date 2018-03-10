web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
web3.eth.defaultAccount = web3.eth.accounts[0];

var abiArray;
$.getJSON("contracts/CryptoPuppies.json", function(json) {
  abiArray = json.abi;

  var contractAddress = "0x74e3fc764c2474f25369b9d021b7f92e8441a2dc";
  var contract = web3.eth.contract(abiArray).at(contractAddress);

  $("#myaddress").html(web3.eth.defaultAccount);

  if (contract.hasAnyPuppy({ from: web3.eth.accounts[0], gas: 2000000 })) {
    for (var i = 0; i < contract.getMyPuppyCount(); i ++) {
      $("#mypuppies").append(`<li>name: ${contract.getMyPuppyName(i)}</li>`);
      $("#mypuppies").append(`<li>genes: ${contract.getMyPuppyGenes(i).c[0]}</li>`);
    }
  }

  $("#create-puppy").click(function() {
    contract.createPuppy(
      parseInt($("#genes").val()),
      $("#name").val(),
      {
        from: web3.eth.accounts[0],
        gas: 2000000
      }
    );
  });

  $("#buy-puppy").click(function() {
    contract.buyPuppy(
      $("#from").val(),
      parseInt($("#price").val()),
      {
        from: web3.eth.accounts[0],
        gas: 2000000,
        value: parseInt($("#price").val())
      }
    );
  });

  web3.eth.accounts.forEach(function(account, i) {
    $("#accounts").append(`<li>${i}: ${account}, balance: ${web3.eth.getBalance(account).toString()} Wei</li>`);
  });

  for (var i = 1; i < contract.getPuppiesCount(); i++) {
    var name = contract.getPuppy(i);
    $("#puppy-list").append(`<li> ${name} </li>`);
  }

  $("#send-eth").click(function() {
    contract.payEther(
      $("#recipient").val(),
      parseInt($("#amount").val()),
      {
        from: web3.eth.accounts[0],
        gas: 2000000,
        value: parseInt($("#amount").val())
      }
    );
  });

  var event = contract.NewPuppy();

  event.watch(function(error, result) {
    if (!error) {
      console.log(result);
      $("#notification").html(`新しい子犬 ${result.args.name} を作成しました`);
    } else {
      console.log(error);
    }
  });

});
