class Account {
  final String accountId;
  final String name;
  final String acctNumber;
  double balance;

  Account({this.accountId, this.balance, this.name, this.acctNumber});

  Map<String, dynamic> toMap() {
    return {
      'accountId': accountId,
      'name': name,
      'balance': balance,
      'acctNumber': acctNumber
    };
  }

  Account.fromFirestore(Map<String, dynamic> firestore)
      : accountId = firestore['accountId'],
        name = firestore['name'],
        acctNumber = firestore['acctNumber'],
        balance = firestore['balance'];
}
