import 'package:flutter/material.dart';

import '../../../../core/constant/config.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget backdropMoviePoster(BuildContext context) {
  return BlocSelector<MovieBloc, MovieState, String>(
    selector: (state) {
      return state.movieDetail?.backdrop ?? state.movieDetail!.poster!;
    },
    builder: (context, state) {
      return CardNetworkImage(
        '${Config.baseImage}$state',
        height: context.fullWidth * 0.5,
        width: context.fullWidth,
        borderRadius: BorderRadius.circular(8),
      );
    },
  );
}
