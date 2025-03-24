// export 'descriptor/repository_descriptor.dart';
// export 'state/nit_repository_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class NitRepository {
  static final Map<NitRepositoryDescriptor,
      StateProviderFamily<dynamic, dynamic>> _repositories = {};
  static final Map<String, List<NitRepositoryDescriptor>>
      _customRepositoryDescriptors = {};
  static final Map<String, List<Function(int)>> _updateListeners = {};

  static final Map<String, NitRepositoryDescriptor> _defaultDescriptors = {};

  static ensureDefaultDescriptor<T extends SerializableModel>() {
    _defaultDescriptor<T>();
  }

  static NitRepositoryDescriptor<T, int>
      _defaultDescriptor<T extends SerializableModel>() {
    final className = T.toString();

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

  static addRepositoryDescriptor<T extends SerializableModel, K>(
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
  }

  static addUpdatesListener<T extends SerializableModel>(
    Function(
      int id,
    ) listener,
  ) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[T.toString()] == null) {
      _updateListeners[T.toString()] = [];
    }
    _updateListeners[T.toString()]!.add(listener);
  }

  static removeUpdatesListener<T>(
      Function(
        int id,
      ) listener) {
    // TODO: Изменить, toString() не работает на Web release из-за minification
    if (_updateListeners[T.toString()] != null) {
      _updateListeners[T.toString()]!.remove(listener);
    }
  }

  static updateListeningStates({
    required String className,
    required int modelId,
  }) {
    debugPrint(
      'Updating Listening State. Active listeners: ${_updateListeners.keys}. Updated id - $modelId for class $className',
    );
    for (var listener in _updateListeners[className] ?? []) {
      listener(
        modelId,
      );
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
              backendFilters: [
                NitBackendFilter(
                  fieldName: (descriptor ?? _defaultDescriptor<T>()).fieldName,
                  equalsTo: key.toString(),
                )
              ],
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
