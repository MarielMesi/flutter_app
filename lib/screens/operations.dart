import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//the operations page
// ignore: must_be_immutable
class OperationsPage extends StatefulWidget {
  OperationsPage({Key? key}) : super(key: key);

  @override
  State<OperationsPage> createState() => OperationsPageState();
}

class OperationsPageState extends State<OperationsPage> {

  var plantNameController = TextEditingController();
  var plantNumberController = TextEditingController(); 

  var agriTaskNameController = TextEditingController();
  var agriWorkersNumberController = TextEditingController();
  var agriDateStartedController = TextEditingController();
  var agriCostController = TextEditingController();

  var fertiTypeController = TextEditingController();
  var fertiTotalCostController = TextEditingController();
  var fertiProductNameController = TextEditingController();
  var fertiItemsController = TextEditingController();
  var fertiDateController = TextEditingController();
  var fertiCostPerItemController = TextEditingController();

  var irriHoursController = TextEditingController();
  var irriDateController = TextEditingController();
  var irriCostController = TextEditingController();

  CollectionReference operations = FirebaseFirestore.instance.collection('operations');
  CollectionReference plants = FirebaseFirestore.instance.collection('plants');
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  CollectionReference otherExpenses = FirebaseFirestore.instance.collection('otherExpenses');
  CollectionReference income = FirebaseFirestore.instance.collection('income');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Plant\'s Operations'),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
        stream: operations.snapshots(),
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
                  child: Text('Plant\'s Operation form'),
                ),  
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Plant Form:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
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
                        const SizedBox(
                            height: 20,
                        ),
                        const Text(
                          'Agricultural Task:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextFormField(
                          controller: agriTaskNameController,
                          decoration: const InputDecoration(
                            labelText: 'Task Name',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: agriDateStartedController,
                          decoration: const InputDecoration(
                            labelText: 'Date started',
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          onTap: () async {
                            DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if(pickDate != null) {
                              setState(() {
                                agriDateStartedController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                              });
                            }
                          },
                        ),
                        TextFormField(
                          controller: agriWorkersNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Workers Number',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: agriCostController,
                          decoration: const InputDecoration(
                            labelText: 'Cost',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        const SizedBox(
                            height: 20,
                        ),
                        const Text(
                          'Fertilizer:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextFormField(
                          controller: fertiTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Type(FERT/PEST)',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: fertiProductNameController,
                          decoration: const InputDecoration(
                            labelText: 'Product Name',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        TextFormField(
                          controller: fertiDateController,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          onTap: () async {
                            DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if(pickDate != null) {
                              setState(() {
                                fertiDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                              });
                            }
                          },
                        ),
                        TextFormField(
                          controller: fertiItemsController,
                          decoration: const InputDecoration(
                            labelText: 'Items',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        TextFormField(
                          controller: fertiCostPerItemController,
                          decoration: const InputDecoration(
                            labelText: 'Cost Per Item',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: fertiTotalCostController,
                          decoration: const InputDecoration(
                            labelText: 'Total Cost',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        const SizedBox(
                            height: 20,
                        ),
                        const Text(
                          'Irrigation:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextFormField(
                          controller: irriDateController,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          onTap: () async {
                            DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            if(pickDate != null) {
                              setState(() {
                                irriDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                              });
                            }
                          },
                        ),
                        TextFormField(
                          controller: irriHoursController,
                          decoration: const InputDecoration(
                            labelText: 'Hours',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        TextFormField(
                          controller: irriCostController,
                          decoration: const InputDecoration(
                            labelText: 'Cost',
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
                    child:  const Icon(Icons.save),
                    onPressed: () async {
                        await operations
                          .add({
                            'plantsNumber': int.parse(plantNumberController.text),
                            'plantsName': plantNameController.text,
                            'agriculturalTask' : {
                              'taskName' : agriTaskNameController,
                              'cost' : int.parse(agriCostController.text),
                              'workersNumber' : int.parse(agriWorkersNumberController.text),
                              'dateStarted' : DateTime.parse(agriDateStartedController.text),
                            },
                            'fertilizer' : {
                              'type' : fertiTypeController,
                              'totalCost' : int.parse(fertiTotalCostController.text),
                              'productName' : fertiProductNameController,
                              'date' : DateTime.parse(fertiDateController.text),
                              'items' : int.parse(fertiItemsController.text),
                              'costPerItem' : int.parse(fertiCostPerItemController.text),
                            },
                            'irrigation' :{
                              'cost' : int.parse(irriCostController.text),
                              'date' : DateTime.parse(irriDateController.text),
                              'hours' : int.parse(irriHoursController.text),
                            }
                          })
                          .catchError((error) => print('Failed to add user: $error'));

                        plants
                        .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text})
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

    var agriTaskNameController = TextEditingController(text: doc['agriculturalTask']['taskName']);
    var agriWorkersNumberController = TextEditingController(text: doc['agriculturalTask']['workersNumber'].toString());
    var agriDateStartedController = TextEditingController(text: doc['agriculturalTask']['dateStarted'].toDate().toString().split(' ')[0]);
    var agriCostController = TextEditingController(text: doc['agriculturalTask']['cost'].toString());

    var fertiTypeController = TextEditingController(text: doc['fertilizer']['type']);
    var fertiTotalCostController = TextEditingController(text: doc['fertilizer']['totalCost'].toString());
    var fertiProductNameController = TextEditingController(text: doc['fertilizer']['productName']);
    var fertiItemsController = TextEditingController(text: doc['fertilizer']['items'].toString());
    var fertiDateController = TextEditingController(text: doc['fertilizer']['date'].toDate().toString().split(' ')[0]);
    var fertiCostPerItemController = TextEditingController(text: doc['fertilizer']['costPerItem'].toString());

    var irriHoursController = TextEditingController(text: doc['irrigation']['hours'].toString());
    var irriDateController = TextEditingController(text: doc['irrigation']['date'].toDate().toString().split(' ')[0]);
    var irriCostController = TextEditingController(text: doc['irrigation']['cost'].toString());

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
                  const Text(
                    'Plant Form:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
                  const SizedBox(
                      height: 20,
                  ),
                  const Text(
                    'Agricultural Task:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextFormField(
                    controller: agriTaskNameController,
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: agriDateStartedController,
                    decoration: const InputDecoration(
                      labelText: 'Date started',
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050)
                      );
                      if(pickDate != null) {
                        setState(() {
                          agriDateStartedController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: agriWorkersNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Workers Number',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: agriCostController,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  const SizedBox(
                      height: 20,
                  ),
                  const Text(
                    'Fertilizer:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextFormField(
                    controller: fertiTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Type(FERT/PEST)',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: fertiProductNameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  TextFormField(
                    controller: fertiDateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      if(pickDate != null) {
                        setState(() {
                          fertiDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: fertiItemsController,
                    decoration: const InputDecoration(
                      labelText: 'Items',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  TextFormField(
                    controller: fertiCostPerItemController,
                    decoration: const InputDecoration(
                      labelText: 'Cost Per Item',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: fertiTotalCostController,
                    decoration: const InputDecoration(
                      labelText: 'Total Cost',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  const SizedBox(
                      height: 20,
                  ),
                  const Text(
                    'Irrigation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextFormField(
                    controller: irriDateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                    onTap: () async {
                      DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      if(pickDate != null) {
                        setState(() {
                          irriDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: irriHoursController,
                    decoration: const InputDecoration(
                      labelText: 'Hours',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  TextFormField(
                    controller: irriCostController,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
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
              child: const Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                  updateData(
                    doc.id,
                    plantNameController.text,
                    plantNumberController.text,
                    agriTaskNameController.text,
                    agriDateStartedController.text,
                    agriCostController.text,
                    agriWorkersNumberController.text,
                    fertiCostPerItemController.text,
                    fertiDateController.text,
                    fertiItemsController.text,
                    fertiProductNameController.text,
                    fertiTotalCostController.text,
                    fertiTypeController.text,
                    irriCostController.text,
                    irriDateController.text,
                    irriHoursController.text,
                  );
                  Navigator.pop(context);
              },
              child: const Text('Update'),//this shit
            ),
            OutlinedButton(
              onPressed: () {
                  deleteRecord(doc.id);
                  Navigator.pop(context);
              },
              child: const Text('Delete'),//this shit
            ),
          ],//action
        );
      }
    );
  }

  void updateData (String id, String plantNameController, String plantNumberController, String agriTaskNameController, String agriDateStartedController, String agriCostController, String agriWorkersNumberController, String fertiCostPerItemController, String fertiDateController, String fertiItemsController, String fertiProductNameController, String fertiTotalCostController, String fertiTypeController, String irriCostController, String irriDateController, String irriHoursController) {
    Map<String , dynamic> data = {
      'plantsName' : plantNameController,
      'plantsNumber' : int.parse(plantNumberController),
      'agriculturalTask' : {
        'taskName' : agriTaskNameController,
        'cost' : int.parse(agriCostController),
        'workersNumber' : int.parse(agriWorkersNumberController),
        'dateStarted' : DateTime.parse(agriDateStartedController),
      },
      'fertilizer' : {
        'type' : fertiTypeController,
        'totalCost' : int.parse(fertiTotalCostController),
        'productName' : fertiProductNameController,
        'date' : DateTime.parse(fertiDateController),
        'items' : int.parse(fertiItemsController),
        'costPerItem' : int.parse(fertiCostPerItemController),
      },
      'irrigation' :{
        'cost' : int.parse(irriCostController),
        'date' : DateTime.parse(irriDateController),
        'hours' : int.parse(irriHoursController),
      }
    };
    FirebaseFirestore.instance.collection('operations').doc(id).update(data);
  }

  Future<void> deleteRecord(String id) async {
    FirebaseFirestore.instance.collection('operations').doc(id).delete();
  }
}