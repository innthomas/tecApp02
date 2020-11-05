import 'package:flutter/material.dart';

import 'package:tecApp02/models/account.dart';
import 'package:tecApp02/providers/account_provider.dart';
import 'package:tecApp02/screens/wdrawl_screen.dart';

import 'deposit_screen.dart';

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
          leading: Icon(Icons.person),
          title: Text(accounts[index].name),
          subtitle: Text(accounts[index].acctNumber.toString()),
          trailing: Text(
            accounts[index].balance.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: (accounts[index].balance < 0)
                  ? Colors.red[800]
                  : Colors.green[800],
            ),
          ),
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WithdrawalScreen(accounts[index])));
          },
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DepositScreen(accounts[index])));
          },
        );
      },
    );
  }

//TODO tranzact dialog not working to de discarded to be discarded
  Future buildShowDialog(
    BuildContext context,
    int index,
    TextEditingController balanceController,
    AccountProvider acctProvider,
  ) {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Column(
                children: <Widget>[
                  new Text(accounts[index].name),
                  Text(accounts[index].acctNumber),
                ],
              ),
              content: new TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: balanceController,
                decoration: InputDecoration(
                  labelText: "amount",
                  hintText: 'amount',
                ),
                onChanged: (value) => acctProvider.depositToBalance(value),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
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
                ),
              ],
            ));
  }
}
