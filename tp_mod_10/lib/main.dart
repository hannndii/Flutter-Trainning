import 'package:flutter/material.dart';
import 'db_helper.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP MOD 10 - SQFlite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, 
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _refreshJournals() async {
    final data = await SQLHelper.readItem();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); 
  }

  Future<void> _addItem() async {
    await SQLHelper.addItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals(); // Refresh list setelah tambah data
  }

  void _showForm(BuildContext context) {
    _titleController.text = '';
    _descriptionController.text = '';

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
              child: Text(
                "Tambah Data Baru",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  hintText: 'Title Data 1', labelText: 'Title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Desc Data 1', labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], 
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // Validasi sederhana
                  if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Isi semua kolom!'),
                      ));
                      return;
                  }
                  
                  await _addItem();
                  
                  if(!mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP MOD 10 - SQFlite'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _journals.isEmpty
              ? const Center(
                  child: Text(
                    "Belum ada data wak 😴",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _journals.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(
                        _journals[index]['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_journals[index]['description']),
                          const SizedBox(height: 5,),
                          Text(
                            _journals[index]['createdAt'],
                            style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context), 
        child: const Icon(Icons.add),
      ),
    );
  }
}