import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

class incomeQuery extends StatefulWidget {
  const incomeQuery({Key? key}) : super(key: key);

  @override
  State<incomeQuery> createState() => _incomeQueryState();
}

class _incomeQueryState extends State<incomeQuery> {
  CollectionReference income = FirebaseFirestore.instance.collection('income');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('All Income Ordered'),
        ),
        backgroundColor: Colors.green,
      ),
     body: FutureBuilder<QuerySnapshot>(
        future: income.orderBy('ammount').where('ammount', isGreaterThanOrEqualTo: 1).get(),
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
                          const Center (
                            child: 
                              Text(
                                'Income:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Income Type: ${document['incomeType']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ), 
                          Center(
                            child: Text(
                              'Ammount: ${document['ammount'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
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