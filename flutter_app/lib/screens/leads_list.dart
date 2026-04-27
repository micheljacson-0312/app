import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'add_lead.dart';

class LeadsListScreen extends ConsumerWidget {
  const LeadsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadsState = ref.watch(leadsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(leadsProvider.notifier).load(),
          )
        ],
      ),
      body: leadsState.when(
        data: (leads) {
          if (leads.isEmpty) return const Center(child: Text('No leads'));
          return ListView.separated(
            itemCount: leads.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final l = leads[i];
              return ListTile(
                title: Text(l.name),
                subtitle: Text('${l.email ?? ''} ${l.phone ?? ''}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddLeadScreen()));
          if (added == true) {
            ref.read(leadsProvider.notifier).load();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
