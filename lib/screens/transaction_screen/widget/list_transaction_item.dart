import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/widget/transaction_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<TransactionItem> transactions = [
    TransactionItem(amount: '10,000', date: '2023-10-16', status: 'Top Up Saldo',),
    TransactionItem(amount: '20,000', date: '2023-10-15', status: 'Pulsa Prabayar',),
    TransactionItem(amount: '50,000', date: '2023-10-14', status: '',),
    TransactionItem(amount: '100,000', date: '2023-10-13', status: '',),
    TransactionItem(amount: '200,000', date: '2023-10-12', status: '',),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      children: transactions,
    );
  }
}