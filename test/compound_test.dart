import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';

void main() async {
  final EthClient client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  final dai = IERC20(Address.DAI, client);
  final bat = IERC20(Address.BAT, client);

  test("Deposit", () async {
    final before = await bat.checkBalance();
    await deposit("Compound", Address.BAT, BigInt.from(5));
    final after = await bat.checkBalance();
    print("Deposit ${before - after}");
  });

  test("Withdraw", () async {
    final before = await bat.checkBalance();
    await withdraw("Compound", Address.BAT, BigInt.from(20));
    final after = await bat.checkBalance();
    print("Withdraw ${after - before}");
  });

  test("Borrow", () async {
    final before = await dai.checkBalance();
    await withdraw("Compound", Address.DAI, BigInt.from(5));
    final after = await dai.checkBalance();
    print("Borrow ${after - before}");
  });

  test("Repay", () async {
    final before = await dai.checkBalance();
    await withdraw("Compound", Address.DAI, BigInt.from(2));
    final after = await dai.checkBalance();
    print("Repay ${before - after}");
  });
}
