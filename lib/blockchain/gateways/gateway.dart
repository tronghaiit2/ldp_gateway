import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/gateways/aave_gateway.dart';
import 'package:ldp_gateway/blockchain/gateways/compound_gateway.dart';

import '../address.dart';
import '../contracts/ierc20.dart';
import '../contracts/pool_gw.dart';

abstract class Gateway {
  static Future<Gateway> of(String name, EthClient client) async {
    switch (name) {
      case "Aave":
        return AaveGateway.from(
          (await PoolGW(Address.POOL_GW, client).getGatewayAddress(name)).hex,
          client,
        );
      case "Compound":
        return CompoundGateway.from(
          (await PoolGW(Address.POOL_GW, client).getGatewayAddress(name)).hex,
          client,
        );
      default:
        throw Exception("Doesn't support for $name lending pool");
    }
  }

  final String gwAddress;
  final EthClient client;

  Gateway(this.gwAddress, this.client);

  Future<String> approveDeposit(String assetAddress, BigInt amount) =>
      IERC20(assetAddress, client).approve(gwAddress, amount);

  Future<String> approveWithdraw(String reverseAssetAddress, BigInt amount) =>
      IERC20(reverseAssetAddress, client).approve(gwAddress, amount);

  Future<String> approveBorrow(String debtAssetAddress, BigInt amount);

  Future<String> approveRepay(String assetAddress, BigInt amount) =>
      IERC20(assetAddress, client).approve(gwAddress, amount);
}
