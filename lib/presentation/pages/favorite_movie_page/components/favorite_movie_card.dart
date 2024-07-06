import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/config.dart';
import '../../../../domain/entities/entities.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget favoriteMovieCard(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      context.read<MovieBloc>().add(OnGetMovieDetail(movie.id!));
      context.pushNamed('movie-detail', extra: false);
    },
    child: SizedBox(
      width: 120,
      child: Column(
        children: [
          CardNetworkImage(
            '${Config.baseImage}${movie.poster}',
            height: 180,
            width: 120,
            borderRadius: BorderRadius.circular(5),
          ),
          verticalSpace(8),
          Text(
            movie.title!,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
