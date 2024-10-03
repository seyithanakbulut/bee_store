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
        body:
          Column(
            children: [
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    //labelText: "Search Anything...",
                    hintText: "Search Anything...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                  ),

                ),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text("Categories" , style: TextStyle(color:Color(0xFF1F2937)
                      ,fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.w600,height: 0.11,letterSpacing: 0.07,
                    ),),
                    Spacer(),
                    Text(
                      'View All ->',
                      textAlign: TextAlign.right,
                      style: TextStyle(color:Color(0xFF6B7280),fontSize: 12,
                        fontFamily: 'Inter',fontWeight: FontWeight.w600,height: 0.12
                      ),
                    )

                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(int i=0; i<10 ; i++)
                    Column(
                      children: [
                        if(i%2 ==0)
                        Image.asset('varliklar/fashion.png')
                        else
                        Image.asset('varliklar/electronic.png'),
                        Text(i%2 == 0 ?'Fashion' : "Electronic")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),

        drawer:const Drawer(

        ),
      ),
    );
  }
}

