import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//the plants page
class IncomePage extends StatefulWidget {
  IncomePage({Key? key}) : super(key: key);

  

  @override
  IncomePageState createState() => IncomePageState();
}


class IncomePageState extends State<IncomePage> {
 
  @override
  Widget build(BuildContext context) {
    var plantNameController = TextEditingController();
    var plantNumberController = TextEditingController();
    var incomeAmmountController = TextEditingController();
    var incomeTypeController = TextEditingController();

    CollectionReference otherExpenses = FirebaseFirestore.instance.collection('otherExpenses');
    CollectionReference plants = FirebaseFirestore.instance.collection('plants');
    CollectionReference events = FirebaseFirestore.instance.collection('events');
    CollectionReference operations = FirebaseFirestore.instance.collection('operations');
    CollectionReference income = FirebaseFirestore.instance.collection('income');

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Plant\'s Income'),
        ),
        backgroundColor: Colors.green,
      ),
     body: StreamBuilder(
        stream: income.snapshots(),
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
                  child: Text('Income\'s form'),
                ),  
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: plantNameController,
                          decoration: const InputDecoration(
                            labelText: 'Plants name',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        TextFormField(
                          controller: plantNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Number of plants',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        const SizedBox(
                            height: 20,
                        ),
                        const Text(
                          'Income:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextFormField(
                          controller: incomeTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Income Type',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: incomeAmmountController,
                          decoration: const InputDecoration(
                            labelText: 'Income Ammount',
                            icon: Icon(Icons.numbers),
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

                      await income
                      .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text,
                          'incomeType' : incomeTypeController.text,
                          'ammount' : int.parse(incomeAmmountController.text),
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
                    
                      plants
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
    var incomeTypeController = TextEditingController(text: doc['incomeType']);
    var incomeAmmountController = TextEditingController(text: doc['ammount'].toString());


    return showDialog<void> (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text('Update Income'),
          ),  
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: plantNameController,
                    decoration: const InputDecoration(
                      labelText: 'Plants name',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  TextFormField(
                    controller: plantNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Number of plants',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(
                      height: 20,
                  ),
                  const Text(
                    'Income:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextFormField(
                    controller: incomeTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Expense Type',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: incomeAmmountController,
                    decoration: const InputDecoration(
                      labelText: 'Expense Cost',
                      icon: Icon(Icons.numbers),
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
              child: Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                  updateData(
                    doc.id,
                    plantNameController.text,
                    plantNumberController.text,
                    incomeTypeController .text,
                    incomeAmmountController.text,
                  );
                  Navigator.pop(context);
              },
              child:  Text('Update'),//this shit
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

  void updateData (String id, String plantNameController, String plantNumberController, String incomeTypeController, String incomeAmmountController) {
    Map<String , dynamic> data = {
      'plantsName' : plantNameController,
      'plantsNumber' : int.parse(plantNumberController),
      'incomeType' : incomeTypeController,
      'ammount' : int.parse(incomeAmmountController),
    };
    FirebaseFirestore.instance.collection('income').doc(id).update(data);
  }

  Future<void> deleteRecord(String id) async {
    FirebaseFirestore.instance.collection('income').doc(id).delete();
  }
}