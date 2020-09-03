


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/ekranlar/anasayfa.dart';
import 'package:taskmanager/ekranlar/kayitekrani.dart';

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {

  String email,sifre;

  bool yuklenmeDurumu=false;

  var formAnahtari=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: yuklenmeDurumu ? Center(child: CircularProgressIndicator()) : Container(
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Form(
          key: formAnahtari,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (oge)
                    {
                      return oge.contains("@") ? null : "Geçersiz e-mail adresi";
                    },
                    onChanged: (oge){
                            email=oge;
                    },
                    decoration: InputDecoration(

                      hintText: "E-Mail Girin",
                      labelText: "E-Mail",
                      border: OutlineInputBorder(),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (oge)
                    {
                      return oge.length>=6 ? null : "Şifre en az 6 karakter olmalı";
                    },
                    onChanged: (oge){
                        sifre=oge;
                    },
                    decoration: InputDecoration(
                        hintText: "Şifre Girin",
                        labelText: "Şifre",
                      border: OutlineInputBorder(),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: (){
                          girisYap();
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text("Giriş Yap"),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>KayitEkrani()));
                        },
                          child: Text("Henüz hesabınız yok mu")),
                      )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void girisYap() {
        if(formAnahtari.currentState.validate())
        {
          setState(() {
            yuklenmeDurumu=true;
          });

          //Firebaseden giriş yapılıyor.

          FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: sifre).then((user){
            setState(() {
              yuklenmeDurumu=false;
            });
            
            Fluttertoast.showToast(msg: "Giriş Başarılı");
            
            //Anasayfaya atsın
            
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Anasayfa()), (Route<dynamic>route) => false);
            
          }).catchError((onError)
          {
            setState(() {
              yuklenmeDurumu=false;
            });

            Fluttertoast.showToast(msg: "Hata" + onError.toString());
          });


        }
  }
}
