import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/config.dart';
import '../../../core/extension/context_ext.dart';
import '../../../domain/entities/movie.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';
import 'methods/options_selection_movie_detail.dart';
import 'methods/poster_info_movie.dart';
import 'methods/section_info.dart';

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

  List<int> time = List.generate(10, (index) => index + 5);
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
              // DescriptionMovieDetail Field
              final List<String> fieldMovie = [
                'Sutradara',
                'Penulis',
                'Durasi',
                'Rilis'
              ];

              return Column(
                children: [
                  /*
                    Ini part appbar dengan background dari backdrop
                    movie tersebut.
                  */
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
                            ? BlocSelector<MovieBloc, MovieState, MovieState>(
                                selector: (state) {
                                  return state;
                                },
                                builder: (context, state) {
                                  final isSaved = state.favoriteMovie?.any(
                                      (element) =>
                                          element.id == state.movieDetail?.id);

                                  return GestureDetector(
                                      onTap: () => setState(() {
                                            if (isSaved == false) {
                                              context
                                                  .read<MovieBloc>()
                                                  .add(OnSaveFavorite(Movie(
                                                    id: state.movieDetail?.id,
                                                    title: state
                                                        .movieDetail?.title,
                                                    backdrop: state
                                                        .movieDetail?.backdrop,
                                                    poster: state
                                                        .movieDetail?.poster,
                                                    voteAverage: state
                                                        .movieDetail
                                                        ?.voteAverage,
                                                    voteCount: state
                                                        .movieDetail?.voteCount,
                                                  )));
                                            } else {
                                              context.read<MovieBloc>().add(
                                                  OnRemoveFavorite(
                                                      state.movieDetail!.id!));
                                            }
                                          }),
                                      child: isSaved == false
                                          ? const Icon(
                                              Icons.favorite_border_rounded,
                                              color: white,
                                            )
                                          : const Icon(
                                              Icons.favorite_rounded,
                                              color: primary,
                                            ));
                                },
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  verticalSpace(16),

                  /*
                    Ini part poster movie dan isi terkait fieldMovie
                    dan fieldValue untuk Sutradara, Penulis, Durasi dan Rilis
                  */
                  posterInfoMovie(
                    context,
                    fieldMovie: fieldMovie,
                    fieldValue: state.descriptionMovieDetail!,
                    url: state.movieDetail!.poster ??
                        state.movieDetail!.backdrop!,
                  ),
                  verticalSpace(8),
                  /*
                    Ini part TabBar Header atau title
                    Jadwal dan Tentang
                  */
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
                  /*
                    Ini part TabBarView atau Content dari tiap TabBar
                    _sectionSchedule => part ini untuk menampilkan
                    OptionTheater, OptionTanggal dan OptionJam.
                    _sectionInfo => part ini untuk menampilkan
                    info terkait Sinopsis, Genre, Rating dan Actor
                    dari Movie Tersebut.
                  */
                  Expanded(
                    child: widget.isUpComing == false
                        ? TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _sectionSchedule(context),
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

  Widget _sectionSchedule(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(16),
          OptionSelection(
            title: 'Pilih Theater',
            options: theater,
            selected: selectedTheater,
            height: 40,
            width: context.fullWidth / 3.6,
            isScrolable: false,
            onTap: (value) => setState(() => selectedTheater = value),
          ),
          verticalSpace(24),
          OptionSelection(
            title: 'Pilih Tanggal',
            options: date,
            selected: selectedDate,
            height: 50,
            width: 50,
            converter: (date) => DateFormat('d MMM\nEEE', 'id_ID').format(date),
            onTap: (date) => setState(() => selectedDate = date),
            isEnabled: (date) => selectedTheater == null
                ? false
                : DateTime.now()
                        .isAfter(DateTime(date.year, date.month, date.day + 1))
                    ? false
                    : true,
          ),
          verticalSpace(24),
          OptionSelection(
            title: 'Pilih Jam',
            options: time,
            isScrolable: false,
            selected: selectedTime,
            height: 40,
            width: context.fullWidth / 6.5,
            converter: (time) => '$time:00',
            onTap: (time) => setState(() {
              if (selectedTime == time) {
                selectedTime = null;
              } else {
                selectedTime = time;
              }
            }),
            isEnabled: (time) => selectedDate == null
                ? false
                : DateTime.now().isAfter(DateTime(selectedDate!.year,
                        selectedDate!.month, selectedDate!.day, time))
                    ? false
                    : true,
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonCustom(
              title: 'Pilih Kursi',
              onPressed: selectedTheater == null ||
                      selectedDate == null ||
                      selectedTime == null
                  ? null
                  : () {},
            ),
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
