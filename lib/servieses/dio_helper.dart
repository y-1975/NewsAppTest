import 'package:dio/dio.dart';
import 'package:flutter_application_2/models/news_model.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<List<NewsModel>> getTopHeadlines({
    String lang = 'en',
    String? country,
    int max = 20,
  }) async {
    try {
      final response = await dio!.get('top-headlines', queryParameters: {
        'apiKey': '32e73a68843c44f3bc5ab850983ec22d', // استبدل بالـ API key بتاعك
        'language': lang,
        if (country != null) 'country': country,
        'pageSize': max,
      });

      final articles = response.data['articles'] as List;
      return articles.map((article) => NewsModel.fromJson(article)).toList();
    } catch (e) {
      throw Exception('Failed to fetch top headlines: $e');
    }
  }

  static Future<List<NewsModel>> searchNews({
    required String query,
    String lang = 'en',
    String? country,
    String? from,
    String? to,
    int max = 20,
  }) async {
    try {
      final response = await dio!.get('everything', queryParameters: {
        'apiKey': '32e73a68843c44f3bc5ab850983ec22d', // استبدل بالـ API key
        'q': query,
        'language': lang,
        if (country != null) 'country': country,
        if (from != null) 'from': from,
        if (to != null) 'to': to,
        'pageSize': max,
      });

      final articles = response.data['articles'] as List;
      return articles.map((article) => NewsModel.fromJson(article)).toList();
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}