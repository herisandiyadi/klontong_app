import '../entities/sample_entity.dart';
import '../repositories/sample_repository.dart';

class SampleUseCase {
  final SampleRepository repository;

  SampleUseCase(this.repository);

  Future<List<SampleEntity>> getSamples() {
    return repository.getSamples();
  }

  Future<void> saveSample(SampleEntity entity) {
    return repository.saveSample(entity);
  }
}
