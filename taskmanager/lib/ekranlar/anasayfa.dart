import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/ekranlar/kayitekrani.dart';
import 'package:taskmanager/ekranlar/listeekrani.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  String gorevNumarasi,gorevAdi,gorevDurumu,gorevTarihi;

  gorevNumarasiAl(gorevNumarasi)
  {
    this.gorevNumarasi=gorevNumarasi;
  }
  gorevAdiAl(gorevAdi)
  {
    this.gorevAdi=gorevAdi;
  }
  gorevDurumuAl(gorevDurum)
  {
    this.gorevDurumu=gorevDurum;
  }
  gorevTarihiAl(gorevTarih)
  {
    this.gorevTarihi=gorevTarih;
  }

  void gorevEkle()
  {
    print("eklendi");
    //Veritabanı Yolu..
    DocumentReference veriyolu = Firestore.instance.collection("gorevler")
        .document(gorevAdi);

    Fluttertoast.showToast(msg: gorevAdi + " görevi başarıyla eklendi");

    //çoklu veri gönderme MAP oluştur

    Map<String, dynamic> gorev =
    {
      "gorevNumarasi": gorevNumarasi,
      "GorevAdi": gorevAdi,
      "gorevTarih": gorevTarihi,
      "gorevDurumu" : gorevDurumu
    };

    veriyolu.setData(gorev).whenComplete(() {
      print(gorevAdi + " eklendi");
    });

  }
  void gorevSil()
  {
    DocumentReference veriyolu = Firestore.instance.collection("gorevler")
        .document(gorevAdi);
    veriyolu.delete().whenComplete(() {
      print(gorevAdi + " adlı görev silindi");
    });

    Fluttertoast.showToast(msg: gorevAdi + " görevi silindi");

  }
  void gorevGuncelle()
  {

    //Veritabanı Yolu..
    DocumentReference veriyolu = Firestore.instance.collection("gorevler")
        .document(gorevAdi);

    Fluttertoast.showToast(msg: gorevAdi + "görevine ait bilgi güncellendi.");



    //çoklu veri gönderme MAP oluştur

    Map<String, dynamic> gorev =
    {
      "gorevNumarasi": gorevNumarasi,
      "GorevAdi": gorevAdi,
      "gorevTarih": gorevTarihi,
      "gorevDurumu" : gorevDurumu
    };

    veriyolu.updateData(gorev).whenComplete(() {
      print(gorevAdi + " güncellendi");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Yöneticisi"),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
           //Firebase çıkış yap
           FirebaseAuth.instance.signOut().then((onvalue){
             Navigator.push(context, MaterialPageRoute(builder: (_)=>KayitEkrani()));
           });
          })
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Görev Numarası",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                      ),
                    ),

                  ),
                  onChanged: (String gorevNumarasi)
                  {
                      gorevNumarasiAl(gorevNumarasi);
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Görev Adı",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0
                      ),
                    ),

                  ),
                  onChanged: (String gorevAdi)
                  {
                      gorevAdiAl(gorevAdi);
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Görev Tarihi",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0
                      ),
                    ),

                  ),
                  onChanged: (String gorevTarihi)
                  {
                      gorevTarihiAl(gorevTarihi);
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Görev Durumu",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0
                      ),
                    ),

                  ),
                  onChanged: (String gorevDurumu)
                  {
                      gorevDurumuAl(gorevDurumu);
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top:16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("Ekle"),
                      textColor: Colors.white,
                      onPressed: (){
                                gorevEkle();
                      },
                    ),

                    RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("Güncelle"),
                      textColor: Colors.white,
                      onPressed: (){
                          gorevGuncelle();

                      },
                    ),
                    RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Sil"),
                    textColor: Colors.white,
                    onPressed: (){
                        gorevSil();
                    },
                  ),
                    RaisedButton(
                      color: Colors.brown,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("Görevler"),
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>GorevListesi()));
                      },
                    )
                  ],
                ),
              ),
              /*Padding(
                padding:  EdgeInsets.only(left: 15.00, right: 15.00, top: 5.00),
                child: Row(children: <Widget>[
                  Expanded(child: Text("Görev Numarası"),
                  ),
                  Expanded(child: Text("Görev Adı"),
                  ),
                  Expanded(child: Text("Görev Tarih"),
                  ),
                  Expanded(child: Text("Görev Durumu"),
                  ),


                ],
                ),
              ),*/
            /*  StreamBuilder(stream: Firestore.instance.collection("gorevler").snapshots(),
                // ignore: missing_return
                builder: ( context , snapshot){
                  if(snapshot.hasData)
                  {
                    // ignore: missing_return
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        // ignore: missing_return
                        itemBuilder:(context, index) {

                          DocumentSnapshot documentsSnapshot = snapshot.data.documents[index];
                          return Padding(
                            padding:  EdgeInsets.only(left: 25.00, right: 15.00, top: 15.00),
                            child: Row(
                              children: [
                                Expanded(child: Text(documentsSnapshot["gorevNumarasi"]),
                                ),
                                Expanded(child: Text(documentsSnapshot["gorevAdi"]),
                                ),

                                Expanded(child: Text(documentsSnapshot["gorevTarih"]),
                                ),
                                Expanded(child: Text(documentsSnapshot["gorevDurumu"]),
                                ),

                              ],
                            ),
                          );
                        });
                  }
                },
              )*/
            ],
        ),
      ),

    );
  }
}
