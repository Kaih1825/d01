import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Widgets/Drawer.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.light(primary: Color(0xff1D365F))),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "res/logo.png",
            height: 50,
          ),
          leading: IconButton(
            onPressed: () {
              if (scKey.currentState!.isDrawerOpen) {
                scKey.currentState!.closeDrawer();
              } else {
                scKey.currentState!.openDrawer();
              }
            },
            icon: Icon(Icons.menu),
          ),
        ),
        body: Scaffold(
          key: scKey,
          drawer: const DrawerWidget(),
          body: Image.asset(
            "res/HomePage.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
