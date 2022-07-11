import 'dart:convert';

import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:web3dart/web3dart.dart';

class CompoundDebtToken {
  final DeployedContract token;
  final EthClient client;

  CompoundDebtToken._(this.token, this.client);

  factory CompoundDebtToken(String address, EthClient client) =>
      CompoundDebtToken._(
        DeployedContract(
          ContractAbi.fromJson(jsonABI, "CErc20"),
          EthereumAddress.fromHex(address),
        ),
        client,
      );

  Future<String> approveBorrow(BigInt amount) {
    return client.sendTransaction(
      token,
      token.function("borrow"),
      [amount],
    );
  }

  Future<BigInt> getBalance(String address) async {
    return (await client.call(
      token,
      token.function("borrowBalanceCurrent"),
      [EthereumAddress.fromHex(address)],
    ))
        .first as BigInt;
  }

  Future<BigInt> checkBalance() async {
    return getBalance((await client.credentials.extractAddress()).hex);
  }
}

final jsonABI = jsonEncode([
  {
    "inputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "name": "borrow",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "address", "name": "account", "type": "address"}
    ],
    "name": "borrowBalanceCurrent",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "name": "mint",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "name": "redeemUnderlying",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "address", "name": "", "type": "address"},
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "name": "repayBorrowBehalf",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]);
