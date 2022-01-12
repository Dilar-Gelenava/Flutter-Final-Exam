import 'package:flutter/cupertino.dart';
import 'package:expenses/data/models/expense_model.dart';
import 'package:expenses/data/repositories/expense_repository.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> _expenses = [];

  void getExpenses() async {
    _expenses = (await ExpenseRepository().fetchExpenses())!;
    notifyListeners();
  }

  List get getExpenseList => _expenses;

  void addExpense(expense) {
    notifyListeners();
  }
}
