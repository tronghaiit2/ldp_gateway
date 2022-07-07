import 'package:ldp_gateway/blockchain/contracts/aave_debt_token.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/blockchain/gateways/gateway.dart';

import '../eth_client.dart';

class AaveGateway implements Gateway {
  factory AaveGateway(String gwAddress, EthClient client) =>
      AaveGateway._(gwAddress, client);

  final String gwAddress;
  final EthClient client;

  AaveGateway._(this.gwAddress, this.client);

  @override
  Future<String> approveDeposit(String assetAddress, BigInt amount) =>
      IERC20(assetAddress, client).approve(gwAddress, amount);

  @override
  Future<String> approveWithdraw(String reverseAssetAddress, BigInt amount) =>
      IERC20(reverseAssetAddress, client).approve(gwAddress, amount);

  @override
  Future<String> approveBorrow(String assetAddress, BigInt amount) =>
      AaveDebtToken(assetAddress, client).approveBorrow(gwAddress, amount);

  @override
  Future<String> approveRepay(String assetAddress, BigInt amount) =>
      IERC20(assetAddress, client).approve(gwAddress, amount);

}
