import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecApp02/models/account.dart';
import 'package:tecApp02/providers/account_provider.dart';

Future buildTransactDialog(BuildContext context) {
  final acctProvider = Provider.of<AccountProvider>(context, listen: false);
  acctProvider.loadValues(Account());
  //final nameController = TextEditingController();
  //final numberController = TextEditingController();
  final balanceController = TextEditingController();
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(acctProvider.name),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Text(acctProvider.name),
                  // Text(acctProvider.acctNumber.toString()),
                  TextField(
                    controller: balanceController,
                    decoration: InputDecoration(hintText: 'amount'),
                    onChanged: (value) => acctProvider.changeBalance(value),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('transact'),
                onPressed: () {
                  acctProvider.saveAccount();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
