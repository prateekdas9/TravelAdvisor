import 'package:flutter/material.dart';
import 'package:mytouringapp/ui/pages/HomePage.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus && currentFocus.focusedChild!=null){
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Awesome Touring App',
        //TODO - Move all common code to Theme class
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor:  Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        debugShowCheckedModeBanner: false,
        //theme: ThemeData.dark(),
        //themeMode: ThemeMode.system,
        home: HomePage(),
      ),
    );

  }
}




