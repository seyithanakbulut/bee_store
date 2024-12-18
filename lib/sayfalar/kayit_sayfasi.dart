import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class KayitSayfasi extends StatefulWidget {
  const KayitSayfasi({super.key});

  @override
  State<KayitSayfasi> createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {

  var _yukleniyor=false;
  var _hataMesaji="";
  var _isimSoyisim="";
  var _email="";
  var _sifre="";


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("Kayıt Sayfası") ,),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_hataMesaji.isNotEmpty) Text("Bir hata oluştu : $_hataMesaji" , style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),),
            TextField(
              decoration: InputDecoration(hintText: "İsmini ve soyismini  giriniz."),
              keyboardType: TextInputType.name,
              onChanged: (deger){
                _isimSoyisim=deger;
                if(_hataMesaji.isNotEmpty){
                  _hataMesaji="";
                  setState(() {

                  });
                }
              },

            ),
            const SizedBox(height: 24,),
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

                if(_email.isNotEmpty && _sifre.isNotEmpty && _isimSoyisim.isNotEmpty){
                  _yukleniyor= true;
                  setState(() {
                  });
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _sifre).catchError((hataMesaji){
                    _hataMesaji=hataMesaji.toString();
                    _yukleniyor=false;
                    setState(() {

                    });

                  }).then((value) async{
                    final uid=value.user?.uid;
                    final kullanici ={
                      'name':_isimSoyisim,
                      'email': _email,
                      'kayitTarihi':FieldValue.serverTimestamp(),
                    };
                    if(uid==null){
                    await  FirebaseFirestore.instance.collection("users").add(kullanici);
                    }else{
                    await  FirebaseFirestore.instance.collection("users").doc(uid).set(kullanici);
                    }

                    if(mounted)  Navigator.of(context).pop();


                  });
                }
                else{
                  _hataMesaji="Tüm Alanları doldurunuz.";
                  setState(() {

                  });
                }



            }, child: Text("Kayıt Ol")),

          ],
        ),
      ),
    );
  }
}
