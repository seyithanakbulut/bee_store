import 'package:bee_store/ilk_bolum.dart';
import 'package:bee_store/parcalar/anasayfa_urun_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);// hangi platform çağrılırsa ordan yap 
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
        body:IlkBolum(),


      ),
    );
  }
}

