import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecApp02/models/account.dart';
import '../providers/account_provider.dart';

class EditAccount extends StatefulWidget {
  final Account account;

  EditAccount([this.account]);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final nameController = TextEditingController();
  final balanceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.account == null) {
      //New Record
      nameController.text = "";
      balanceController.text = "";
      new Future.delayed(Duration.zero, () {
        final acctProvider =
            Provider.of<AccountProvider>(context, listen: false);
        acctProvider.loadValues(Account());
      });
    } else {
      //Controller Update
      nameController.text = widget.account.name;
      balanceController.text = widget.account.balance.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final acctProvider =
            Provider.of<AccountProvider>(context, listen: false);
        acctProvider.loadValues(widget.account);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final acctProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
          title: Center(
              child: (widget.account != null)
                  ? Text("add transaction")
                  : Text('Add Account'))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text(acctProvider.name),
            Text(acctProvider.acctNumber),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                acctProvider.saveAccount();
                Navigator.of(context).pop();
              },
            ),
            (widget.account != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      acctProvider.removeAccount(widget.account.accountId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
