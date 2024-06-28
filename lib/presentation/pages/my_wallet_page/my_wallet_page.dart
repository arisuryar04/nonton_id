import 'package:flutter/material.dart';

import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../widgets/widgets.dart';
import 'methods/card_wallet.dart';

class MyWalletPage extends StatelessWidget {
  const MyWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(
              title: 'Dompet Saya',
              rightChild: Image.asset(
                Assets.wallet,
                height: 24,
                width: 24,
              ),
            ),
            cardWallet(),
            verticalSpace(24),
            const Text(
              'Transaksi terakhir',
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
