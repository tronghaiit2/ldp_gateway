import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';

void main() async {
  final EthClient client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
  final dai = IERC20(Address.DAI, client);
  final bat = IERC20(Address.BAT, client);
  final poolGW = PoolGW(Address.POOL_GW, client);
  final address = (await client.credentials.extractAddress()).hex;

  test("Check balance", () async {
    // final cAddress = await poolGW.getReverse("Compound", Address.BAT);
    final balance =
        await IERC20("0x6C8c6b02E7b2BE14d4fA6022Dfd6d75921D90E4E", client)
            .getBalance("0xAe120F0df055428E45b264E7794A18c54a2a3fAF");
    print(balance);
  });

  test("Deposit", () async {
    final before = await bat.getBalance(address);
    await deposit("Compound", Address.BAT, BigInt.from(20));
    final after = await bat.getBalance(address);
    print("Deposit ${before - after}");
  });

  test("Withdraw", () async {
    final before = await bat.getBalance(address);
    await withdraw("Compound", Address.BAT, BigInt.from(2));
    final after = await bat.getBalance(address);
    print("Withdraw ${after - before}");
  });

  test("Borrow", () async {
    final before = await dai.getBalance(address);
    await withdraw("Compound", Address.DAI, BigInt.from(5));
    final after = await dai.getBalance(address);
    print("Borrow ${after - before}");
  });

  test("Repay", () async {
    final before = await dai.getBalance(address);
    await withdraw("Compound", Address.DAI, BigInt.from(2));
    final after = await dai.getBalance(address);
    print("Repay ${before - after}");
  });
}
