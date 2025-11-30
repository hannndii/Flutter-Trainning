import 'package:flutter/material.dart';

class Comic {
  final String title;
  final String category;
  final String description;
  final Color color;

  Comic({
    required this.title,
    required this.category,
    required this.description,
    required this.color,
  });
}

final List<Comic> comicData = [
  Comic(
    title: 'Boku no Hero Academia',
    category: 'Manga',
    description:
        'Boku no Hero Academia adalah manga shōnen Jepang karya Kōhei Horikoshi yang mengisahkan tentang Izuku Midoriya, seorang anak laki-laki tanpa kekuatan di dunia di mana hampir semua orang memilikinya. Ia kemudian bertemu All Might dan mulai perjalanan menjadi pahlawan.',
    color: Colors.yellow,
  ),
  Comic(
    title: 'Jujutsu Kaisen',
    category: 'Manga',
    description:
        'Jujutsu Kaisen adalah manga shōnen Jepang karya Gege Akutami. Menceritakan Itadori Yuji, seorang siswa SMA yang terlibat dengan dunia Jujutsu setelah memakan jari Ryomen Sukuna. Manga ini terbit di Weekly Shōnen Jump sejak 2018 dan telah diadaptasi menjadi anime populer.',
    color: Colors.lightBlue.shade300,
  ),
  Comic(
    title: 'One Piece',
    category: 'Manga',
    description:
        'Manga karya Eiichiro Oda. Mengisahkan petualangan Monkey D. Luffy, seorang anak laki-laki yang memiliki tubuh elastis setelah tidak sengaja memakan Buah Iblis. Dengan kru bajak lautnya, Luffy menjelajahi Grand Line untuk mencari "One Piece" agar menjadi Raja Bajak Laut.',
    color: Colors.red.shade400,
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic Books App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YourName's Comic Books"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: comicData.length,
        itemBuilder: (BuildContext context, int index) {
          final comic = comicData[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: comic.color,
              radius: 20,
            ),
            title: Text(comic.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(comic: comic),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Comic comic;

  const DetailPage({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    final appBarTextColor =
        comic.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        backgroundColor: comic.color,
        foregroundColor: appBarTextColor,
        iconTheme: IconThemeData(
          color: appBarTextColor,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comic.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      comic.category,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      comic.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('KEMBALI'),
            ),
          ),
        ],
      ),
    );
  }
}