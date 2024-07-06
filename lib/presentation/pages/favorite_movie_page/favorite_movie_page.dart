import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../bloc/bloc.dart';
import 'components/components.dart';

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
                return favoriteMovieCard(context, movie);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
