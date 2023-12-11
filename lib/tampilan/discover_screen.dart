import 'package:flutter/material.dart';
import 'package:flutter_helloword/models/article_model.dart';
import 'package:flutter_helloword/tampilan/article_screen.dart';
import 'package:flutter_helloword/widgets/bot_nav_bar.dart';
import 'package:flutter_helloword/widgets/image_container.dart';

class DiscoverScreen extends StatefulWidget {
  final TextEditingController? searchController;
  const DiscoverScreen({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  static const routeName = '/discover';

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Health',
      'Politics',
      'Technology',
      'Social',
      'Economy'
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(
          index: 1,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255), // Start color
                Color.fromARGB(255, 126, 126, 126), // End color
              ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              _DiscoverNews(searchController: searchController),
              searchController.text.isEmpty
                  ? _CategoryNews(tabs: tabs)
                  : _SearchNews(searchKeyword: searchController.text),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchNews extends StatelessWidget {
  final String searchKeyword;

  const _SearchNews({Key? key, required this.searchKeyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: Article.fetchSearch(searchKeyword),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Article> articles = snapshot.data!;
          return Column(
            children: [
              // Display the search results
              ListView.builder(
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, articleIndex) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ArticleScreen.routeName,
                        arguments: articles[articleIndex],
                      );
                    },
                    child: Row(
                      children: [
                        ImageContainer(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.all(10.0),
                          imageUrl: articles[articleIndex].imageUrl,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                articles[articleIndex].title,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${DateTime.now().difference(articles[articleIndex].createdAt).inHours} hours ago',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.visibility,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${articles[articleIndex].views} views',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class _CategoryNews extends StatelessWidget {
  const _CategoryNews({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

  Future<List<Article>> fetchCategoryArticles(int tabIndex) async {
    switch (tabIndex) {
      case 0:
        return Article.fetchArticlesByCategory(1);
      case 1:
        return Article.fetchArticlesByCategory(2);
      case 2:
        return Article.fetchArticlesByCategory(3);
      case 3:
        return Article.fetchArticlesByCategory(4);
      case 4:
        return Article.fetchArticlesByCategory(5);
      default:
        throw Exception('Invalid category index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: fetchCategoryArticles(DefaultTabController.of(context)!.index),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                tabs: tabs
                    .map(
                      (tab) => Tab(
                        icon: Text(
                          tab,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: tabs
                      .asMap()
                      .map(
                        (index, tab) => MapEntry(
                          index,
                          FutureBuilder<List<Article>>(
                            future: fetchCategoryArticles(index),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                List<Article> articles = snapshot.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: articles.length,
                                  itemBuilder: (context, articleIndex) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          ArticleScreen.routeName,
                                          arguments: articles[articleIndex],
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          ImageContainer(
                                            width: 80,
                                            height: 80,
                                            margin: const EdgeInsets.all(10.0),
                                            imageUrl:
                                                articles[articleIndex].imageUrl,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  articles[articleIndex].title,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.schedule,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      '${DateTime.now().difference(articles[articleIndex].createdAt).inHours} hours ago',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Icon(
                                                      Icons.visibility,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      '${articles[articleIndex].views} views',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              )
            ],
          );
        }
      },
    );
  }
}

class _DiscoverNews extends StatelessWidget {
  final TextEditingController searchController;
  const _DiscoverNews({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Discover",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Hot News Today For You",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
