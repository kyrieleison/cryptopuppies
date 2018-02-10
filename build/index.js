web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
web3.eth.defaultAccount = web3.eth.accounts[0];

var abiArray;
$.getJSON("contracts/CryptoPuppies.json", function(json) {
  abiArray = json.abi;

  var contractAddress = "0x345ca3e014aaf5dca488057592ee47305d9b3e10";
  var contract = web3.eth.contract(abiArray).at(contractAddress);

  $("#your-address").html(web3.eth.defaultAccount);
  var puppyName = contract.getMyPuppyName({ from: web3.eth.accounts[0], gas: 2000000 });
  if (puppyName) {
    $("#your-pappy-name").html(puppyName)
  }

  var puppyGenes = contract.getMyPuppyGenes({ from: web3.eth.accounts[0], gas: 2000000 });
  if (puppyGenes) {
    $("#your-pappy-genes").html(puppyGenes.c[0])
  }

  $("#create-pappy").click(function() {
    contract.createPuppy(parseInt($("#genes").val()), $("#name").val(), { from: web3.eth.accounts[0], gas: 2000000 });
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
