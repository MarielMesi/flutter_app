import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

class plantsQuery extends StatefulWidget {
  const plantsQuery({Key? key}) : super(key: key);

  @override
  State<plantsQuery> createState() => _plantsQueryState();
}

class _plantsQueryState extends State<plantsQuery> {
  CollectionReference plants = FirebaseFirestore.instance.collection('plants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('All Plants Ordered By Number'),
        ),
        backgroundColor: Colors.green,
      ),
     body: FutureBuilder<QuerySnapshot>(
        future: plants.orderBy('plantsNumber').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Center (
                            child: 
                              Text(
                                'Plant:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),  
                          ),  
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Plants name: ' + document['plantsName'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Plants number: ' + document['plantsNumber'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
      ),
    );
  }
}