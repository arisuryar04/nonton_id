import 'package:flutter/material.dart';

import '../../../core/constant/assets.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  List<int> nominalTopUp = [];
  int? nominalSelected;

  @override
  void initState() {
    for (var i = 1; i <= 12; i++) {
      nominalTopUp.add(i * 50000);
    }
    super.initState();
  }

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
            topUpSection(
              context,
              nominalTopUp: nominalTopUp,
              selected: nominalSelected,
              afterSuccess: () => setState(() {
                nominalSelected = null;
              }),
              onTap: (nominal) => setState(() {
                nominalSelected = nominal;
              }),
            ),
            verticalSpace(8),
            recentTransaction(),
          ],
        ),
      ),
    );
  }
}
