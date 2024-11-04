import 'package:bee_store/sayfalar/giris_sayfasi.dart';
import 'package:bee_store/sayfalar/ilk_bolum.dart';
import 'package:bee_store/parcalar/anasayfa_urun_widget.dart';
import 'package:bee_store/sayfalar/yuklenme_sayfasi.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main()  async {


  final widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);




  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);// hangi platform çağrılırsa ordan yap


  //await Future.delayed(Duration(seconds: 3));

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BEE STORE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {

            }, icon: Image.asset('varliklar/notification.jpg' )),
            IconButton(onPressed: () {

            }, icon: Image.asset("varliklar/sepet.png"))
          ],
        ),
        body:YuklenmeSayfasi(),


      ),
    );
  }
}

