import 'package:flutter_test/flutter_test.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/aave_debt_token.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';

void main() async {
  late final EthClient client;
  late final PoolGW poolGW;
  late final IERC20 weth;
  late final IERC20 aWeth;
  late final IERC20 dai;
  late final AaveDebtToken debtDai;

  setUp(() async {
    // need to input private key
    client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    poolGW = PoolGW(Address.POOL_GW, client);
    weth = IERC20(Address.WETH, client);
    dai = IERC20(Address.DAI, client);
    Address.POOL["Aave"] = (await poolGW.getGatewayAddress("Aave")).hex;
    final aWethAddress = await poolGW.getReverse("Aave", Address.WETH);
    aWeth = IERC20(aWethAddress.hex, client);
    final debtDaiAddress = await poolGW.getDebt("Aave", Address.DAI);
    debtDai = AaveDebtToken(debtDaiAddress.hex, client);
  });

  test("Get aave gateway address", () async {
    final result = await poolGW.getGatewayAddress('Aave');
    expect(
      result.hex,
      equalsIgnoringCase("0x8bee2037448f096900fd9affc427d38ae6cc0350"),
    );
  });

  test("Get aToken", () async {
    final result = await poolGW.getReverse("Aave", Address.WETH);
    expect(
      result.hex,
      equalsIgnoringCase("0x030bA81f1c18d280636F32af80b9AAd02Cf0854e"),
    );
  });

  test("Deposit", () async {
    final firstWethBalance = await weth.checkBalance();
    final firstAWethBalance = await aWeth.checkBalance();

    // deposit 60 weth to aave
    await deposit("Aave", Address.WETH, BigInt.from(60));

    final wethBalanceAfterDeposit = await weth.checkBalance();
    expect(
      firstWethBalance - wethBalanceAfterDeposit,
      equals(BigInt.from(60)),
    );

    // receive 60 aWeth
    final aWethBalanceAfterDeposit = await aWeth.checkBalance();
    expect(
      aWethBalanceAfterDeposit - firstAWethBalance,
      equals(BigInt.from(60)),
    );
  });

  test("Withdraw", () async {
    final firstWethBalance = await weth.checkBalance();
    final firstAWethBalance = await aWeth.checkBalance();
    // withdraw 25 weth
    await withdraw("Aave", Address.WETH, BigInt.from(25));

    final wethBalanceAfterWithdraw = await weth.checkBalance();
    expect(
      wethBalanceAfterWithdraw - firstWethBalance,
      equals(BigInt.from(25)),
    );

    final aWethBalanceAfterDeposit = await aWeth.checkBalance();
    expect(
      firstAWethBalance - aWethBalanceAfterDeposit,
      equals(BigInt.from(26)),
    );
  });

  test("Borrow", () async {
    final firstDaiBalance = await dai.checkBalance();
    final debtDaiBalance = await debtDai.checkBalance();

    await borrow("Aave", Address.DAI, BigInt.from(10));

    final daiBalanceAfterBorrow = await dai.checkBalance();
    final debtDaiBalanceAfterBorrow = await debtDai.checkBalance();
    expect(
      daiBalanceAfterBorrow - firstDaiBalance,
      equals(BigInt.from(10)),
    );

    expect(
      debtDaiBalanceAfterBorrow - debtDaiBalance,
      equals(BigInt.from(10)),
    );
  });

  test("Repay", () async {
    final firstDaiBalance = await dai.checkBalance();
    final firstDebtDaiBalance = await debtDai.checkBalance();

    await repay("Aave", Address.DAI, BigInt.from(5));

    final daiBalanceAfterBorrow = await dai.checkBalance();
    final debtDaiBalanceAfterBorrow = await debtDai.checkBalance();
    expect(
      firstDaiBalance - daiBalanceAfterBorrow,
      equals(BigInt.from(5)),
    );

    expect(
      firstDebtDaiBalance - debtDaiBalanceAfterBorrow,
      equals(BigInt.from(5)),
    );
  });
}
