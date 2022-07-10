class TextConstant {
  TextConstant._();
  // Role
  //static const String admin = "admin";

  static late Map<int, String> pools = {
    1 : "Aave",
    2 : "Compound",
  };

  static const List<String> transaction_type = ["Deposit","Borrow","Repay","Withdraw"];

  static const List<String> coinCodeList = ["WETH","AAVE","BAT","DAI","FEI",
                                            "TUSD","UNI","USDP","YFI","ZRX"];

  // Error at MKR
  static const Map<String, String> aaveTokenList = {
    "WETH" : "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
    "AAVE" : "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
    "BAT" : "0x0D8775F648430679A709E98d2b0Cb6250d2887EF",
    "DAI" : "0x6B175474E89094C44Da98b954EedeAC495271d0F",
    "FEI" : "0x956F47F50A910163D8BF957Cf5846D573E7f87CA",
    "MKR" : "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2",
    "TUSD" : "0x0000000000085d4780B73119b644AE5ecd22b376",
    "UNI" : "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
    "USDP" : "0x8E870D67F660D95d5be530380D0eC0bd388289E1",
    "YFI" : "0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e",
    "ZRX" : "0xE41d2489571d322189246DaFA5ebDe1F4699F498",
  };

  static const Map<String, String>  compoundTokenList = {
    "WETH" : "",
    "AAVE" : "0xe65cdb6479bac1e22340e4e755fae7e509ecd06c",
    "BAT" : "0x6c8c6b02e7b2be14d4fa6022dfd6d75921d90e4e",
    "DAI" : "0x5d3a536e4d6dbd6114cc1ead35777bab948e3643",
    "FEI" : "0x7713dd9ca933848f6819f38b8352d9a15ea73f67",
    "MKR" : "0x95b4ef2869ebd94beb4eee400a99824bf5dc325b",
    "TUSD" : "0x12392f67bdf24fae0af363c24ac620a2f67dad86",
    "UNI" : "0x35a18000230da775cac24873d00ff85bccded550",
    "USDP" : "0x041171993284df560249b57358f931d9eb7b925d",
    "YFI" : "0x80a2ae356fc9ef4305676f7a3e2ed04e12c33946",
    "ZRX" : "0xb3319f5d18bc0d84dd1b4825dcde5d5f7266d407",
  };

  static const Map<String, String> coinIconList = {
    "WETH" : "assets/images/coins/weth.png",
    "AAVE" : "assets/images/coins/aave.png",
    "BAT" : "assets/images/coins/bat.png",
    "DAI" : "assets/images/coins/dai.png",
    "FEI" : "assets/images/coins/fei.png",
    "MKR" : "assets/images/coins/mrk.png",
    "TUSD" : "assets/images/coins/tusd.png",
    "UNI" : "assets/images/coins/uni.png",
    "USDP" : "assets/images/coins/usdp.png",
    "YFI" : "assets/images/coins/yfi.png",
    "ZRX" : "assets/images/coins/zrx.png",
  };

  static const Map<String, String> coinNameList = {
    "WETH" : "WETH",
    "AAVE" : "AAVE",
    "BAT" : "Basic Attention Token",
    "DAI" : "DAI",
    "FEI" : "FEI USD",
    "MKR" : "Maker",
    "TUSD" : "TrueUSD",
    "UNI" : "Uniswap",
    "USDP" : "USDP",
    "YFI" : "yearn.finance",
    "ZRX" : "0x",
  };
}