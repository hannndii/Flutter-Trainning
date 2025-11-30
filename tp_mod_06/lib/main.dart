import 'package:flutter/material.dart';

class ItemData {
  final String title;
  final String subtitle;
  final Color color;
  final String details;

  const ItemData({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.details,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView dengan Dialog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<ItemData> dataList = const [
    ItemData(
      title: 'Native App',
      subtitle: 'Android, iOS',
      color: Colors.red,
      details: 'Java, Kotlin, Swift, C#',
    ),
    ItemData(
      title: 'Hybrid App',
      subtitle: 'Android, iOS, Web',
      color: Colors.grey,
      details: 'Javascript, Dart',
    ),
  ];

  void _showDetailDialog(BuildContext context, ItemData data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detail',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(data.details),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView dengan Dialog'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = dataList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item.color,
                radius: 20,
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              subtitle: Text(item.subtitle),
              onTap: () {
                _showDetailDialog(context, item);
              },
            ),
          );
        },
      ),
    );
  }
}