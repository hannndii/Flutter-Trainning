import 'package:flutter/material.dart';
import '../shared/theme.dart'; // Import theme yang sudah kita buat

// 1. DATA MODEL (Model untuk produk)
class Product {
  final String imageUrl;
  final String name;
  final int price;
  final String stockInfo;
  final double rating;
  final String location;
  // --- DITAMBAHKAN ---
  // Menambahkan kategori untuk filtering
  final String category; 
  // --- AKHIR TAMBAHAN ---

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.stockInfo,
    required this.rating,
    required this.location,
    // --- DITAMBAHKAN ---
    required this.category, 
    // --- AKHIR TAMBAHAN ---
  });
}

// 2. DUMMY DATA (Data palsu sesuai gambar)
// --- DIPERBARUI DENGAN KATEGORI ---
final List<Product> dummyProducts = [
  Product(
    imageUrl: 'assets/etalase_produk/id-card.jpeg',
    name: 'ID Card + Lanyard',
    price: 5000,
    stockInfo: 'Stok 80rb+ • Terjual 20rb+',
    rating: 4.8,
    location: 'Kota Bandung',
    category: 'Media Cetak', // Kategori ditambahkan
  ),
  Product(
    imageUrl: 'assets/etalase_produk/jersey.jpeg', // Menggunakan jersey.jpeg untuk kaos
    name: 'Kaos Cotton Combed',
    price: 35000,
    stockInfo: 'Stok 55rb+ • Terjual 72rb+',
    rating: 4.3,
    location: 'Kota Administrasi Jakarta',
    category: 'Kaos', // Kategori ditambahkan
  ),
  Product(
    // Menggunakan nama file yang panjang dari screenshot Anda
    imageUrl: 'assets/etalase_produk/Furniture Store Bifold Brochure Template PSD, INDD.jpeg',
    name: 'Brosur Company Profile',
    price: 12000,
    stockInfo: 'Stok 100rb+ • Terjual 150rb+',
    rating: 5.0,
    location: 'Kab. Bandung',
    category: 'Brosur', // Kategori ditambahkan
  ),
  // Menambahkan Tote Bag dari screenshot baru Anda
  Product(
    imageUrl: 'assets/etalase_produk/totebag.jpeg', 
    name: 'Custom Tote Bag',
    price: 10000,
    stockInfo: 'Stok 80rb+ • Terjual 20rb+',
    rating: 4.8,
    location: 'Kota Bandung',
    category: 'Media Promosi', // Kategori ditambahkan
  ),
  // Data duplikat untuk contoh
  Product(
    imageUrl: 'assets/etalase_produk/id-card.jpeg',
    name: 'ID Card Premium',
    price: 8000,
    stockInfo: 'Stok 50rb+ • Terjual 10rb+',
    rating: 4.9,
    location: 'Kota Bandung',
    category: 'Media Cetak', // Kategori ditambahkan
  ),
  Product(
    imageUrl: 'assets/etalase_produk/x-banner.jpeg',
    name: 'X-Banner Event',
    price: 75000,
    stockInfo: 'Stok 1rb+ • Terjual 500+',
    rating: 4.7,
    location: 'Jakarta Selatan',
    category: 'Media Promosi', // Kategori ditambahkan
  ),
];
// --- AKHIR PERUBAHAN DATA ---


// 3. PRODUCT PAGE WIDGET
class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // --- STATE UNTUK FILTER DITAMBAHKAN ---
  // Daftar filter. "Semua" ditambahkan sebagai filter default.
  final List<String> filters = ['Semua', 'Media Cetak', 'Media Promosi', 'Kaos', 'Brosur'];
  // Menyimpan kategori yang sedang dipilih
  late String _selectedCategory;
  // Menyimpan daftar produk yang sudah difilter
  late List<Product> _filteredProducts;
  // --- AKHIR PENAMBAHAN STATE ---

  // --- DITAMBAHKAN: initState ---
  // Inisialisasi state saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Atur filter default ke "Semua"
    _selectedCategory = filters[0]; 
    // Tampilkan semua produk saat pertama kali
    _filteredProducts = List.from(dummyProducts); 
  }
  // --- AKHIR initState ---

  // Indeks untuk Bottom Navigation Bar
  int _calculateCurrentIndex(BuildContext context) {
    // ... (kode _calculateCurrentIndex tidak berubah)
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/product':
        return 1;
      case '/cart':
        return 2;
      case '/profile':
        return 3;
      default:
        if (currentRoute == '/') {
          return 1;
        }
        return 1; // Default ke 'Produk'
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _calculateCurrentIndex(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNav(currentIndex),
    );
  }

  // WIDGET UNTUK APPBAR
  PreferredSizeWidget buildAppBar() {
    // ... (kode buildAppBar tidak berubah)
    return AppBar(
      backgroundColor: kWhiteColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: kBlackColor, size: 20),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        'Etalase Produk',
        style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
      ),
    );
  }

  // WIDGET UNTUK BODY
  // --- buildBody DIPERBARUI ---
  Widget buildBody() {
    return Column(
      children: [
        buildFilterChips(),
        // Gunakan Expanded agar GridView/Teks "Produk Kosong" mengisi sisa ruang
        Expanded(
          // Cek apakah daftar produk yang difilter kosong
          child: _filteredProducts.isEmpty
              ? Center(
                  // Tampilkan teks ini jika tidak ada produk
                  child: Text(
                    'Produk untuk kategori ini belum tersedia',
                    style: greyTextStyle.copyWith(fontSize: 16),
                  ),
                )
              : buildProductGrid(), // Tampilkan grid jika ada produk
        ),
      ],
    );
  }
  // --- AKHIR PERUBAHAN buildBody ---

  // WIDGET UNTUK FILTER CHIPS
  // --- buildFilterChips DIPERBARUI ---
  Widget buildFilterChips() {
    // final filters = ['Media Cetak', 'Media Promosi', 'Kaos', 'Brosur']; // Dipindahkan ke atas

    return Container(
      height: 60,
      color: kWhiteColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: filters.length, // Menggunakan list filter dari state
        itemBuilder: (context, index) {
          // Cek apakah filter ini adalah filter yang sedang dipilih
          bool isSelected = _selectedCategory == filters[index]; 
          
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(filters[index]),
              labelStyle: isSelected
                  ? primaryTextStyle.copyWith(fontWeight: medium)
                  : greyTextStyle.copyWith(fontWeight: regular),
              backgroundColor: isSelected ? kPrimaryColor.withOpacity(0.1) : kLightGreyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? kPrimaryColor : kLightGreyColor,
                ),
              ),
              // --- LOGIKA FILTER SAAT DITEKAN ---
              onPressed: () {
                // Panggil setState untuk membangun ulang UI dengan filter baru
                setState(() {
                  // Update kategori yang dipilih
                  _selectedCategory = filters[index];

                  // Logika untuk memfilter produk
                  if (_selectedCategory == 'Semua') {
                    // Jika "Semua", tampilkan semua produk
                    _filteredProducts = List.from(dummyProducts);
                  } else {
                    // Jika kategori lain, filter berdasarkan kategori
                    _filteredProducts = dummyProducts
                        .where((product) => product.category == _selectedCategory)
                        .toList();
                  }
                });
              },
              // --- AKHIR LOGIKA FILTER ---
            ),
          );
        },
      ),
    );
  }
  // --- AKHIR PERUBAHAN buildFilterChips ---

  // WIDGET UNTUK GRID PRODUK
  // --- buildProductGrid DIPERBARUI ---
  Widget buildProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,       
        crossAxisSpacing: 16,    
        mainAxisSpacing: 16,     
        childAspectRatio: 0.55,  // Rasio yang sudah kita perbaiki
      ),
      // Gunakan panjang daftar produk yang SUDAH DIFILTER
      itemCount: _filteredProducts.length, 
      itemBuilder: (context, index) {
        // Gunakan produk dari daftar yang SUDAH DIFILTER
        return ProductCard(product: _filteredProducts[index]); 
      },
    );
  }
  // --- AKHIR PERUBAHAN buildProductGrid ---

  // WIDGET UNTUK BOTTOM NAVIGATION BAR
  Widget buildBottomNav(int currentIndex) {
    // ... (kode buildBottomNav tidak berubah)
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        final String? currentRoute = ModalRoute.of(context)?.settings.name;

        switch (index) {
          case 0: // Beranda
            if (currentRoute != '/home') {
              Navigator.pushReplacementNamed(context, '/home');
            }
            break;
          case 1: // Produk
            if (currentRoute != '/product') {
              Navigator.pushReplacementNamed(context, '/product');
            }
            break;
          case 2: // Keranjang
            if (currentRoute != '/cart') {
              Navigator.pushReplacementNamed(context, '/cart');
            }
            break;
          case 3: // Profile
            if (currentRoute != '/profile') {
              Navigator.pushReplacementNamed(context, '/profile');
            }
            break;
        }
      },
      backgroundColor: kWhiteColor,
      type: BottomNavigationBarType.fixed, 
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kGreyColor,
      selectedLabelStyle: primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium),
      unselectedLabelStyle: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view_rounded),
          label: 'Produk',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}


// 4. PRODUCT CARD WIDGET
// --- TIDAK ADA PERUBAHAN DI PRODUCT CARD ---
class ProductCard extends StatelessWidget {
  final Product product;
// ... (kode ProductCard tidak berubah)
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              product.imageUrl,
              height: 150, 
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Detail Produk
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Rp${product.price}', 
                      style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '/pcs',
                      style: greyTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  product.stockInfo,
                  style: greyTextStyle.copyWith(fontSize: 10),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star_rate_rounded, color: kStarColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      product.rating.toString(),
                      style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: kGreyColor, size: 16),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        product.location,
                        style: greyTextStyle.copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

