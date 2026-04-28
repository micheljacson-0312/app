import 'package:flutter_test/flutter_test.dart';
import 'package:ghl_crm_app/models/lead.dart';
import 'package:ghl_crm_app/models/opportunity.dart';

void main() {
  test('Lead fromJson', () {
    final json = {'id': '1', 'name': 'John Doe', 'email': 'a@b.com', 'phone': '123'};
    final lead = Lead.fromJson(json);
    expect(lead.id, '1');
    expect(lead.name, 'John Doe');
    expect(lead.email, 'a@b.com');
  });

  test('Opportunity fromJson', () {
    final json = {'id': '10', 'name': 'Deal', 'value': 2500, 'stage': 'prospect'};
    final op = Opportunity.fromJson(json);
    expect(op.id, '10');
    expect(op.name, 'Deal');
    expect(op.value, 2500.0);
  });
}
