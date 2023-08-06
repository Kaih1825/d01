import 'dart:convert';
import 'dart:ui';

import 'package:d01/Widgets/NewsDialog.dart';
import 'package:flutter/material.dart';

import '../Widgets/Drawer.dart';

class NewsList extends StatefulWidget {
  final String keyWord;
  const NewsList({super.key, required this.keyWord});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  GlobalKey<ScaffoldState> scKey = GlobalKey();
  var news = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
  }

  void parseJson() async {
    news = jsonDecode(await DefaultAssetBundle.of(context).loadString("res/news.json"));
    if (widget.keyWord != "") {
      var keywordJson = jsonDecode(widget.keyWord);
      news = news.where((e) {
        var sd = e["Date"].toString().split("/");
        var sDate = DateTime(int.parse(sd[2]), int.parse(sd[0]), int.parse(sd[1]));
        return (DateTime.parse(keywordJson["start"])).isBefore(sDate) &&
            (DateTime.parse(keywordJson["end"])).isAfter(sDate) &&
            "all skills".contains(keywordJson["skill"].toString().toLowerCase()) &&
            e["Title"].toString().toLowerCase().contains(keywordJson["title"].toString().toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            if (scKey.currentState!.isDrawerOpen) {
              scKey.currentState!.closeDrawer();
            } else {
              scKey.currentState!.openDrawer();
            }
          },
        ),
        title: Image.asset(
          "res/logo.png",
          height: 50,
        ),
      ),
      body: Scaffold(
          key: scKey,
          drawer: const DrawerWidget(),
          body: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Stack(
                  children: [
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Image.asset(
                        "res/${widget.keyWord == "" ? "s1" : "s2"}.jpeg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "res/block.png",
                            width: 40,
                          ),
                          Text(
                            widget.keyWord == "" ? "Information Network Cabling" : "Search Results",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView.builder(
                    itemCount: news.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NewsDialog(
                                    news: news[index],
                                  );
                                });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff2E6C91),
                                  Color(0xff153C63),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  DefaultTextStyle(
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.3,
                                          child: Text(
                                            news[index]["Title"],
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          (index + 1).toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  DefaultTextStyle(
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "All skills",
                                        ),
                                        const Spacer(),
                                        Text(
                                          news[index]["Date"],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
