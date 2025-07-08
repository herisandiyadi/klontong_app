import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sample_entity.dart';
import '../../domain/usecases/sample_usecase.dart';

part 'sample_event.dart';
part 'sample_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final SampleUseCase useCase;

  SampleBloc(this.useCase) : super(SampleInitial()) {
    on<FetchSamplesEvent>((event, emit) async {
      emit(SampleLoading());
      try {
        final samples = await useCase.getSamples();
        emit(SampleLoaded(samples));
      } catch (e) {
        emit(SampleError(e.toString()));
      }
    });
  }
}
