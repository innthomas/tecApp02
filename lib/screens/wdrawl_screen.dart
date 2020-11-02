import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecApp02/models/account.dart';
import '../providers/account_provider.dart';

class WithdrawalScreen extends StatefulWidget {
  final Account account;

  WithdrawalScreen([this.account]);

  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
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
        final productProvider =
            Provider.of<AccountProvider>(context, listen: false);
        productProvider.loadValues(Account());
      });
    } else {
      //Controller Update
      nameController.text = widget.account.name;
      balanceController.text = "";
      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<AccountProvider>(context, listen: false);
        productProvider.loadValues(widget.account);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
          backgroundColor: Colors.red[500],
          title: Center(
              child: (widget.account != null)
                  ? Text("Withdrawal transaction")
                  : Text('Add Account'))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text(widget.account.name),
            TextField(
              controller: balanceController,
              decoration: InputDecoration(
                hintText: 'amount ',
                labelText: 'withdraw',
              ),
              onChanged: (value) => productProvider.withdrawFromBalance(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Colors.red[500],
              textColor: Colors.white,
              child: Text('withdraw'),
              onPressed: () {
                productProvider.saveAccount();
                Navigator.of(context).pop();
              },
            ),
            (widget.account != null)
                ? RaisedButton(
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text('cancel'),
                    onPressed: () {
                      // productProvider.removeAccount(widget.account.accountId);
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
