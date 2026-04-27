import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/opportunity.dart';
import '../services/api.dart';

class OpportunitiesListScreen extends ConsumerWidget {
  const OpportunitiesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Opportunities')),
      body: FutureBuilder<List<Opportunity>>(
        future: ref.read(apiProvider).fetchOpportunities(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final items = snap.data ?? [];
          if (items.isEmpty) return const Center(child: Text('No opportunities'));
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final o = items[i];
              return ListTile(
                title: Text(o.name),
                subtitle: Text('Value: ${o.value ?? '-'} | Stage: ${o.stage ?? '-'}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // simple create flow
          final res = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOpportunityScreen()));
          if (res == true) {
            (context as Element).reassemble();
          }
        },
      ),
    );
  }
}

class CreateOpportunityScreen extends ConsumerStatefulWidget {
  const CreateOpportunityScreen({super.key});

  @override
  ConsumerState<CreateOpportunityScreen> createState() => _CreateOpportunityScreenState();
}

class _CreateOpportunityScreenState extends ConsumerState<CreateOpportunityScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _value;

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    _formKey.currentState?.save();
    final payload = {'name': _name, 'value': double.tryParse(_value ?? '0')};
    try {
      await ref.read(apiProvider).createOpportunity(payload);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Opportunity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(decoration: const InputDecoration(labelText: 'Name'), validator: (v) => (v == null || v.isEmpty) ? 'Required' : null, onSaved: (v) => _name = v),
            TextFormField(decoration: const InputDecoration(labelText: 'Value'), keyboardType: TextInputType.number, onSaved: (v) => _value = v),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text('Create'))
          ]),
        ),
      ),
    );
  }
}
