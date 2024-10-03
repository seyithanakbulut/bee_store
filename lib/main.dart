import 'package:flutter/material.dart';

void main() {
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
        body:const Center(
          child: Text('Bu örnek bir proje'),
        ),
        drawer:const Drawer(

        ),
      ),
    );
  }
}

