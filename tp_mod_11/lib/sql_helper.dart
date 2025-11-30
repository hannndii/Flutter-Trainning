import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://69214260512fb4140bdfbd45.mockapi.io/api/v1/user";
  // READ
  static Future<List<dynamic>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  // CREATE
  static Future<void> createItem(String title, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "description": description}),
    );
    if (response.statusCode != 201) {
      throw Exception("Gagal membuat data");
    }
  }

  // UPDATE
  static Future<void> updateItem(
    String id,
    String title,
    String description,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "description": description}),
    );
    if (response.statusCode != 200) {
      throw Exception("Gagal mengupdate data");
    }
  }

  // DELETE
  static Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus data");
    }
  }
}
