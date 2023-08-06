import 'dart:convert';

import 'package:d01/Screens/NewsList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var skillsType = [];
  var json = [];
  var nowExpanded = "";
  var searching = false;
  var titleController = TextEditingController();
  var skillController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    parseJson();
    super.initState();
  }

  void parseJson() async {
    json = jsonDecode(await DefaultAssetBundle.of(context).loadString("res/skills.json"));
    for (var i in json) {
      var have = false;
      for (var j in skillsType) {
        if (i["Type"] == j) {
          have = true;
        }
      }
      if (!have) {
        skillsType.add(i["Type"]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!searching) {
      return Drawer(
        child: Column(
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.purple.shade800,
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "res/block.png",
                        width: 50,
                      ),
                      const Text(
                        "Skills",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white, // here for close state
                    colorScheme: ColorScheme.light(
                      primary: Colors.white,
                    ),
                  ),
                  child: ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    elevation: 1,
                    expansionCallback: (index, isExpanded) {
                      if (!isExpanded) {
                        nowExpanded = skillsType[index];
                      } else {
                        nowExpanded = "";
                      }
                      setState(() {});
                    },
                    children: [
                      for (var tisSkill in skillsType)
                        ExpansionPanel(
                            isExpanded: nowExpanded == tisSkill,
                            canTapOnHeader: true,
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return ListTile(
                                leading: nowExpanded == tisSkill
                                    ? Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      )
                                    : Image.asset(
                                        "res/block_gold.png",
                                        width: 20,
                                      ),
                                title: Text(
                                  tisSkill,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              );
                            },
                            body: Column(
                              children: ListTile.divideTiles(
                                color: Colors.grey,
                                context: context,
                                tiles: [
                                  for (var skill in json.where((element) => element["Type"] == nowExpanded))
                                    InkWell(
                                      onTap: () {
                                        Get.to(const NewsList(
                                          keyWord: "",
                                        ));
                                      },
                                      child: ListTile(
                                        leading: Container(
                                          width: 20,
                                        ),
                                        title: Row(
                                          children: [
                                            Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              skill["Name"],
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ).toList(),
                            )),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                searching = true;
                setState(() {});
              },
              child: Container(
                color: Colors.purple.shade800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Can't find you want?",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            "Search Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Drawer(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.purple.shade800,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        searching = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "News Title",
                          hoverColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: skillController,
                        decoration: const InputDecoration(
                          hintText: "Skill Name",
                          hoverColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: startDateController,
                              decoration: const InputDecoration(
                                hintText: "Start Date\n(MM/dd/yyyy)",
                                hintMaxLines: 2,
                                hoverColor: Colors.white,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: endDateController,
                              decoration: const InputDecoration(
                                hintText: "End Date\n(MM/dd/yyyy)",
                                hintMaxLines: 2,
                                hoverColor: Colors.white,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (titleController.text.isEmpty ||
                            titleController.text.length > 10 ||
                            skillController.text.length < 3 ||
                            skillController.text.length > 10 ||
                            !RegExp("^[0-9]{2}\/[0-9]{2}\/[0-9]{4}\$").hasMatch(startDateController.text) ||
                            !RegExp("^[0-9]{2}\/[0-9]{2}\/[10-9]{4}\$").hasMatch(endDateController.text)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: Text("Wrong Format"),
                                );
                              });
                          return;
                        }
                        var sd = startDateController.text.split("/");
                        var ed = endDateController.text.split("/");
                        var sDate = DateTime(int.parse(sd[2]), int.parse(sd[0]), int.parse(sd[1]));
                        var eDate = DateTime(int.parse(ed[2]), int.parse(ed[0]), int.parse(ed[1]));
                        if (sDate.isAfter(eDate)) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: Text("Wrong Date"),
                                );
                              });
                          return;
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return NewsList(
                            keyWord: jsonEncode(
                              {
                                "title": titleController.text,
                                "skill": skillController.text,
                                "start": sDate.toIso8601String(),
                                "end": eDate.toIso8601String()
                              },
                            ),
                          );
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(360), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.purple.shade800,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
