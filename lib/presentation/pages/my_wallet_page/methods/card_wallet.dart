import 'package:flutter/material.dart';
import 'package:nonton_id/core/extension/context_ext.dart';
import 'package:nonton_id/core/extension/int_ext.dart';

import '../../../../core/constant/color.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/bloc.dart';

Widget cardWallet() {
  return BlocSelector<UserBloc, UserState, User>(
    selector: (state) {
      return state.user!;
    },
    builder: (context, state) {
      return Container(
        width: context.fullWidth - 48,
        height: 104,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    3,
                    (indexCol) {
                      return Row(
                        children: List.generate(
                          indexCol == 0
                              ? 4
                              : indexCol == 1
                                  ? 5
                                  : 6,
                          (indexRow) {
                            return Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.only(
                                top: indexCol == 0 ? 4 : 0,
                                left: indexRow == 0 ? 4 : 0,
                                bottom: indexCol == 2 ? 4 : 3,
                                right: 3,
                              ),
                              decoration: BoxDecoration(
                                color: grey.withOpacity(0.15),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    indexCol == 0 && indexRow == 0 ? 6 : 0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    indexCol == 2 && indexRow == 0 ? 6 : 0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 104,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saldo Sekarang',
                        style: TextStyle(
                          color: white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        state.balance!.toCurrency(),
                        style: const TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        state.name!,
                        style: TextStyle(
                          color: white.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Container(
                width: 104,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  color: primary.withOpacity(0.6),
                ),
                child: const Text(
                  'NONTON ID',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
