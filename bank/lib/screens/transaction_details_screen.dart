import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String accountType;
  final List<Transaction> transactions;

  TransactionDetailsScreen({
    required this.accountType,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$accountType Transactions')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var tx = transactions[index];
          bool isCredit = tx.amount >= 0;
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isCredit ? Colors.green : Colors.red,
                child: Icon(
                  isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
              title: Text(tx.description),
              subtitle: Text(tx.date),
              trailing: Text(
                '\$${tx.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: isCredit ? Colors.green.shade700 : Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
