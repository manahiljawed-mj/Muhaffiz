import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muhaffiz_user/selection_screen_main/option_selection.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'infoHandler/app_info.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfo(),
        child: MaterialApp(
          //title: 'Drivers App',
          title: 'Users App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: const MySplashScreen(),
          home:const OptionSelectionScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
   final Widget? child;
   MyApp({this.child});
   static void restartApp(BuildContext context){
     context.findAncestorStateOfType<_MyAppState>()!.restartApp();
   }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key=UniqueKey();
  void restartApp(){
    setState(() {
      key = UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}





