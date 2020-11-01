import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecApp02/models/account.dart';
import 'package:tecApp02/providers/account_provider.dart';
import 'package:tecApp02/screens/accounts_dashboard.dart';

Future buildTransactDialog(BuildContext context) {
  final acctProvider = Provider.of<AccountProvider>(context, listen: false);
  acctProvider.loadValues(Account());
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final balanceController = TextEditingController();
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(""),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Account Name'),
                    onChanged: (value) {
                      acctProvider.addName(value);
                    },
                  ),
                  TextField(
                    controller: numberController,
                    decoration: InputDecoration(hintText: 'Account Number'),
                    onChanged: (value) {
                      acctProvider.addNumber(value);
                    },
                  ),
                  TextField(
                    controller: balanceController,
                    decoration: InputDecoration(hintText: 'Deposit'),
                    onChanged: (value) => acctProvider.addBalance(value),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('add account'),
                onPressed: () {
                  acctProvider.saveAccount();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
