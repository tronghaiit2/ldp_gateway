import 'package:ldp_gateway/blockchain/contracts/debt_token/aave_debt_token.dart';
import 'package:ldp_gateway/blockchain/gateways/gateway.dart';

import '../eth_client.dart';

class AaveGateway extends Gateway {
  factory AaveGateway.from(String gwAddress, EthClient client) =>
      AaveGateway(gwAddress, client);

  AaveGateway(gwAddress, client) : super(gwAddress, client);

  @override
  Future<String> approveBorrow(String debtAssetAddress, BigInt amount) =>
      AaveDebtToken(debtAssetAddress, client).approveBorrow(gwAddress, amount);
}
