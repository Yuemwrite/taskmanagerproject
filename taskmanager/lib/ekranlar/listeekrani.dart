import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GorevListesi extends StatefulWidget {
  @override
  _GorevListesiState createState() => _GorevListesiState();
}

class _GorevListesiState extends State<GorevListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Listesi"),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 15.00, right: 15.00, top: 5.00),
            child: Row(children: <Widget>[
              Expanded(child: Text("Görev Numarası"),
              ),
              Expanded(child: Text("Görev Adı"),
              ),
              Expanded(child: Text("Görev Tarih"),
              ),
              Expanded(child: Text("Görev Durumu"),
              )
            ],
            ),
          ),
          StreamBuilder(stream: Firestore.instance.collection("gorevler").snapshots(),
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
                            )
                          ],
                        ),
                      );
                    });
              }
            },
          )
        ],
      ),



    );
  }
}
