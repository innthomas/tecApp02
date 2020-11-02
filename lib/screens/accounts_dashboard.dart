import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:tecApp02/models/account.dart';

import 'add_acct_dialog.dart';

import 'myListViewBuilder.dart';

Account account;

class AccountDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<Account>>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('account Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: () => buildShowSearch(context, accounts),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () => buildShowAddAccountDialog(context)),
          ],
        ),
        body: (accounts != null)
            ? MyListViewBuilder(accounts: accounts)
            : Center(child: CircularProgressIndicator()));
  }

  Future<Account> buildShowSearch(
      BuildContext context, List<Account> accounts) {
    return showSearch(
      context: context,
      delegate: SearchPage<Account>(
        items: accounts,
        searchLabel: 'Search people',
        suggestion: Center(child: MyListViewBuilder(accounts: accounts)
            //Text('Filter people by name, surname or age'),
            ),
        failure: Center(
          child: Text('No person found :('),
        ),
        filter: (person) => [
          person.name,
          person.balance.toString(),
          person.acctNumber,
        ],
        builder: (person) => ListTile(
          leading: Icon(Icons.person),
          title: Text(person.name),
          subtitle: Text(person.acctNumber),
          trailing: Text(
            person.balance.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: (person.balance < 0) ? Colors.red[800] : Colors.green[800],
            ),
          ),
        ),
      ),
    );
  }
}
