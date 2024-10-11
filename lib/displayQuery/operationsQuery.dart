import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

class operationsQuery extends StatefulWidget {
  const operationsQuery({Key? key}) : super(key: key);

  @override
  State<operationsQuery> createState() => _operationsQueryState();
}

class _operationsQueryState extends State<operationsQuery> {
  CollectionReference operations = FirebaseFirestore.instance.collection('operations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('All Annual Operations'),
        ),
        backgroundColor: Colors.green,
      ),
     body: FutureBuilder<QuerySnapshot>(
        future: operations.where('agriculturalTask.dateStarted', isGreaterThanOrEqualTo: DateTime(2021)).get(),
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
                                'Plant:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Plants name: ${document['plantsName']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Plants name: ${document['plantsNumber']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Operations:', 
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center (
                            child: 
                              Text(
                                'Agricultural Task:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Task Name: ${document['agriculturalTask']['taskName']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Date Started: ${document['agriculturalTask']['dateStarted'].toDate().toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Workers Number: ${document['agriculturalTask']['workersNumber'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Cost: ${document['agriculturalTask']['cost'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center (
                            child: 
                              Text(
                                'Fertilizer:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Type: ${document['fertilizer']['type']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Product name: ${document['fertilizer']['productName']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Date: ${document['fertilizer']['date'].toDate().toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Items: ${document['fertilizer']['items'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Cost Per Item: ${document['fertilizer']['costPerItem'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total Cost: ${document['fertilizer']['totalCost'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center (
                            child: 
                              Text(
                                'Irrigation:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Date: ${document['irrigation']['date'].toDate().toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Hours: ${document['irrigation']['hours'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Cost: ${document['irrigation']['cost'].toString()}',
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