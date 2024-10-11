import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//the plants page
class PlantsScreen extends StatefulWidget {
  PlantsScreen({Key? key}) : super(key: key);

  

  @override
  PlantsScreenState createState() => PlantsScreenState();
}


class PlantsScreenState extends State<PlantsScreen> {
 
  @override
  Widget build(BuildContext context) {
    var plantNameController = TextEditingController();
    var plantNumberController = TextEditingController(); 
    CollectionReference plants = FirebaseFirestore.instance.collection('plants');
    CollectionReference operations = FirebaseFirestore.instance.collection('operations');
    CollectionReference events = FirebaseFirestore.instance.collection('events');
    CollectionReference otherExpenses = FirebaseFirestore.instance.collection('otherExpenses');
    CollectionReference income = FirebaseFirestore.instance.collection('income');


    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Plants'),
        ),
        backgroundColor: Colors.green,
      ),
     body: StreamBuilder(
        stream: plants.snapshots(),
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
                  onTap: () {
                    _showUpdateDialog(document, context);
                  },
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add your onPressed code here!
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Center(
                  child: Text('Plants form'),
                ),  
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: plantNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Number of plants',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: plantNameController,
                          decoration: const InputDecoration(
                            labelText: 'Plants name',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child:  Icon(Icons.save),
                    onPressed: () async {
                      await plants
                        .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text})
                        .catchError((error) => print('Failed to add user: $error'));


                        operations
                        .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text,
                          'agriculturalTask' : {
                            'taskName' : 'Task',
                            'cost' : int.parse('0'), 
                            'workersNumber' : int.parse('0'),
                            'dateStarted' : DateTime.now()
                          },
                          'fertilizer' : {
                            'type' : 'fert/pest', 
                            'totalCost' : int.parse('0'), 
                            'productName' : 'name', 
                            'date' : DateTime.now(), 
                            'items' : int.parse('0'), 
                            'costPerItem' : int.parse('0')
                          },
                          'irrigation' :{
                            'cost' : int.parse('0'), 
                            'date' : DateTime.now(), 
                            'hours' : int.parse('0')
                          }
                        })
                        .catchError((error) => print('Failed to add user: $error'));

                        events
                        .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text,
                          'comments' : 'Comment',
                          'damage' : 'kati',
                          'damagePercent' : int.parse('0'),
                          'date' : DateTime.now(),
                          'eventName' : 'kati'
                        })
                        .catchError((error) => print('Failed to add user: $error'));

                        otherExpenses
                        .add({
                            'plantsNumber': int.parse(plantNumberController.text),
                            'plantsName': plantNameController.text,
                            'otherExpenseType' : 'trakter',
                            'cost' : int.parse('0'),
                        })
                        .catchError((error) => print('Failed to add user: $error'));


                        income
                        .add({
                            'plantsNumber': int.parse(plantNumberController.text),
                            'plantsName': plantNameController.text,
                            'incomeType' : 'kati',
                            'ammount' : int.parse('0'),
                        })
                        .catchError((error) => print('Failed to add user: $error'));

                        Navigator.pop(context);
                    },//this shit
                  ),
                ],//action
              );
            }//builder content
          );//show dialog 
        },//on pressed
      ),
    );
  }

  Future <void> _showUpdateDialog (var doc, BuildContext context) {

    var plantNameController = TextEditingController(text: doc['plantsName']);
    var plantNumberController = TextEditingController(text: doc['plantsNumber'].toString()); 
    return showDialog<void> (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text('Update Plant'),
          ),  
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: plantNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Number of plants',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: plantNameController,
                    decoration: const InputDecoration(
                      labelText: 'Plants name',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                  updateData(
                    doc.id,
                    plantNameController.text,
                    plantNumberController.text,
                  );
                  Navigator.pop(context);
              },
              child:  const Text('Update'),//this shit
            ),
            OutlinedButton(
              onPressed: () {
                  deleteRecord(doc.id);
                  Navigator.pop(context);
              },
              child:  Text('Delete'),//this shit
            ),
          ],//action
        );
      }
    );
  }

  void updateData (String id, String plantsName, String plantsNumber) {
    Map<String , dynamic> data = {
      'plantsName' : plantsName,
      'plantsNumber' : int.parse(plantsNumber),
    };
    FirebaseFirestore.instance.collection('plants').doc(id).update(data);
  }

  Future<void> deleteRecord(String id) async {
    FirebaseFirestore.instance.collection('plants').doc(id).delete();
  }
}