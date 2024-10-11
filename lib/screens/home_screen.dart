import 'package:flutter/material.dart';
import 'package:agri/screens/history.dart';
import 'events.dart';
import 'plants.dart';
import 'otherexpenses.dart';
import 'my_drawer_header.dart';
import 'income.dart';
import 'operations.dart';

//initiate home screen menu drawer header
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//constructor for the home screen menu drawer header
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//home screen menu drawer header with all the pages
class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.plants;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.plants) {
      container = PlantsScreen();
    } else if (currentPage == DrawerSections.operations) {
      container = OperationsPage();
    } else if (currentPage == DrawerSections.events) {
      container = EventsScreen();
    } else if (currentPage == DrawerSections.otherexpenses) {
      container = OtherexpensesPage();
    } else if (currentPage == DrawerSections.income) {
      container = IncomePage();
    } else if (currentPage == DrawerSections.history) {
      container = HistoryPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Horticultural Diary"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//drawer selection from pages list
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Plants", Icons.nature_people,
              currentPage == DrawerSections.plants ? true : false),
          menuItem(2, "Operations", Icons.manage_accounts,
              currentPage == DrawerSections.operations ? true : false),
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Other Expenses", Icons.money_off,
              currentPage == DrawerSections.otherexpenses ? true : false),
          menuItem(5, "Income", Icons.account_balance,
              currentPage == DrawerSections.income ? true : false),
          menuItem(6, "Search/History", Icons.access_time,
              currentPage == DrawerSections.history ? true : false),
        ],
      ),
    );
  }

//all the menu items(pages) of the drawer
  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.plants;
            } else if (id == 2) {
              currentPage = DrawerSections.operations;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.otherexpenses;
            } else if (id == 5) {
              currentPage = DrawerSections.income;
            } else if (id == 6) {
              currentPage = DrawerSections.history;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//define the drawers which we used
enum DrawerSections {
  plants,
  operations,
  events,
  otherexpenses,
  income,
  history,
}
