import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';

import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;
  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebToonDetailModel> webtoonDetail;
  late Future<List<WebToonEpisodeModel>> webtoonEpisodes;

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getWebtoonDetail(widget.id);
    webtoonEpisodes = ApiService.getLatestEpisodeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                        ),
                      ],
                    ),
                    child: Image.network(
                      widget.thumb,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
