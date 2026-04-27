import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lead.dart';
import '../models/opportunity.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiService {
  ApiService({required this.baseUrl});
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<List<Lead>> fetchLeads() async {
    final resp = await http.get(_uri('/api/leads'));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load leads');
    }
    final data = json.decode(resp.body);
    // GHL returns object - adapt if needed
    if (data is List) {
      return data.map((e) => Lead.fromJson(e)).toList();
    }
    if (data['contacts'] != null && data['contacts'] is List) {
      return (data['contacts'] as List).map((e) => Lead.fromJson(e)).toList();
    }
    return [];
  }

  Future<Lead> createLead(String name, {String? email, String? phone}) async {
    final body = {'name': name, 'email': email, 'phone': phone};
    final resp = await http.post(_uri('/api/leads'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    if (resp.statusCode != 201) {
      throw Exception('Failed to create lead');
    }
    final data = json.decode(resp.body);
    return Lead.fromJson(data);
  }

  Future<List<Opportunity>> fetchOpportunities() async {
    final resp = await http.get(_uri('/api/opportunities'));
    if (resp.statusCode != 200) throw Exception('Failed to load opportunities');
    final data = json.decode(resp.body);
    if (data is List) return data.map((e) => Opportunity.fromJson(e)).toList();
    if (data['opportunities'] != null && data['opportunities'] is List) {
      return (data['opportunities'] as List).map((e) => Opportunity.fromJson(e)).toList();
    }
    return [];
  }

  Future<Opportunity> createOpportunity(Map<String, dynamic> payload) async {
    final resp = await http.post(_uri('/api/opportunities'), headers: {'Content-Type': 'application/json'}, body: json.encode(payload));
    if (resp.statusCode != 201) throw Exception('Failed to create opportunity');
    return Opportunity.fromJson(json.decode(resp.body));
  }

  Future<String> createWhatsAppLink(String phone, String message) async {
    final resp = await http.post(_uri('/api/whatsapp/send'), headers: {'Content-Type': 'application/json'}, body: json.encode({'phone': phone, 'message': message}));
    if (resp.statusCode != 200) throw Exception('Failed to create whatsapp link');
    final data = json.decode(resp.body);
    return data['url'];
  }

  Future<void> launchUrlString(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw Exception('Could not launch $url');
  }
}
