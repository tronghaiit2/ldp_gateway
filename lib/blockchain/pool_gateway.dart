import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/gateways/gateway.dart';

final client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
final pool = PoolGW(Address.POOL_GW, client);

Future<String> deposit(String name, String assetAddress, BigInt amount) async {
  // approve transfer amount of asset from this user to gateway
  await (await Gateway.of(name, client)).approveDeposit(assetAddress, amount);
  return PoolGW(Address.POOL_GW, client).deposit(name, assetAddress, amount);
}

Future<String> withdraw(String name, String assetAddress, BigInt amount) async {
  // approve transfer amount of reverse asset from this user to gateway
  final reverseAssetAddress = (await pool.getReverse(name, assetAddress)).hex;
  await (await Gateway.of(name, client))
      .approveWithdraw(reverseAssetAddress, amount);
  return PoolGW(Address.POOL_GW, client).withdraw(name, assetAddress, amount);
}

Future<String> borrow(String name, String assetAddress, BigInt amount) async {
  final debtAssetAddress = (await pool.getDebt(name, assetAddress)).hex;
  await (await Gateway.of(name, client))
      .approveBorrow(debtAssetAddress, amount);
  return PoolGW(Address.POOL_GW, client).borrow(name, assetAddress, amount);
}

Future<String> repay(String name, String assetAddress, BigInt amount) async {
  await (await Gateway.of(name, client)).approveDeposit(assetAddress, amount);
  return PoolGW(Address.POOL_GW, client).repay(name, assetAddress, amount);
}
