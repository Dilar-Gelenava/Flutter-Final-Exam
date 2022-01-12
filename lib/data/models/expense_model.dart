class ExpenseModel {
  int? id;
  String? expenseTitle;
  int? amount;
  DateTime? date;

  ExpenseModel({
    this.id,
    this.expenseTitle,
    this.amount,
    this.date,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      expenseTitle: json['expenseTitle'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = id;
//   data['expenseTitle'] = expenseTitle;
//   data['amount'] = amount;
//   data['date'] = date;
//   return data;
// }
}
