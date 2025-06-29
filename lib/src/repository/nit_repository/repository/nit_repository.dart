// export 'descriptor/repository_descriptor.dart';
// export 'state/nit_repository_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

final globalRefreshTriggerProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);

class NitRepository {
  // static debug() {
  //   for (var MapEntry(:key, :value) in _repositories.entries) {
  //     print(key);
  //     print(value);
  //     continue;
  //   }
  // }

  static final Map<Type, String> _typeNamesMapping = {};

  static String typeName<T extends SerializableModel>() =>
      _typeNamesMapping[T]!;

  static String? maybeTypeName<T>() => _typeNamesMapping[T];

  static final Map<NitRepositoryDescriptor,
      StateProviderFamily<dynamic, dynamic>> _repositories = {};
  static final Map<String, List<NitRepositoryDescriptor>>
      _customRepositoryDescriptors = {};
  static final Map<String, List<Function(List<ObjectWrapper>)>>
      _updateListeners = {};

  static final Map<String, NitRepositoryDescriptor> _defaultDescriptors = {};

  static setupRepository<T extends SerializableModel>(
    String mappingClassName,
  ) {
    _typeNamesMapping[T] = mappingClassName;
    _defaultDescriptor<T>();
  }

  static NitRepositoryDescriptor<T, int>
      _defaultDescriptor<T extends SerializableModel>() {
    final className = NitRepository.typeName<T>();

    if (_defaultDescriptors.containsKey(className)) {
      return _defaultDescriptors[className] as NitRepositoryDescriptor<T, int>;
    }

    debugPrint("Initializing default descriptor for $T");

    final descriptor = NitRepositoryDescriptor<T, int>(fieldName: 'id');

    _repositories[descriptor] = StateProvider.family<T?, int>(
      (ref, key) => null,
    );

    return _defaultDescriptors[className] = descriptor;
  }

  static bool addRepositoryDescriptor<T extends SerializableModel, K>(
    NitRepositoryDescriptor<T, K> descriptor,
  ) {
    // for (var d in descriptors) {
    if (_customRepositoryDescriptors[descriptor.className] == null) {
      _customRepositoryDescriptors[descriptor.className] = [];
    }

    _repositories[descriptor] = StateProvider.family<T?, K>(
      (ref, key) => null,
    );

    _customRepositoryDescriptors[descriptor.className]!.add(descriptor);

    return true;
  }

  static addUpdatesListener<T extends SerializableModel>(
    Function(
      List<ObjectWrapper> wrappedModelUpdates,
    ) listener,
  ) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[NitRepository.typeName<T>()] == null) {
      _updateListeners[NitRepository.typeName<T>()] = [];
    }
    _updateListeners[NitRepository.typeName<T>()]!.add(listener);
  }

  static removeUpdatesListener<T extends SerializableModel>(
      Function(
        List<ObjectWrapper> wrappedModelUpdates,
      ) listener) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[NitRepository.typeName<T>()] != null) {
      _updateListeners[NitRepository.typeName<T>()]!.remove(listener);
    }
  }

  static updateListeningStates({
    required List<ObjectWrapper> wrappedModelUpdates,
    // required String className,
    // required int modelId,
  }) {
    final updateMap = <String, List<ObjectWrapper>>{};

    for (var wrappedModel in wrappedModelUpdates) {
      if (updateMap[wrappedModel.nitMappingClassname] == null) {
        updateMap[wrappedModel.nitMappingClassname] = [wrappedModel];
      } else {
        updateMap[wrappedModel.nitMappingClassname]!.add(wrappedModel);
      }
    }

    for (var className in updateMap.keys) {
      debugPrint(
          'Updating Listening States for $className with ${updateMap[className]!.length} objects. Active listeners: ${_updateListeners.keys}.');
      for (var listener in _updateListeners[className] ?? []) {
        listener(
          updateMap[className],
        );
      }
    }
  }

  static Iterable<StateProvider<SerializableModel?>> getAllModelProviders(
          ObjectWrapper wrapper) =>
      [
        // _defaultDescriptor<T>(),
        if (_defaultDescriptors.containsKey(wrapper.nitMappingClassname))
          _defaultDescriptors[wrapper.nitMappingClassname]!,
        if (_customRepositoryDescriptors
            .containsKey(wrapper.nitMappingClassname))
          ..._customRepositoryDescriptors[wrapper.nitMappingClassname]!
      ]
          .where((e) =>
              null !=
              (e.fieldName == 'id'
                  ? wrapper.modelId
                  : wrapper.foreignKeys[e.fieldName]))
          .map((d) => _getRepository(d)(
                d.fieldName == 'id'
                    ? wrapper.modelId
                    : wrapper.foreignKeys[d.fieldName],
              ));

  static StateProvider<T?> getModelProvider<T extends SerializableModel, K>(
    K key, [
    NitRepositoryDescriptor<T, K>? descriptor,
  ]) =>
      _getRepository<T, K>(
        descriptor ?? _defaultDescriptor<T>(),
      )(key);

  static AsyncNotifierFamilyProvider<SingleItemCustomProviderState<T>, int?,
          SingleItemCustomProviderConfig>
      getFetchProvider<T extends SerializableModel, K>(
    K key, [
    NitRepositoryDescriptor<T, K>? descriptor,
  ]) =>
          singleItemCustomProvider<T>()(
            SingleItemCustomProviderConfig(
              backendFilter: NitBackendFilter<K>.value(
                type: NitBackendFilterType.equals,
                fieldName: (descriptor ?? _defaultDescriptor<T>()).fieldName,
                fieldValue: key,
              ),
            ),
          );

  static StateProviderFamily<T?, K>
      _getRepository<T extends SerializableModel, K>(
    NitRepositoryDescriptor descriptor,
  ) =>
          // _repositories[descriptor] as StateProviderFamily<T?, K>;
          _repositories.containsKey(descriptor)
              ? _repositories[descriptor] as StateProviderFamily<T?, K>
              : _repositories[descriptor] = StateProvider.family<T?, K>(
                  (ref, key) => null,
                );
}
