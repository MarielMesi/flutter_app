import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//the plants page
class EventsScreen extends StatefulWidget {
  EventsScreen({Key? key}) : super(key: key);

  

  @override
  EventsScreenState createState() => EventsScreenState();
}


class EventsScreenState extends State<EventsScreen> {
 
  @override
  Widget build(BuildContext context) {
    var plantNameController = TextEditingController();
    var plantNumberController = TextEditingController();
    var eventCommentController = TextEditingController();
    var eventDamageController = TextEditingController();
    var eventDamagePercentController = TextEditingController();
    var eventDateController = TextEditingController();
    var eventNameController = TextEditingController();

    CollectionReference plants = FirebaseFirestore.instance.collection('plants');
    CollectionReference events = FirebaseFirestore.instance.collection('events');
    CollectionReference operations = FirebaseFirestore.instance.collection('operations');
    CollectionReference otherExpenses = FirebaseFirestore.instance.collection('otherExpenses');
    CollectionReference income = FirebaseFirestore.instance.collection('income');

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Plant\'s Events'),
        ),
        backgroundColor: Colors.green,
      ),
     body: StreamBuilder(
        stream: events.snapshots(),
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
                  child: Text('Event\'s form'),
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
                          'Event:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextFormField(
                          controller: eventNameController,
                          decoration: const InputDecoration(
                            labelText: 'Event Name',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: eventDateController,
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
                                eventDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                              });
                            }
                          },
                        ),
                        TextFormField(
                          controller: eventDamageController,
                          decoration: const InputDecoration(
                            labelText: 'Damage',
                            icon: Icon(Icons.numbers),
                          ),
                        ),
                        TextFormField(
                          controller: eventDamagePercentController,
                          decoration: const InputDecoration(
                            labelText: 'Damage Percent',
                            icon: Icon(Icons.nature),
                          ),
                        ),
                        TextFormField(
                          controller: eventCommentController,
                          decoration: const InputDecoration(
                            labelText: 'Comments',
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

                      await events
                        .add({
                          'plantsNumber': int.parse(plantNumberController.text),
                          'plantsName': plantNameController.text,
                          'comments' : eventCommentController.text,
                          'damage' : eventDamageController.text,
                          'damagePercent' : int.parse(eventDamagePercentController.text),
                          'date' : DateTime.parse(eventDateController.text),
                          'eventName' : eventNameController.text,
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
    var eventCommentController = TextEditingController(text: doc['comments']);
    var eventDamageController = TextEditingController(text: doc['damage']);
    var eventDamagePercentController = TextEditingController(text: doc['damagePercent'].toString());
    var eventDateController = TextEditingController(text: doc['date'].toDate().toString().split(' ')[0]);
    var eventNameController = TextEditingController(text: doc['eventName']);


    return showDialog<void> (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text('Update Event'),
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
                    'Event:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextFormField(
                    controller: eventNameController,
                    decoration: const InputDecoration(
                      labelText: 'Event Name',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: eventDateController,
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
                          eventDateController.text = DateFormat('yyyy-MM-dd').format(pickDate);
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: eventDamageController,
                    decoration: const InputDecoration(
                      labelText: 'Damage',
                      icon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    controller: eventDamagePercentController,
                    decoration: const InputDecoration(
                      labelText: 'Damage Percent',
                      icon: Icon(Icons.nature),
                    ),
                  ),
                  TextFormField(
                    controller: eventCommentController,
                    decoration: const InputDecoration(
                      labelText: 'Comments',
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
              child: Text('Cancel'),
            ),
            OutlinedButton(
              onPressed: () {
                  updateData(
                    doc.id,
                    plantNameController.text,
                    plantNumberController.text,
                    eventCommentController .text,
                    eventDamageController.text,
                    eventDamagePercentController.text,
                    eventDateController.text,
                    eventNameController.text,
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

  void updateData (String id, String plantNameController, String plantNumberController, String eventCommentController, String eventDamageController, String eventDamagePercentController, String eventDateController, String eventNameController) {
    Map<String , dynamic> data = {
      'plantsName' : plantNameController,
      'plantsNumber' : int.parse(plantNumberController),
      'comments' : eventCommentController,
      'damage' : eventDamageController,
      'damagePercent' : int.parse(eventDamagePercentController),
      'date' : DateTime.parse(eventDateController),
      'eventName' : eventNameController,
    };
    FirebaseFirestore.instance.collection('events').doc(id).update(data);
  }

  Future<void> deleteRecord(String id) async {
    FirebaseFirestore.instance.collection('events').doc(id).delete();
  }
}