import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonton_id/core/constant/color.dart';
import 'package:nonton_id/core/constant/config.dart';
import 'package:nonton_id/core/extension/context_ext.dart';
import 'package:nonton_id/presentation/widgets/widgets.dart';

import '../../bloc/bloc.dart';

class FavoriteMoviePage extends StatelessWidget {
  const FavoriteMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.favoriteMovie!.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada film favorite nih',
              style: TextStyle(
                color: white,
                fontSize: 16,
              ),
            ),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
              top: context.paddingAppBar + 12,
              left: 16,
              right: 16,
              bottom: 110,
            ),
            child: Wrap(
              spacing: 9,
              runSpacing: 16,
              children: state.favoriteMovie!.map((movie) {
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
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
