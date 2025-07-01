// screens/CategoryNews/newtab.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryNews/news.dart';

class NewsAppPage extends StatefulWidget {
  const NewsAppPage({super.key});

  @override
  State<NewsAppPage> createState() => _NewsAppPageState();
}

class _NewsAppPageState extends State<NewsAppPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "News",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            indicatorWeight: 4,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: const [
              Tab(text: "Spesialis Gizi"),
              Tab(text: "Gaya Hidup"),
              Tab(text: "Kedokteran Olahraga"),
            ],
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            // 🔶 Banner Peringatan
            Container(
              width: double.infinity,
              color: Colors.yellow[100],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '⚠️ Berita yang ditampilkan tidak dijamin 100% benar. '
                      'Silakan verifikasi dari sumber terpercaya.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Trending Section
            buildTrendingNowSection(context),

            // 🔹 TabBarView Berita
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildNewsList("Kesehatan", context),
                  buildNewsList("Medis", context),
                  buildNewsList("Olahraga", context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
