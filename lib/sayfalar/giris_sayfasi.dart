import 'package:bee_store/sayfalar/kayit_sayfasi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {

  var _yukleniyor=false;
  var _hataMesaji="";

  var _email="";
  var _sifre="";


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("Giriş Sayfası") ,),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_hataMesaji.isNotEmpty) Text("Bir hata oluştu : $_hataMesaji" , style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),),
            TextField(
              decoration: InputDecoration(hintText: "Email adresini giriniz."),
              keyboardType: TextInputType.emailAddress,
              onChanged: (deger){
                _email=deger;
                if(_hataMesaji.isNotEmpty){
                  _hataMesaji="";
                  setState(() {

                  });
                }
              },

            ),
            const SizedBox(height: 24,),
            TextField(
              decoration: InputDecoration(hintText: "Şifrenizi giriniz."),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true, // şifreyi gizle
              onChanged: (deger){
                _sifre=deger;
                if(_hataMesaji.isNotEmpty){
                  _hataMesaji="";
                  setState(() {

                  });
                }
              },

            ),
            if (_yukleniyor) const CircularProgressIndicator()
            else
              TextButton(onPressed: () {

                if(_email.isNotEmpty && _sifre.isNotEmpty){
                  _yukleniyor= true;
                  setState(() {
                  });
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _sifre).catchError((hataMesaji){
                    _hataMesaji=hataMesaji.toString();
                    _yukleniyor=false;
                    setState(() {

                    });

                  });
                }
                else{
                  _hataMesaji="Email adresi ve şifre boş geçilemez";
                  setState(() {

                  });
                }



            }, child: Text("Giriş Yap")),
            const Divider(),
            TextButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return KayitSayfasi();
              }));
            }, child: Text("Kayıt Ol "))
          ],
        ),
      ),
    );
  }
}
