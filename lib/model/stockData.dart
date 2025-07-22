class StockData {
  final String symbol;
  final String name;
  final double price;
  final double changesPercentage;

  StockData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changesPercentage,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      symbol: json['symbol'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      changesPercentage: (json['changesPercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
