import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.registeredExpenses, {super.key});

  final List<Expense> registeredExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpenses.length,
      itemBuilder: (context, index) => ExpenseItem(registeredExpenses[index]),
    );
  }
}
