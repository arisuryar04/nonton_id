import 'package:flutter/material.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget profile() {
  return BlocSelector<UserBloc, UserState, User>(
    selector: (state) {
      return state.user!;
    },
    builder: (context, state) {
      return Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: state.photoUrl != null
                ? NetworkImage(state.photoUrl!)
                : const AssetImage(Assets.profilePlaceholder),
          ),
          verticalSpace(10),
          Text(
            state.name ?? '',
            style: const TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          verticalSpace(5),
          Text(
            state.email ?? '',
            style: TextStyle(color: white.withOpacity(0.6)),
          ),
        ],
      );
    },
  );
}
