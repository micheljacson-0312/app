class Lead {
  final String id;
  final String name;
  final String? email;
  final String? phone;

  Lead({required this.id, required this.name, this.email, this.phone});

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id']?.toString() ?? json['contactId']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'] ?? json['phoneNumber'],
    );
  }
}
