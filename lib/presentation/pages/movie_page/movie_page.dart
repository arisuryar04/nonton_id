import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../widgets/space.dart';
import 'components/components.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  String get welcome {
    final now = DateTime.now().hour;

    if (now > 3 && now < 11) {
      return 'Selamat Pagi,';
    } else if (now > 11 && now < 15) {
      return 'Selamat Siang,';
    } else if (now > 15 && now < 18) {
      return 'Selamat Sore,';
    } else {
      return 'Selamat Malam,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.status == StatusMovie.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == StatusMovie.failed) {
          return Center(child: Text(state.message ?? ''));
        } else if (state.status == StatusMovie.success) {
          return SingleChildScrollView(
            child: Column(
              children: [
                appBarMovie(context, welcome),
                searchMovie(context),
                verticalSpace(24),
                movieList(
                  context,
                  title: 'Sedang Tayang',
                  movies: state.nowPlaying,
                ),
                verticalSpace(24),
                promotions(context),
                verticalSpace(24),
                movieList(
                  context,
                  title: 'Yang Akan Datang',
                  movies: state.upComing,
                  isUpComing: true,
                ),
                verticalSpace(110),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
