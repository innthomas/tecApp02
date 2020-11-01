import 'package:flutter/material.dart';
import 'package:tecApp02/models/account.dart';
import 'package:tecApp02/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AccountProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _balance;
  String _accountId;
  String _acctNumber;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  String get acctNumber => _acctNumber;
  double get balance => _balance;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeBalance(String value) {
    _balance += double.parse(value);
    notifyListeners();
  }

  changeAcctNumber(String value) {
    _acctNumber = value;
    notifyListeners();
  }

  //setters add
  addName(String value) {
    _name = value;
    notifyListeners();
  }

  addNumber(String value) {
    _acctNumber = value;
    notifyListeners();
  }

  addBalance(String value) {
    _balance = double.parse(value);
    notifyListeners();
  }

  loadValues(Account account) {
    _name = account.name;
    _acctNumber = account.acctNumber;
    _balance = account.balance;
    _accountId = account.accountId;
  }

  saveAccount() {
    print(_accountId);
    if (_accountId == null) {
      var newAccount = Account(
          name: name,
          acctNumber: acctNumber,
          balance: balance,
          accountId: uuid.v4());
      firestoreService.saveAccount(newAccount);
    } else {
      //Update
      var updatedAccount = Account(
          name: name,
          balance: _balance,
          acctNumber: acctNumber,
          accountId: _accountId);
      firestoreService.saveAccount(updatedAccount);
    }
  }

  removeAccount(String accountId) {
    firestoreService.removeAccount(accountId);
  }
}
