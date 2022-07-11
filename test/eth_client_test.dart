import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';

void main() async {
  final EthClient client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  final address = (await client.credentials.extractAddress()).hex;
  final poolGW = PoolGW(Address.POOL_GW, client);

  test("Get balance", () async {
    final result = await IERC20(Address.BAT, client).getBalance(address);
    print(result);
  });

  test("Get chain id", () async {
    final result = await client.client.getChainId();
    print(result.toInt());
  });
}
