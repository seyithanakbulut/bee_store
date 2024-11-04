import 'dart:async';

import 'package:bee_store/parcalar/app_drawer.dart';
import 'package:bee_store/parcalar/category_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class IlkBolum extends StatefulWidget {
  const IlkBolum({super.key});

  @override
  State<IlkBolum> createState() => _IlkBolumState();
}

class _IlkBolumState extends State<IlkBolum> {

  int sayfaSayisi=0;

  final List<Widget> _sayfalar=[

    const Center(child: Text('Home' , style: TextStyle(fontSize: 24),),),
    const Center(child: Text('Categories' , style: TextStyle(fontSize: 24),),),
    const Center(child: Text('Orders' , style: TextStyle(fontSize: 24),),),
    const Center(child: Text('Profile' , style: TextStyle(fontSize: 24),),),

  ];
  final PageController _pageController = PageController();

  // Slider'da gösterilecek resim URL'leri
  List<String> imgList = [
    'https://via.placeholder.com/600x300?text=Image+1',
    'https://via.placeholder.com/600x300?text=Image+2',
    'https://via.placeholder.com/600x300?text=Image+3',
  ];


  late Timer _timer;
  int _kalanSaniye= 11 * 3600 + 15 * 60 + 50;

  @override
  void initState() {

    super.initState();
   // startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_kalanSaniye > 0) {
          _kalanSaniye--; // Geri sayım
        } else {
          _timer.cancel(); // Süre dolduğunda timer'ı durdur
        }
      });
    });
  }

  @override
  void dispose() {

   super.dispose();


  }


  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')} saat:${minutes.toString().padLeft(2, '0')} dakika:${remainingSeconds.toString().padLeft(2, '0')} saniye';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.11,
                    letterSpacing: 0.07,
                  ),
                ),
                Spacer(),
                Text(
                  'View All ->',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.12,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(future:FirebaseFirestore.instance.collection("categories").get(),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
                final categoryList=snapshot.data!.
                docs.map((e) =>e.data()).toList();
                return Row(
                    children: [
                    for(final data in categoryList)
                CategoryWidget(title:data['name'], imageUrl: data['imageUrl']),


                for (int i = 0; i < 10; i++)
                  Column(
                    children: [
                      if (i % 2 == 0)
                        Image.asset('varliklar/fashion.png')
                      else
                        Image.asset('varliklar/electronic.png'),
                      Text(i % 2 == 0 ? 'Fashion' : "Electronic")
                    ],
                  )
                ],
                );



              }else{
                return Center(child: CircularProgressIndicator(),);
              }

              },
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imgList[index],
                      fit: BoxFit.cover,
                      width: 400,
                    ),
                  ),
                );
              },
            ),
          ),

          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: imgList.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 15,
                dotWidth: 15,
                activeDotColor: Colors.blue,
                dotColor: Colors.grey,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
            ),
          ),
          const SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Deal of the day',style: TextStyle(fontSize: 20, fontFamily:'Inter', color: Colors.white),
                    ),
                  ),
                  Align(alignment: Alignment.topLeft, child: Text(formatTime(_kalanSaniye),style: TextStyle(fontSize: 18,color: Colors.red),))

                ],
              ),

              const Positioned(
                  right: 0,
                  top: 0,
                  child: Text('View All ->',   style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),))
            ],
          )


        ),

          Column(
            children: [
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 16, left: 16 ),
                   child: Column(
                     children: [
                       Container(
                         height: 100,
                         width: 150,
                         child: Center(child: Image.network('https://via.placeholder.com/600x300?text=Image+1')),
                       ),
                       const Text('Running Shoes'),
                       const Text('Upto 40% OFF',style: TextStyle(color: Colors.white, backgroundColor: Colors.red),)
                     ],
                   ),
                 ),


                 const Spacer(),
                 Padding(
                   padding: const EdgeInsets.only(right: 16, left: 16 ),
                   child: Column(
                     children: [
                       Container(
                         height: 100,
                         width: 150,
                         child: Image.network('https://via.placeholder.com/600x300?text=Image+1'),

                       ),
                       const Text('Running Shoes'),
                       const Text('Upto 40% OFF',style: TextStyle(color: Colors.white, backgroundColor: Colors.red),)
                     ],
                   ),
                 ),
               ],
             ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16 , bottom: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          child: Image.network('https://via.placeholder.com/600x300?text=Image+1'),

                        ),
                        const Text('Running Shoes'),
                        const Text('Upto 40% OFF',style: TextStyle(color: Colors.white, backgroundColor: Colors.red),)
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16 , bottom: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          child: Image.network('https://via.placeholder.com/600x300?text=Image+1'),

                        ),
                        const Text('Rconst unning Shoes'),
                  const Text('Upto 40% OFF',style: TextStyle(color: Colors.white, backgroundColor: Colors.red,))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          
         const Padding(
           padding: EdgeInsets.only(left: 16, right: 16),
           child: Row(
             children: [
               Text('Hot Selling Footwear'),
               Spacer(),

               Text('View All ->'),
             ],
           ),
         ),


        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('https://via.placeholder.com/600x300?text=Image+1',  height: 120,
                            width: 180,
                            fit: BoxFit.cover,),
                        ),
                        Positioned(top: 8,left: 8, child: Container(
                          color: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,horizontal: 6
                          ),
                          child: Text('Top Seller', style: TextStyle(color: Colors.white,fontSize: 12),),
                        ),),


                      ],
                    )
                  ],
                ),

              );
            },
          ),

        ),

        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                 boxShadow:const [ BoxShadow(
                   color: Colors.black,
                   blurRadius: 6,
                   offset: Offset(0, 2),
                 )]
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('https://via.placeholder.com/600x300?text=Image+1',  height: 120,
                            width: 180,
                            fit: BoxFit.cover,),
                        ),
                        Positioned(top: 8,left: 8, child: Container(
                          color: Colors.orange,
                          padding: EdgeInsets.symmetric(
                              vertical: 2,horizontal: 6
                          ),
                          child: Text('Top Seller', style: TextStyle(color: Colors.white,fontSize: 12),),
                        ),),
                      ],
                    )

                  ],
                ),
              );
            },
          ),
        )





        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: sayfaSayisi,
        onTap: (value) {
          setState(() {
            sayfaSayisi = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
      ),

    );
  }

}
