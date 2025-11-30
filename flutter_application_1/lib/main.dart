import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DesignPlus',
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
        title: const Text('DesignPlus'),
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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        "icon": Icons.local_cafe,
        "name": "Starbucks Coffee",
        "date": "2 Dec 2020",
        "time": "3:09 PM",
        "amount": "-\$156.00",
        "color": Colors.green
      },
      {
        "icon": Icons.design_services,
        "name": "12/2021 Subscription",
        "date": "1 Dec 2020",
        "time": "10:00 PM",
        "amount": "-\$60.00",
        "color": Colors.pink
      },
      {
        "icon": Icons.movie,
        "name": "Netflix Subscription",
        "date": "11 Nov 2020",
        "time": "10:02 AM",
        "amount": "-\$87.00",
        "color": Colors.red
      },
      {
        "icon": Icons.shopping_bag,
        "name": "Shopee Purchase",
        "date": "8 Nov 2020",
        "time": "5:32 PM",
        "amount": "-\$45.00",
        "color": Colors.orange
      },
      {
        "icon": Icons.fastfood,
        "name": "McDonald's",
        "date": "5 Nov 2020",
        "time": "7:15 PM",
        "amount": "-\$24.00",
        "color": Colors.yellow
      },
      {
        "icon": Icons.directions_car,
        "name": "Grab Ride",
        "date": "2 Nov 2020",
        "time": "8:40 PM",
        "amount": "-\$15.00",
        "color": Colors.teal
      },
      {
        "icon": Icons.shopping_cart,
        "name": "Tokopedia Order",
        "date": "1 Nov 2020",
        "time": "9:25 AM",
        "amount": "-\$70.00",
        "color": Colors.blue
      },
      {
        "icon": Icons.local_gas_station,
        "name": "Fuel Refill",
        "date": "29 Oct 2020",
        "time": "1:00 PM",
        "amount": "-\$45.00",
        "color": Colors.deepPurple
      },
      {
        "icon": Icons.phone_iphone,
        "name": "iCloud Storage",
        "date": "25 Oct 2020",
        "time": "10:15 AM",
        "amount": "-\$10.00",
        "color": Colors.grey
      },
      {
        "icon": Icons.subscriptions,
        "name": "Spotify Premium",
        "date": "20 Oct 2020",
        "time": "9:30 PM",
        "amount": "-\$12.00",
        "color": Colors.greenAccent
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Spendings",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Cards section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  spendingCard(
                    icon: Icons.local_cafe,
                    label: "Starbucks",
                    color: Colors.greenAccent.shade400,
                  ),
                  spendingCard(
                    icon: Icons.sports_basketball,
                    label: "Dribbble",
                    color: Colors.pinkAccent.shade100,
                  ),
                  spendingCard(
                    icon: Icons.shopping_cart,
                    label: "Shopping",
                    color: Colors.yellow.shade300,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pie_chart, color: Colors.pink),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "You’ve spent \$1,547 on expenses over the past 2 months",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "View statistic >",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Expense list
              ListView.builder(
                itemCount: transactions.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = transactions[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: item['color'],
                      child: Icon(item['icon'], color: Colors.white),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("${item['date']} • ${item['time']}"),
                    trailing: Text(
                      item['amount'],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget spendingCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar(
          //   radius: 50,
          //   backgroundImage: AssetImage('image/profile.jpg'),
          // ),
          Image.asset(  
            'image/logo1.png',
            width: 100,
            height: 100,
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
