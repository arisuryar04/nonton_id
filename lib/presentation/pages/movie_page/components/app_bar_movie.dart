import 'package:flutter/material.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/int_ext.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/bloc.dart';

Widget appBarMovie(BuildContext context, String welcome) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24, context.paddingAppBar + 8, 24, 24),
    child: BlocSelector<UserBloc, UserState, User?>(
      selector: (state) {
        return state.user;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              direction: Axis.vertical,
              spacing: 8,
              children: [
                Text(
                  '$welcome ${state?.name?.split(' ').first}',
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Ayo pesan film favorite mu',
                  style: TextStyle(
                    color: white.withOpacity(0.6),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    Image.asset(
                      Assets.wallet,
                      height: 16,
                      width: 16,
                    ),
                    Text(
                      state?.balance?.toCurrency() ?? '',
                      style: const TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: state?.photoUrl != null
                  ? NetworkImage(state!.photoUrl!)
                  : const AssetImage(Assets.profilePlaceholder),
            ),
          ],
        );
      },
    ),
  );
}
