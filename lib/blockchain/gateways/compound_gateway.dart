import 'package:ldp_gateway/blockchain/contracts/debt_token/compound_debt_token.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/gateways/gateway.dart';

class CompoundGateway extends Gateway {
  factory CompoundGateway.from(String gwAddress, EthClient client) =>
      CompoundGateway(gwAddress, client);

  CompoundGateway(gwAddress, client) : super(gwAddress, client);

  @override
  Future<String> approveBorrow(String debtAssetAddress, BigInt amount) =>
      CompoundDebtToken(debtAssetAddress, client).approveBorrow(amount);
}
