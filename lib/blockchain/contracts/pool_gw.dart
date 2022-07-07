import 'dart:convert';

import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:web3dart/web3dart.dart';

class PoolGW {
  final DeployedContract gw;
  final EthClient client;

  PoolGW._(this.gw, this.client);

  factory PoolGW(String address, EthClient client) => PoolGW._(
        DeployedContract(
          ContractAbi.fromJson(jsonABI, "PoolGW"),
          EthereumAddress.fromHex(address),
        ),
        client,
      );

  Future<String> deposit(String name, String assetAddress, BigInt amount) =>
      client.sendTransaction(
        gw,
        gw.function("deposit"),
        [
          name,
          EthereumAddress.fromHex(assetAddress),
          amount,
        ],
      );

  Future<String> withdraw(String name, String assetAddress, BigInt amount) =>
      client.sendTransaction(
        gw,
        gw.function("withdraw"),
        [
          name,
          EthereumAddress.fromHex(assetAddress),
          amount,
        ],
      );

  Future<String> borrow(String name, String assetAddress, BigInt amount) =>
      client.sendTransaction(
        gw,
        gw.function("borrow"),
        [
          name,
          EthereumAddress.fromHex(assetAddress),
          amount,
        ],
      );

  Future<String> repay(String name, String assetAddress, BigInt amount) =>
      client.sendTransaction(
        gw,
        gw.function("repay"),
        [
          name,
          EthereumAddress.fromHex(assetAddress),
          amount,
        ],
      );

  Future<EthereumAddress> getGatewayAddress(String name) => client.call(
        gw,
        gw.function("getGatewayAddress"),
        [name],
      ).then((value) => value.first as EthereumAddress);

  Future<EthereumAddress> getReverse(String name, String assetAddress) =>
      client.call(
        gw,
        gw.function("getReverse"),
        [name, EthereumAddress.fromHex(assetAddress)],
      ).then((value) => value.first as EthereumAddress);

  Future<EthereumAddress> getDebt(String name, String assetAddress) =>
      client.call(
        gw,
        gw.function("getReverse"),
        [name, EthereumAddress.fromHex(assetAddress)],
      ).then((value) => value[1] as EthereumAddress);
}

final jsonABI = jsonEncode([
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "previousOwner",
        "type": "address"
      },
      {
        "indexed": true,
        "internalType": "address",
        "name": "newOwner",
        "type": "address"
      }
    ],
    "name": "OwnershipTransferred",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "allGateway",
    "outputs": [
      {"internalType": "string[]", "name": "", "type": "string[]"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "asset", "type": "address"},
      {"internalType": "uint256", "name": "amount", "type": "uint256"}
    ],
    "name": "borrow",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "asset", "type": "address"},
      {"internalType": "uint256", "name": "amount", "type": "uint256"}
    ],
    "name": "deposit",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"}
    ],
    "name": "getGatewayAddress",
    "outputs": [
      {"internalType": "address", "name": "", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "asset", "type": "address"}
    ],
    "name": "getReverse",
    "outputs": [
      {"internalType": "address", "name": "rTokenAddress", "type": "address"},
      {"internalType": "address", "name": "debtTokenAddress", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "poolAddress", "type": "address"}
    ],
    "name": "newGateway",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "owner",
    "outputs": [
      {"internalType": "address", "name": "", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "renounceOwnership",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "asset", "type": "address"},
      {"internalType": "uint256", "name": "amount", "type": "uint256"}
    ],
    "name": "repay",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "address", "name": "newOwner", "type": "address"}
    ],
    "name": "transferOwnership",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string", "name": "name", "type": "string"},
      {"internalType": "address", "name": "asset", "type": "address"},
      {"internalType": "uint256", "name": "amount", "type": "uint256"}
    ],
    "name": "withdraw",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]);
