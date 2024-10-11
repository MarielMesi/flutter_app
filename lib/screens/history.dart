import 'package:agri/displayQuery/plantsQuery.dart';
import 'package:flutter/material.dart';
import '../displayQuery/eventsQuery.dart';
import '../displayQuery/expensesQuery.dart';
import '../displayQuery/incomeQuery.dart';
import '../displayQuery/operationsQuery.dart';


class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Plant\'s History'),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center (
                child: 
                  Text(
                    'All Plants Query', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),  
              ),
              allButton('Plant\'s Query', plantsQuery()),
              const SizedBox(
                height: 15,
              ),
              const Center (
                child: 
                  Text(
                    'Annual Operations Query', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),  
              ),
              allButton('Operation\'s Query', operationsQuery()),
              const SizedBox(
                height: 15,
              ),
              const Center (
                child: 
                  Text(
                    'Annual Events Query', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),  
              ),
              allButton('Event\'s Query', eventsQuery()),
              const SizedBox(
                height: 15,
              ),
              const Center (
                child: 
                  Text(
                    'Annual Expenses Not Zero  Query', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),  
              ),
              allButton('Expense\'s Query', expensesQuery()),
              const SizedBox(
                height: 15,
              ),
              const Center (
                child: 
                  Text(
                    'Annual Income Not Zero  Query', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),  
              ),
              allButton('Income\'s Query', incomeQuery()),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget allButton(String text , var pageName){
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageName),
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
