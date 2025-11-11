import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import 'transaction_details_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class AccountListScreen extends StatefulWidget {
  @override
  _AccountListScreenState createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  List<Account> accounts = [];
  Map<String, List<Transaction>> transactions = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Load accounts
    String accountStr = await rootBundle.loadString('lib/data/accounts.json');
    final accountJson = json.decode(accountStr)['accounts'] as List;
    accounts = accountJson.map((a) => Account.fromJson(a)).toList();

    // Load transactions
    String txStr = await rootBundle.loadString('lib/data/transactions.json');
    final txJson = json.decode(txStr)['transactions'] as Map<String, dynamic>;
    txJson.forEach((key, value) {
      transactions[key] =
          (value as List).map((t) => Transaction.fromJson(t)).toList();
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts')),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          var acc = accounts[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(acc.type),
              subtitle:
                  Text('Account: ${acc.accountNumber}\nBalance: \$${acc.balance}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransactionDetailsScreen(
                        accountType: acc.type,
                        transactions: transactions[acc.type] ?? [],
                      ),
                    ),
                  );
                },
                child: Text('View Transactions'),
              ),
            ),
          );
        },
      ),
    );
  }
}
