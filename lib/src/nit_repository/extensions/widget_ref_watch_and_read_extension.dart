import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

extension WidgetRefWatchAndReadExtension on WidgetRef {
  T readModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) =>
      readMaybeModel<T>(key, repositoryDescriptor)!;

  T? readMaybeModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) =>
      key == NitDefaultModelsRepository.mockModelId
          ? NitDefaultModelsRepository.get<T>()
          : read(
              NitRepository.getModelProvider<T, int>(
                key,
                repositoryDescriptor,
              ),
            );

  T watchModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) =>
      watchMaybeModel<T>(key, repositoryDescriptor)!;

  T? watchMaybeModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) =>
      key == NitDefaultModelsRepository.mockModelId
          ? NitDefaultModelsRepository.get<T>()
          : watch(
              NitRepository.getModelProvider<T, int>(
                key,
                repositoryDescriptor,
              ),
            );

  Future<T> watchOrFetchModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) async {
    T? model = watchMaybeModel<T>(key, repositoryDescriptor);

    if (model == null) {
      await watch(
        NitRepository.getFetchProvider(key, repositoryDescriptor).future,
      );
    }
    return watchModel<T>(
      key,
      repositoryDescriptor,
    );
  }

  Future<T?> watchOrFetchMaybeModel<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) async {
    T? model = watchMaybeModel<T>(key, repositoryDescriptor);

    if (model == null) {
      await watch(
        NitRepository.getFetchProvider(key, repositoryDescriptor).future,
      );
    }
    return watchMaybeModel<T>(
      key,
      repositoryDescriptor,
    );
  }

  AsyncValue<T> watchOrFetchModelAsync<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) {
    T? model = watchMaybeModel<T>(key, repositoryDescriptor);

    return model != null
        ? AsyncData(model)
        : watch(
            NitRepository.getFetchProvider(key, repositoryDescriptor),
          ).whenData(
            (_) => watchModel<T>(
              key,
              repositoryDescriptor,
            ),
          );
  }

  AsyncValue<T?> watchOrFetchMaybeModelAsync<T extends SerializableModel>(
    int key, [
    NitRepositoryDescriptor<T, int>? repositoryDescriptor,
  ]) {
    T? model = watchMaybeModel<T>(key, repositoryDescriptor);

    return model != null
        ? AsyncData(model)
        : watch(NitRepository.getFetchProvider(
            key,
            repositoryDescriptor,
          )).whenData(
            (_) => watchMaybeModel<T>(
              key,
              repositoryDescriptor,
            )!,
          );
  }

  AsyncValue<T> watchModelCustomAsync<T extends SerializableModel>(
    SingleItemCustomProviderConfig config,
  ) =>
      watch(singleItemCustomProvider<T>()(config)).whenData(
        (value) => watchModel<T>(
          value!,
        ),
      );

  AsyncValue<T?> watchMaybeModelCustomAsync<T extends SerializableModel>(
    SingleItemCustomProviderConfig config,
  ) =>
      watch(singleItemCustomProvider<T>()(config)).whenData(
        (value) => value == null
            ? null
            : watchModel<T>(
                value,
              ),
      );
}
