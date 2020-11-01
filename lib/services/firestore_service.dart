import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tecApp02/models/account.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveAccount(Account account) {
    return _db
        .collection('myAccounts')
        .document(account.accountId)
        .setData(account.toMap());
  }

  Stream<List<Account>> getAccounts() {
    return _db.collection('myAccounts').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Account.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeAccount(String accountId) {
    return _db.collection('myAccounts').document(accountId).delete();
  }
}
