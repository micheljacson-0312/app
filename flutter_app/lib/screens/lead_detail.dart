import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead.dart';
import '../services/api.dart';

class LeadDetailScreen extends ConsumerWidget {
  const LeadDetailScreen({super.key, required this.lead});
  final Lead lead;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(lead.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Name: ${lead.name}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Email: ${lead.email ?? '-'}'),
          const SizedBox(height: 8),
          Text('Phone: ${lead.phone ?? '-'}'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.whatsapp),
            label: const Text('WhatsApp'),
            onPressed: () async {
              final phone = lead.phone;
              if (phone == null || phone.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No phone number')));
                return;
              }
              final message = 'Hello ${lead.name}, following up from CRM.';
              try {
                final url = await ref.read(apiProvider).createWhatsAppLink(phone, message);
                await ref.read(apiProvider).launchUrlString(url);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
              }
            },
          ),
        ]),
      ),
    );
  }
}
