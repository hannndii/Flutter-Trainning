import 'package:flutter/material.dart';
import 'cat_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> cats = [
    {
      "name": "Mochi",
      "image": "https://placekitten.com/200/200",
      "desc": "Kucing lucu berwarna putih dengan mata biru."
    },
    {
      "name": "Luna",
      "image": "https://placekitten.com/201/200",
      "desc": "Kucing manja yang suka tidur sepanjang hari."
    },
    {
      "name": "Oreo",
      "image": "https://placekitten.com/202/200",
      "desc": "Kucing hitam putih mirip biskuit Oreo."
    },
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kucing Kesayangan"),
        centerTitle: true,
        backgroundColor: Color(0xFF9CAF88),
      ),
      body: ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return Card(
            color: Color(0xFFDDE2D0),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  cat["image"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(cat["name"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
              subtitle: Text(cat["desc"]!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CatDetailPage(cat["name"]!, cat["image"]!, cat["desc"]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
