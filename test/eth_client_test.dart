import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';

void main() async {
  late final EthClient client;

  setUp(() {
    client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  });

  test("Create singleton instance of eth client", () async {
    final address = await client.credentials.extractAddress();
    expect(
      address.hex,
      equalsIgnoringCase("0x70997970C51812dc3A010C7d01b50e0d17dc79C8"),
    );
  });

  test("Get balance", () async {
    final result = await IERC20(Address.WETH, client).checkBalance();
    expect(result, equals(BigInt.from(100)));
  });

  test("Get chain id", () async {
    final result = await client.client.getChainId();
    print(result.toInt());
  });
}
