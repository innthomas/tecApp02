import 'package:flutter/material.dart';
import 'package:tecApp02/models/account.dart';

import 'transact_dialog.dart';

//import 'edit_account.dart';

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({
    Key key,
    @required this.accounts,
  }) : super(key: key);

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(accounts[index].name),
            subtitle: Text(accounts[index].acctNumber.toString()),
            trailing: Text(accounts[index].balance.toString()),
            onTap: () => buildTransactDialog(context),
            //onTap: () {

            //Navigator.of(context).push(MaterialPageRoute(
            //    builder: (context) => EditAccount(accounts[index])));
            // },
          );
        });
  }
}
