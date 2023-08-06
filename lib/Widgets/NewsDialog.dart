import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class NewsDialog extends StatefulWidget {
  final news;

  const NewsDialog({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDialog> createState() => _NewsDialogState();
}

class _NewsDialogState extends State<NewsDialog> {
  var fontSize = 1.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            color: Color(0xff123761),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    widget.news["Date"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                    child: Image.asset("res/logo.png"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 500,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.news["Title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff123761),
                          fontWeight: FontWeight.bold,
                          fontSize: 20 * fontSize,
                        ),
                      ),
                    ),
                    Text(
                      widget.news["Content"],
                      style: TextStyle(fontSize: 15 * fontSize),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    color: Color(0xff123761),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              await AudioPlayer().play(AssetSource("pop.mp3"));
                              fontSize -= 0.1;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Aa",
                              style: TextStyle(color: Colors.white, fontSize: 15.0 * fontSize),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              fontSize += 0.1;
                              await AudioPlayer().play(AssetSource("pop.mp3"));
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
