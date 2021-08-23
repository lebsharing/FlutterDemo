import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/ui/route_error.dart';
import 'package:flutter_demo/ui/view_widget/animation_page.dart';
import 'package:flutter_demo/ui/view_widget/visibility_ex.dart';

class ViewWidgetExGirdPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _ViewWidgetExGridPageState();
  }

  @override
  String get tag => PageTag.ViewWidgetExPage;
}

class _ViewWidgetExGridPageState extends BaseFlutterState {
  List<ViewExItem> data = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      generateData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Common Widget"
        ),
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,),
          controller: _scrollController,
          itemCount: data.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                jumpPage(context,data[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Text(
                      data[index].name ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      data[index].desc ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///处理页面跳转
  void jumpPage(BuildContext ctx,ViewExItem item) {
    if(item.pageTag?.isEmpty ?? true) {
      return;
    }
    Widget widget;
    switch(item.pageTag) {
      case PageTag.VisibilityPage:
        widget = VisibilityPage();
        break;
      case PageTag.AnimPage:
        widget = AnimationPage();
        break;
      default:
        widget = RouteErrorPage();
        break;
    }
    print("${item.pageTag}");
    if(widget != null) {
      Navigator.push(ctx, MaterialPageRoute(builder: (bctx){
        // print("${widget == null}");
        return widget;
      }));
    }
  }

  ///生成数据源
  Future<void> generateData() async {
    data.add(ViewExItem(name: "Offstage",desc: ""));
    data.add(ViewExItem(name: "Visibility", desc: "",pageTag: PageTag.VisibilityPage));
    data.add(ViewExItem(name: "Animation",desc: "",pageTag: PageTag.AnimPage));
    setState(() {});
  }
}

class ViewExItem {
  String name; //widget name
  String desc;

  String pageTag;
  Object arguments; //参数

  ViewExItem({this.name, this.desc,this.pageTag, this.arguments});
}
