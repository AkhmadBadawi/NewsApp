import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class Article extends Equatable {
  final int id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final String views;
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.createdAt,
  });

  static Future<String> fetchCategory(int id) async {
    final response = await http.get(
      Uri.parse('https://badawi.pythonanywhere.com/api/kategori/$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String kategori = data['cathegory'];

      return kategori;
    } else {
      throw Exception('Failed to load Category');
    }
  }

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(
      Uri.parse('https://badawi.pythonanywhere.com/api/berita'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      List<Article> articles = [];
      for (var articleData in dataList) {
        String category = await fetchCategory(articleData['category'] ?? 0);

        articles.add(
          Article(
            id: articleData['id'] ?? 0,
            title: articleData['title'] ?? "",
            subtitle: articleData['subtitle'] ?? "",
            body: articleData['body'] ?? "",
            author: articleData['author'] ?? "",
            authorImageUrl: articleData['author_image_url'] ?? "",
            category: category,
            imageUrl: articleData['image_url'] ?? "",
            views: articleData['views'] ?? "",
            createdAt: DateTime.parse(articleData['date_created'] ?? ""),
          ),
        );
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }


static Future<List<Article>> fetchArticlesByCategory(int id) async {
    final response = await http.get(
      Uri.parse('https://badawi.pythonanywhere.com/api/berita/kategori/$id'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      List<Article> articles = [];
      for (var articleData in dataList) {
        String category = await fetchCategory(articleData['category'] ?? 0);

        articles.add(
          Article(
            id: articleData['id'] ?? 0,
            title: articleData['title'] ?? "",
            subtitle: articleData['subtitle'] ?? "",
            body: articleData['body'] ?? "",
            author: articleData['author'] ?? "",
            authorImageUrl: articleData['author_image_url'] ?? "",
            category: category,
            imageUrl: articleData['image_url'] ?? "",
            views: articleData['views'] ?? "",
            createdAt: DateTime.parse(articleData['date_created'] ?? ""),
          ),
        );
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }


  static Future<List<Article>> fetchSearch(String kata) async {
    final response = await http.get(
      Uri.parse('https://badawi.pythonanywhere.com/api/berita/search/$kata'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      List<Article> articles = [];
      for (var articleData in dataList) {
        String category = await fetchCategory(articleData['category'] ?? 0);

        articles.add(
          Article(
            id: articleData['id'] ?? 0,
            title: articleData['title'] ?? "",
            subtitle: articleData['subtitle'] ?? "",
            body: articleData['body'] ?? "",
            author: articleData['author'] ?? "",
            authorImageUrl: articleData['author_image_url'] ?? "",
            category: category,
            imageUrl: articleData['image_url'] ?? "",
            views: articleData['views'] ?? "",
            createdAt: DateTime.parse(articleData['date_created'] ?? ""),
          ),
        );
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        views,
        createdAt,
      ];
}
