import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';

void main() async {
  final EthClient client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  final IERC20 weth = IERC20(Address.WETH, client);
  final IERC20 bat = IERC20(Address.BAT, client);
  final address = (await client.credentials.extractAddress()).hex;

  test("Deposit", () async {
    final wethBefore = await weth.getBalance(address);
    // deposit 60 weth to aave
    await deposit("Aave", Address.WETH, BigInt.from(200));
    final wethAfter = await weth.getBalance(address);
    print("Deposit ${wethBefore - wethAfter}");
  });

  // test("Withdraw", () async {
  //   final wethBefore = await weth.checkBalance(address);
  //   await withdraw("Aave", Address.WETH, BigInt.from(50));
  //   final wethAfter = await weth.checkBalance(address);
  //   print("Withdraw ${wethAfter - wethBefore}");
  // });

  test("Borrow", () async {
    final batBefore = await bat.getBalance(address);

    await borrow("Aave", Address.BAT, BigInt.from(80));

    final batAfter = await bat.getBalance(address);
    print("Borrow ${batAfter - batBefore}");
  });

  // test("Repay", () async {
  //   final batBefore = await bat.checkBalance(address);
  //
  //   await repay("Aave", Address.BAT, BigInt.from(2));
  //
  //   final batAfter = await bat.checkBalance(address);
  //   print("Repay ${batBefore - batAfter}");
  // });
}
