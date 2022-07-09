import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';

void main() async {
  late EthClient client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  late IERC20 weth = IERC20(Address.WETH, client);
  late IERC20 bat = IERC20(Address.BAT, client);

  test("Deposit", () async {
    final wethBefore = await weth.checkBalance();
    // deposit 60 weth to aave
    await deposit("Aave", Address.WETH, BigInt.from(200));
    final wethAfter = await weth.checkBalance();
    print("Deposit ${wethBefore - wethAfter}");
  });

  test("Withdraw", () async {
    final wethBefore = await weth.checkBalance();
    await withdraw("Aave", Address.WETH, BigInt.from(50));
    final wethAfter = await weth.checkBalance();
    print("Withdraw ${wethAfter - wethBefore}");
  });

  test("Borrow", () async {
    final batBefore = await bat.checkBalance();

    await borrow("Aave", Address.BAT, BigInt.from(80));

    final batAfter = await bat.checkBalance();
    print("Borrow ${batAfter - batBefore}");
  });

  test("Repay", () async {
    final batBefore = await bat.checkBalance();

    await repay("Aave", Address.BAT, BigInt.from(2));

    final batAfter = await bat.checkBalance();
    print("Repay ${batBefore - batAfter}");
  });
}
