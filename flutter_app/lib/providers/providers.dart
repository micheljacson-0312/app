import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api.dart';
import '../models/lead.dart';

final apiProvider = Provider<ApiService>((ref) {
  // Point to local backend by default
  return ApiService(baseUrl: 'http://10.0.2.2:4000');
});

final leadsProvider = StateNotifierProvider<LeadsNotifier, AsyncValue<List<Lead>>>((ref) {
  final api = ref.watch(apiProvider);
  return LeadsNotifier(api);
});

class LeadsNotifier extends StateNotifier<AsyncValue<List<Lead>>> {
  LeadsNotifier(this.api) : super(const AsyncValue.loading()) {
    load();
  }

  final ApiService api;

  Future<void> load() async {
    try {
      state = const AsyncValue.loading();
      final leads = await api.fetchLeads();
      state = AsyncValue.data(leads);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(String name, {String? email, String? phone}) async {
    try {
      final newLead = await api.createLead(name, email: email, phone: phone);
      state = state.whenData((list) => [newLead, ...list]);
    } catch (e) {
      rethrow;
    }
  }
}
