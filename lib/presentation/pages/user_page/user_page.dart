import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../widgets/widgets.dart';
import 'methods/button_logout.dart';
import 'methods/info_item_user.dart';
import 'methods/profile.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          verticalSpace(context.paddingAppBar + 24),
          profile(),
          verticalSpace(24),
          Divider(
            color: primary.withOpacity(0.6),
            thickness: 0.5,
          ),
          infoItemUser(
            label: 'Perbarui Profile',
            onTap: () => context.pushNamed('update-profile'),
          ),
          infoItemUser(
            label: 'Dompet Saya',
            onTap: () => context.pushNamed('my-wallet'),
          ),
          infoItemUser(
            label: 'Ubah Kata Sandi',
            onTap: () => context.pushNamed('change-password'),
          ),
          verticalSpace(8),
          Divider(
            color: primary.withOpacity(0.6),
            thickness: 0.5,
          ),
          infoItemUser(
            label: 'Hubungi Kami',
            onTap: () => context.showSnackbar('Fitur belum tersedia'),
          ),
          infoItemUser(
            label: 'Kebijakan Privasi',
            onTap: () => context.showSnackbar('Fitur belum tersedia'),
          ),
          infoItemUser(
            label: 'Syarat dan Ketentuan',
            onTap: () => context.showSnackbar('Fitur belum tersedia'),
          ),
          verticalSpace(48),
          buttonLogout(),
          verticalSpace(24),
          Text(
            'Version 0.0.1',
            style: TextStyle(color: white.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
