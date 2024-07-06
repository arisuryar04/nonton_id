import 'package:flutter/material.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/config.dart';
import '../../../../domain/entities/credits.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget sectionInfo(MovieState state, List<Credits> actors) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(16),
        // ---START--- Sinopsis, Genre, Rating dan Title Pemain
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sinopsis',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(8),
              Text(
                state.movieDetail?.overview ?? '',
                style: TextStyle(
                  color: white.withOpacity(0.8),
                ),
              ),
              verticalSpace(12),
              const Text(
                'Genre',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(8),
              Wrap(
                runAlignment: WrapAlignment.start,
                children: state.movieDetail!.genres!
                    .map(
                      (genre) => Text(
                        state.movieDetail!.genres?.last == genre
                            ? genre
                            : '$genre, ',
                        style: TextStyle(
                          color: white.withOpacity(0.8),
                        ),
                      ),
                    )
                    .toList(),
              ),
              verticalSpace(12),
              const Text(
                'Rating',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(8),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: primary,
                    size: 18,
                  ),
                  horizontalSpace(8),
                  Text(
                    state.movieDetail!.voteAverage!.toStringAsFixed(1),
                    style: TextStyle(
                      color: white.withOpacity(0.8),
                    ),
                  )
                ],
              ),
              verticalSpace(24),
              const Text(
                'Pemain',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpace(12),
            ],
          ),
        ),
        // ---END--- Sinopsis, Genre, Rating dan Title Pemain

        // ---START--- List Pemain Scroll Horizontal
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actors.map((actor) {
              return Container(
                width: 90,
                margin: EdgeInsets.only(
                  left: actors.first == actor ? 24 : 12,
                  right: actors.last == actor ? 24 : 0,
                ),
                child: Column(
                  children: [
                    CardNetworkImage(
                      '${Config.baseImage}${actor.poster}',
                      height: 120,
                      width: 90,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    verticalSpace(5),
                    Text(
                      actor.name ?? '',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        // ---END--- List Pemain Scroll Horizontal
        verticalSpace(24),
      ],
    ),
  );
}
