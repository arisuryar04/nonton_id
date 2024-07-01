import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonton_id/presentation/bloc/bloc.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/config.dart';
import '../../../../domain/entities/movie.dart';
import '../../../widgets/card_network_image.dart';
import '../../../widgets/space.dart';

Widget movieList(
  BuildContext context, {
  required String title,
  required List<Movie>? movies,
  bool isUpComing = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          title,
          style: const TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      verticalSpace(12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: movies?.map((movie) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: movies.first == movie ? 24 : 0,
                    right: movies.last == movie ? 24 : 12,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<MovieBloc>()
                          .add(OnGetMovieDetail(movie.id!));
                      context.pushNamed(
                        'movie-detail',
                        extra: isUpComing,
                      );
                    },
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          CardNetworkImage(
                            '${Config.baseImage}${movie.poster ?? movie.backdrop}',
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
                  ),
                );
              }).toList() ??
              [],
        ),
      )
    ],
  );
}
