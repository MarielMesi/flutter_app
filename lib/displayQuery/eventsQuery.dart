import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

class eventsQuery extends StatefulWidget {
  const eventsQuery({Key? key}) : super(key: key);

  @override
  State<eventsQuery> createState() => _eventsQueryState();
}

class _eventsQueryState extends State<eventsQuery> {
  CollectionReference events = FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('All Annual Events'),
        ),
        backgroundColor: Colors.green,
      ),
     body: FutureBuilder<QuerySnapshot>(
        future: events.where('date', isGreaterThanOrEqualTo: DateTime(2021)).get(),
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
                          const Center (
                            child: 
                              Text(
                                'Event:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'Event Name: ${document['eventName']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Date: ${document['date'].toDate().toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Damage: ${document['damage']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),  
                          Center(
                            child: Text(
                              'Damage Percent: ${document['damagePercent'].toString()}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Comment: ${document['comments']}',
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