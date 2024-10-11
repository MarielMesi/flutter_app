import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

class expensesQuery extends StatefulWidget {
  const expensesQuery({Key? key}) : super(key: key);

  @override
  State<expensesQuery> createState() => _expensesQueryState();
}

class _expensesQueryState extends State<expensesQuery> {
  CollectionReference expenses = FirebaseFirestore.instance.collection('otherExpenses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('All Expenses Ordered'),
        ),
        backgroundColor: Colors.green,
      ),
     body: FutureBuilder<QuerySnapshot>(
        future: expenses.orderBy('cost').where('cost', isGreaterThanOrEqualTo: 1).get(),
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
                                'Other Expenses:', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),  
                          ),
                          Center(
                            child: Text(
                              'OtherExpenses Type: ${document['otherExpenseType']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ), 
                          Center(
                            child: Text(
                              'Cost: ${document['cost'].toString()}',
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