import '../entities/sample_entity.dart';

abstract class SampleRepository {
  Future<List<SampleEntity>> getSamples();
  Future<void> saveSample(SampleEntity entity);
}
