import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class EthClient {
  factory EthClient(String privateKey, String rpcUrl) => EthClient._(
        EthPrivateKey.fromHex(privateKey),
        Web3Client(
          rpcUrl,
          Client(),
        ),
      );

  EthClient._(this.credentials, this.client);

  final Web3Client client;

  final Credentials credentials;

  Future<String> sendTransaction(
    DeployedContract contract,
    ContractFunction function,
    List<dynamic> params,
  ) {
    return client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: params,
      ),
      chainId: 31337,
    );
  }

  Future<List<dynamic>> call(
    DeployedContract contract,
    ContractFunction function,
    List<dynamic> params,
  ) {
    return client.call(
      contract: contract,
      function: function,
      params: params,
    );
  }

  getBalance() async {
    return client.getBalance(await credentials.extractAddress());
  }
}
