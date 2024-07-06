import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/config.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/entities.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

class MovieDetailPage extends StatefulWidget {
  final bool isUpComing;

  const MovieDetailPage({
    super.key,
    this.isUpComing = false,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  List<DateTime> date = List.generate(7, (index) {
    final now = DateTime.now();

    return DateTime(now.year, now.month, 1 + index);
  });
  DateTime? selectedDate;

  List<String> theater = [
    'Lippo Karawaci',
    'TangCity',
    'Metropolis',
    'The Breeze',
    'Alam Sutera',
    'Living World',
  ];
  String? selectedTheater;

  List<int> time = List.generate(10, (index) => index + 10);
  int? selectedTime;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.isUpComing == false ? 2 : 0,
      child: Scaffold(
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.status == StatusMovie.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == StatusMovie.failed) {
              return Center(child: Text(state.message ?? ''));
            } else if (state.status == StatusMovie.success) {
              final List<String> fieldMovie = [
                'Sutradara',
                'Penulis',
                'Durasi',
                'Rilis'
              ];

              final isSaved = state.favoriteMovie!
                  .any((element) => element.id == state.movieDetail?.id);

              return Column(
                children: [
                  Stack(
                    children: [
                      CardNetworkImage(
                        '${Config.baseImage}${state.movieDetail?.backdrop}',
                        height: context.fullWidth * 0.55,
                        width: context.fullWidth,
                      ),
                      Container(
                        height: context.fullWidth * 0.55,
                        width: context.fullWidth,
                        color: black.withOpacity(0.65),
                      ),
                      AppBarCustom(
                        title: state.movieDetail?.title ?? '',
                        rightChild: widget.isUpComing == false
                            ? iconFavoriteMovieDetail(
                                isSaved: isSaved,
                                onTap: () => setState(() {
                                  if (isSaved == false) {
                                    context
                                        .read<MovieBloc>()
                                        .add(OnSaveFavorite(Movie(
                                          id: state.movieDetail?.id,
                                          title: state.movieDetail?.title,
                                          backdrop: state.movieDetail?.backdrop,
                                          poster: state.movieDetail?.poster,
                                          voteAverage:
                                              state.movieDetail?.voteAverage,
                                          voteCount:
                                              state.movieDetail?.voteCount,
                                        )));
                                  } else {
                                    context.read<MovieBloc>().add(
                                        OnRemoveFavorite(
                                            state.movieDetail!.id!));
                                  }
                                }),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  posterInfoMovie(
                    context,
                    fieldMovie: fieldMovie,
                    fieldValue: state.descriptionMovieDetail!,
                    url: state.movieDetail!.poster ??
                        state.movieDetail!.backdrop!,
                  ),
                  verticalSpace(8),
                  widget.isUpComing == false
                      ? TabBar(
                          indicatorColor: grey,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: white.withOpacity(0.6),
                          dividerHeight: 0.9,
                          indicator: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: primary.withOpacity(0.6)))),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          overlayColor:
                              const WidgetStatePropertyAll(background),
                          splashFactory: NoSplash.splashFactory,
                          labelStyle: TextStyle(
                            color: primary.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: white.withOpacity(0.6),
                            fontSize: 16,
                          ),
                          tabs: const [
                            Tab(
                              text: 'Jadwal',
                            ),
                            Tab(
                              text: 'Tentang',
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Expanded(
                    child: widget.isUpComing == false
                        ? TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              sectionSchedule(
                                context,
                                state.movieDetail!,
                                // Theater
                                theaterList: theater,
                                selectedTheater: selectedTheater,
                                onTapTheater: (value) => setState(() {
                                  selectedTheater = value;
                                }),
                                // Date
                                dateList: date,
                                selectedDate: selectedDate,
                                onTapDate: (value) => setState(() {
                                  selectedDate = value;
                                }),
                                // Time
                                timeList: time,
                                selectedTime: selectedTime,
                                onTapTime: (value) => setState(() {
                                  if (selectedTime == value) {
                                    selectedTime = null;
                                  } else {
                                    selectedTime = value;
                                  }
                                }),
                              ),
                              sectionInfo(state, state.actor!),
                            ],
                          )
                        : sectionInfo(state, state.actor!),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
