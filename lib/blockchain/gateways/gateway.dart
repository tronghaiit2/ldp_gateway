import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/blockchain/gateways/aave_gateway.dart';

class Gateway {
  factory Gateway.of(String name, EthClient client) {
    switch (name) {
      case "Aave":
        return AaveGateway(Address.POOL[name]!, client);
      default:
        throw Exception("Doesn't support for $name lending pool");
    }
  }

  Future<String> approveDeposit(String assetAddress, BigInt amount) {
    return Future(() => "Deposit");
  }

  Future<String> approveWithdraw(String assetAddress, BigInt amount) {
    return Future(() => "Withdraw");
  }

  Future<String> approveBorrow(String assetAddress, BigInt amount) {
    return Future(() => "Borrow");
  }

  Future<String> approveRepay(String assetAddress, BigInt amount) {
    return Future(() => "Repay");
  }
}
