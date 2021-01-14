import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:mytouringapp/core/AppBar.dart';
import 'package:mytouringapp/core/SizeConfig.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen(String url){
    this.url=url;
  }
  @override
  _WebViewScreenState createState() => _WebViewScreenState(this.url);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String url;
  num position=1;
  final _key=UniqueKey();
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  _WebViewScreenState(String url){
    this.url=url.replaceAll(' ', '%20').replaceAll('é', 'e');
    //this.url=url.replaceAll('é', 'e');
  }
  @override
  Widget build(BuildContext context) {
    print('int theks');
    print('$url');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(""),
            Expanded(
              child: IndexedStack(
                index: position,
                children: [
                  WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: url,
                    onPageFinished: doneLoading,
                    onPageStarted: startLoading,
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.teal,),
                  ),
                  ),
                ],
                /*child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: url,
                ),*/
              )
            )
          ],
        ),
      ),
    );
  }
}

