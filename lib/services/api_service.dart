import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

import '../models/webtoon_detail_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';
  static const String episode = 'episode';

  static Future<List<WebToonModel>> getTodaysToon() async {
    List<WebToonModel> webtoonInstances = [];
    final uri = Uri.parse('$baseUrl/$today');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      // print(webtoons);
      for (var webtoon in webtoons) {
        // print(webtoon);
        final toon = WebToonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebToonDetailModel> getWebtoonDetail(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebToonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebToonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebToonEpisodeModel> episodeListInstances = [];
    final uri = Uri.parse('$baseUrl/$id/$episode');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> allEpisodes = jsonDecode(response.body);
      for (var episode in allEpisodes) {
        episodeListInstances.add(WebToonEpisodeModel.fromJson(episode));
      }
      return episodeListInstances;
    }
    throw Error();
  }
}
