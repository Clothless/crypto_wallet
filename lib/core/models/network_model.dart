class Network {
  final int id;
  final String name;
  final String rpcUrl;

  Network({
    required this.id,
    required this.name,
    required this.rpcUrl,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      rpcUrl: json['rpcUrl'],
    );
  }
}
