import 'package:flutter/material.dart';
import 'package:expenses/widgets/main_button.dart';
import 'package:expenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:expenses/data/repositories/expense_repository.dart';

class EditWindow extends StatefulWidget {
  const EditWindow({Key? key, this.expense}) : super(key: key);

  final dynamic expense;

  @override
  State<EditWindow> createState() => _EditWindowState();
}

class _EditWindowState extends State<EditWindow> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.expense.expenseTitle;
    _amountController.text = widget.expense.amount.toString();
    _selectedDate = widget.expense.date;

    return Container(
      color: const Color(0xFF95d3c4),
      child: ListView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              'EDIT EXPENSE',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          TextField(
            controller: _titleController,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Please enter title'),
          ),
          TextField(
            controller: _amountController,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: 'Please enter amount'),
          ),
          MainButton(
            text: 'date',
            width: 100.0,
            action: () async {
              DateTime? _date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                lastDate: DateTime(2030),
                firstDate: DateTime(2010),
              );
              setState(() {
                _selectedDate = _date;
              });
            },
          ),
          MainButton(
            text: 'Delete',
            action: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("are you sure?"),
                      content: Wrap(
                        children: [
                          MainButton(
                              action: () {
                                ExpenseRepository()
                                    .removeExpense(widget.expense.id);
                                Provider.of<ExpenseProvider>(context,
                                        listen: false)
                                    .getExpenses();
                                Navigator.of(context).pop();
                              },
                              text: "yes"),
                          MainButton(
                              action: () => Navigator.of(context).pop(),
                              text: "no"),
                        ],
                      ),
                    );
                  });
            },
          ),
          MainButton(
            text: 'SUBMIT',
            action: () async {
              if (_titleController.text == "" ||
                  _amountController.text == "" ||
                  _selectedDate == null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter valid data!'),
                  ),
                );
              } else {
                ExpenseRepository().createExpense(widget.expense.id, _titleController.text,
                    int.parse(_amountController.text), _selectedDate!);
                Provider.of<ExpenseProvider>(context, listen: false)
                    .getExpenses();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
