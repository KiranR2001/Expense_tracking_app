import 'dart:convert';

import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});

  factory Transaction.fromJson(Map<String, dynamic> jsonData) {
    return Transaction(
      id: jsonData['id'],
      title: jsonData['title'],
      amount: jsonData['amount'],
      date: DateTime.parse(jsonData['date']),
    );
  }

  static Map<String, dynamic> toMap(Transaction transaction) => {
        'id': transaction.id,
        'title': transaction.title,
        'amount': transaction.amount,
        'date': transaction.date.toIso8601String(),
      };

  static String encode(List<Transaction> transactions) => json.encode(
        transactions
            .map<Map<String, dynamic>>(
                (transaction) => Transaction.toMap(transaction))
            .toList(),
      );

  static List<Transaction> decode(String transactions) =>
      (json.decode(transactions) as List<dynamic>)
          .map<Transaction>((item) => Transaction.fromJson(item))
          .toList();
}
