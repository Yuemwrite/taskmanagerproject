import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/ekranlar/anasayfa.dart';
import 'package:taskmanager/ekranlar/girisekrani.dart';



class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {

  String email,sifre;

  bool yuklenmeDurumu=false;

  var formAnahtari=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ekranı"),
      ),
      body: yuklenmeDurumu
          ? Center(child: CircularProgressIndicator()) : Container(
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Form(
          key : formAnahtari,
          child: Container(
            margin: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              children:<Widget> [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (oge){
                    return oge.contains("@") ? null : "Geçerli email adresi giriniz.";
                  },
                  decoration: InputDecoration(
                    hintText: "E-Mail adresi girin",
                    labelText: "E-Mail",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (oge){
                    setState(() {
                      email=oge;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (oge){
                    return oge.length>=6 ? null : "En az 6 karakter girmelisiniz";
                  },
                  decoration: InputDecoration(
                      hintText: "Şifre girin",
                      labelText: "Şifre",
                      border: OutlineInputBorder(),
                  ),
                  onChanged: (oge){
                    setState(() {
                      sifre=oge;
                    });
                  },

                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: (){
                      kayitEkle();
                    },
                    child: Text("Kaydol"),

                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>GirisEkrani()));
                    },
                        child: Text("Zaten hesabın var mı")
                    ),
                  alignment: Alignment.centerRight,
                    ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void kayitEkle() {
    if(formAnahtari.currentState.validate()){
      setState(() {
        yuklenmeDurumu=true;
      });

      //Firebase kayıt
      
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: sifre).then((user) {
        //kayıt yapılıyorsa
        setState(() {
          yuklenmeDurumu=false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Anasayfa()), (Route<dynamic>route) => false);
      }).catchError((onError){
        setState(() {
          yuklenmeDurumu=false;
        });
        Fluttertoast.showToast(msg: "Hata" + onError.toString());
      });
    }
  }
}
