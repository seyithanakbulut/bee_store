import 'package:flutter/material.dart';


class AnasayfaUrunWidget extends StatefulWidget{
  const AnasayfaUrunWidget({super.key, required this.baslik, required this.resimAdresi, required this.usdFiyat, required this.indirimOrani});


  final String baslik;
  final String resimAdresi;
  final double usdFiyat;
  final double indirimOrani;

  @override
  State createState() => _AnasayfaUrunWidgetState();
/* State createState(){
    return _AnasayfaUrunWidgetState();
  }*/

}

//String baslik="Adidas wihite sneakers for men";
//String resimAdresi="varliklar/sepet.png";
//double usdFiyat=68.5;
//double indirimOrani=50;
bool favorideMi=false;


class _AnasayfaUrunWidgetState extends State<AnasayfaUrunWidget>{
  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        children: [
          Image.asset(widget.resimAdresi),
          Text(widget.baslik),
          Row(
            children: [
              Text("\$${widget.usdFiyat}",style:const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$136", style: TextStyle(decoration: TextDecoration.lineThrough),),
               Text("${widget.indirimOrani} OFF"),
            ],
          )
        ]

      ),

    );
  }

}