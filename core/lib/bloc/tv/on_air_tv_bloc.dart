import 'package:bloc/bloc.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:core/domain/tv/usecases/get_on_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  OnAirTvBloc(this.getOnAirTv) : super(OnAirTvInitial());
  final GetOnAirTv getOnAirTv;

   @override
  Stream<OnAirTvState> mapEventToState(
    OnAirTvEvent event,
  ) async* {
    if (event is FetchOnAirTv) {
      yield OnAirTvLoading();
      final nowPlayingresult = await getOnAirTv.execute();

      yield* nowPlayingresult.fold(
        (failure) async* {
        yield OnAirTvError(failure.message);
      }, (movie) async* {
        yield OnAirTvLoaded(movie);
      });
    }
  }
}
