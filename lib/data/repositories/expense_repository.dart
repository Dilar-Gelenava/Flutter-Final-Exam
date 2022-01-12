import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:expenses/data/models/expense_model.dart';

class ExpenseRepository {
  List<ExpenseModel>? expenseList = [];
  Dio dio = Dio();

  static const domain = 'http://10.0.2.2:8080';

  Future<List<ExpenseModel>?>? fetchExpenses() async {
    final response = await dio.get('$domain/expenses');
    if (response.statusCode == 200) {
      var loadedExpense = <ExpenseModel>[];
      response.data.forEach((expense) {
        ExpenseModel expenseModel = ExpenseModel.fromJson(expense);
        loadedExpense.add(expenseModel);
        expenseList = loadedExpense;
        return expenseList;
      });
    }
    return expenseList;
  }

  Future getExpense(int id) async {
    final response = await dio.post('$domain/expense/$id');

    if (response.statusCode == 200) {
      response.data;
    } else {
      return null;
    }
  }

  Future createExpense(
      int id, String expenseTitle, int amount, DateTime date) async {
    var params = {
      "id": id,
      "expenseTitle": expenseTitle,
      "amount": amount,
      "date": date.toString()
    };

    final response = await dio.post(
      '$domain/add-expense',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future removeExpense(int id) async {
    final response = await dio.delete(
      '$domain/delete-expense/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future editExpense(
      int id, String expenseTitle, int amount, DateTime date) async {
    var params = {
      "id": id,
      "expenseTitle": expenseTitle,
      "amount": amount,
      "date": date
    };

    final response = await dio.put(
      '$domain/update-expense',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
