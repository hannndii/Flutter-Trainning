import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Nav Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Halaman statis
  final List<Widget> _pages = const [
    DashboardPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// 🏠 Dashboard Page
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.dashboard, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Selamat datang di Dashboard!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('semoga lewis bisa jurdun tahun depan'),
        ],
      ),
    );
  }
}

// 👤 Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpg'), // ganti sesuai asset kamu
          ),
          SizedBox(height: 16),
          Text(
            'Nama: Muhammad Endihan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Email: endihan@example.com'),
        ],
      ),
    );
  }
}

// ⚙️ Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifikasi'),
          subtitle: Text('Aktif'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Privasi'),
          subtitle: Text('Pengaturan keamanan akun'),
        ),
      ],
    );
  }
}
