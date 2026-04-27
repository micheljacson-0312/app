class Opportunity {
  final String id;
  final String name;
  final double? value;
  final String? stage;

  Opportunity({required this.id, required this.name, this.value, this.stage});

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      value: json['value'] != null ? (json['value'] as num).toDouble() : null,
      stage: json['stage']?.toString(),
    );
  }
}
