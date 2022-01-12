import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses/providers/expense_provider.dart';
import 'package:expenses/widgets/add_window.dart';
import 'package:expenses/widgets/edit_window.dart';

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseProvider>(context, listen: false).getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    List _expenses = Provider.of<ExpenseProvider>(context).getExpenseList;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.login),
              tooltip: 'login',
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff525252), Color(0xff3d72b4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          title: const Center(
            child: Text(
              'Expenses',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const AddWindow();
              },
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image_1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return EditWindow(expense: _expenses[index]);
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(_expenses[index].expenseTitle),
                      subtitle: Text(_expenses[index].date.toString()),
                      trailing: Text(
                        '${_expenses[index].amount.toString()},00\$',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ));
            },
            itemCount: _expenses.length,
          ),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
