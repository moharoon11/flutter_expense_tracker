import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  openDatePicker() async {
    DateTime now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  saveExpenses() {
    double? amount = double.tryParse(amountController.text);
    final invalidAmount = amount == null || amount <= 0;

    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                )
              ],
              title: const Text(
                'Invalid input',
              ),
              content: const Text(
                  'Please make sure a valid title,amount,date, category entered'),
            );
          });

      return;
    }

    widget.addExpense(
      Expense(
        title: titleController.text,
        amount: amount,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                'Title',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text(
                        'Amount',
                      ),
                      prefix: Text('\$')),
                ),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          (selectedDate == null)
                              ? 'No Date Selected'
                              : formatter.format(selectedDate!),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: openDatePicker,
                      ),
                    ]),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              TextButton(
                child: const Text(
                  'Cancel',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                onPressed: saveExpenses,
                child: const Text(
                  'save',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
