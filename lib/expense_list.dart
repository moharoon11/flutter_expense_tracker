import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.registeredExpenses, this.removeExpense, {super.key});

  final List<Expense> registeredExpenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(registeredExpenses[index]),
        onDismissed: (direction) {
          removeExpense(registeredExpenses[index]);
        },
        child: ExpenseItem(registeredExpenses[index]),
      ),
    );
  }
}
