import 'package:flutter/material.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';

class NavPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _NavPageState();
  }

  @override
  String get tag => PageTag.NavPage;
}

class _NavPageState extends BaseFlutterState<NavPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "当前选中的tab",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "$selectedIndex",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
              TextButton(
                  onPressed: () {
                    print("*********--------");
                  },
                  child: Text("showToast"))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        // color: Colors.green,
        alignment: Alignment.bottomCenter,
        child: BottomNavigationBar(
          items: createItems(),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 24,
        ),
        activeIcon: OverlayWidget(
          iconData: Icons.home,
        ),
        // activeIcon: Scale2Widget(
        //   iconData: Icons.home,
        // ),
        label: "Home"));
    items.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.send,
          size: 20,
        ),
        activeIcon: OverlayWidget(
          iconData: Icons.send,
        ),
        // activeIcon: Scale2Widget(
        //   iconData: Icons.send,
        // ),
        label: "Others"));
    return items;
  }
}



class ScaleWidget extends StatefulWidget {
  final IconData iconData;

  ScaleWidget({this.iconData});

  @override
  State<StatefulWidget> createState() {
    return _ScaleWidgetState();
  }
}

class _ScaleWidgetState extends State<ScaleWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 20.0, end: 60.0).animate(controller);
    animation.addListener(() {
      setState(() {
        print("*****update*****");
      });
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.iconData,
      color: Colors.red,
      size: animation.value,
    );
  }
}

class OverlayWidget extends StatefulWidget {
  final IconData iconData;

  OverlayWidget({this.iconData});

  @override
  State<StatefulWidget> createState() {
    return _OverlayWidgetState();
  }
}

class _OverlayWidgetState extends State<OverlayWidget> {
  OverlayEntry overlayEntry;
  GlobalKey oKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox renderBox = oKey.currentContext.findRenderObject();
      Size cSize = oKey.currentContext.size;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      Size size = MediaQuery.of(context).size;
      print(
          "****${offset.toString()}    ${size.toString()}   ${cSize.toString()}");

      overlayEntry = OverlayEntry(builder: (ctx) {
        return Positioned(
          // left: 0,
          // top: 0,
          left: offset.dx + cSize.width / 2 - 20,
          // bottom: size.height - offset.dy - cSize.height ,
          // top: offset.dy + cSize.height / 2 - 30,
          bottom: size.height - offset.dy - cSize.height,
          child: Container(
            // color: Colors.blue,
            child: Icon(
              widget.iconData,
              size: 40,
              color: Colors.brown,
            ),
          ),
        );
      });
      Overlay.of(context).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (overlayEntry != null) {
      // Overlay.of(context).re
      overlayEntry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: oKey,
      width: 20,
      height: 20,
      color: Colors.green,
      child: Stack(),
    );
  }
}

class Scale2Widget extends StatefulWidget {
  final IconData iconData;

  Scale2Widget({this.iconData});

  @override
  State<StatefulWidget> createState() {
    return _Scale2WidgetState();
  }
}

class _Scale2WidgetState extends State<Scale2Widget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    // animation = Tween(begin: 20.0, end: 60.0).animate(controller);
    // animation.addListener(() {
    //   setState(() {
    //     print("*****update*****");
    //   });
    // });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.bottomCenter,
      scale: controller,
      child: Icon(
        widget.iconData,
        color: Colors.red,
        size: 60,
      ),
    );
  }
}
