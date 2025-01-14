class Asset {
  final String symbol;
  final String name;
  final String address;
  final String decimals;
  final String logo;

  Asset({
    required this.symbol,
    required this.name,
    required this.address,
    required this.decimals,
    required this.logo,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      symbol: json['symbol'],
      name: json['name'],
      address: json['address'],
      decimals: json['decimals'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'address': address,
      'decimals': decimals,
      'logo': logo,
    };
  }
}
