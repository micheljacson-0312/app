import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/leads_list.dart';
import 'services/notifications.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifications.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GHL CRM',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LeadsListScreen(),
    );
  }
}
