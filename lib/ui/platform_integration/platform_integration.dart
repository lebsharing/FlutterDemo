import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/base_flutter.dart';
import 'package:flutter_demo/common/page_tag.dart';
import 'package:flutter_demo/ui/platform_integration/method_channel.dart';

class PlatformIntegrationPage extends BaseFlutterPage {
  @override
  State<StatefulWidget> createState() {
    return _PlatformIntegrationPageState();
  }

  @override
  String get tag => PageTag.PlatformIntegrationPage;
}

class _PlatformIntegrationPageState
    extends BaseFlutterState<PlatformIntegrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platform Integration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return MethodChannelPage();
                      },
                    ),
                  );
                },
                child: Text("MethodChannel")),
          ],
        ),
      ),
    );
  }
}
