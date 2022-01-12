import 'package:flutter/material.dart';
import 'package:expenses/widgets/main_button.dart';
import 'package:expenses/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:expenses/data/repositories/expense_repository.dart';
import 'dart:math';

class AddWindow extends StatefulWidget {
  const AddWindow({Key? key}) : super(key: key);

  @override
  State<AddWindow> createState() => _AddWindowState();
}

class _AddWindowState extends State<AddWindow> {
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF95d3c4),
      child: ListView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              'NEW EXPENSE',
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
                ExpenseRepository().createExpense(Random().nextInt(100), _titleController.text, int.parse(_amountController.text), _selectedDate!);
                Provider.of<ExpenseProvider>(context, listen: false).getExpenses();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
