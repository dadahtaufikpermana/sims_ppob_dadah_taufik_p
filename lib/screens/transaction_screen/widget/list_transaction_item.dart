import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_dadah_taufik_p/screens/transaction_screen/widget/transaction_item.dart';

import '../../../data/models/transaction_model_history.dart';
import '../../../utils/provider/transaction_history_provider.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionHistoryProvider>(context);
    final List<TransactionRecord> transactions = transactionProvider.transactionHistory;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionItem(
          description: transaction.description,
          totalAmount: transaction.totalAmount,
          createdOn: transaction.createdOn, transactionType: transaction.transactionType,
        );
      },
    );
  }
}