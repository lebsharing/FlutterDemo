import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/model/fun_item.dart';

///主页面
class HomePage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  @override
  String get tag => PageTag.HomePage;
}

class HomePageState extends BaseFlutterState<HomePage> {
  List<FunItem> funs = [];

  @override
  void initState() {
    super.initState();
    generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: funs.length,
        padding: EdgeInsets.only(left: 16,right: 16),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: (){
              FunItem fi = funs[index];
              if(fi?.pageName?.isNotEmpty ?? true) {
                Navigator.pushNamed(ctx, fi.pageName,arguments: fi.arguments);
                // if(fi.arguments != null) {
                // } else {
                //   Navigator.pushNamed(ctx, fi.pageName);
                // }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    funs[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    funs[index].desc,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void generateData() {
    funs.add(FunItem(
      name: "平台集成（Platform integration",
      desc: "MethodChannel",
      pageName: PageTag.PlatformIntegrationPage,
    ));
    setState(() {

    });
  }
}
