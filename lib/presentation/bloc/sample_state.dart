part of 'sample_bloc.dart';

abstract class SampleState {}

class SampleInitial extends SampleState {}

class SampleLoading extends SampleState {}

class SampleLoaded extends SampleState {
  final List<SampleEntity> samples;
  SampleLoaded(this.samples);
}

class SampleError extends SampleState {
  final String message;
  SampleError(this.message);
}
