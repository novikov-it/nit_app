import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

@freezed
class EntityListConfig<Entity extends SerializableModel> {
  final NitBackendFilter? backendFilter;
  final int? pageSize;
  final Function(List<ObjectWrapper>)? customUpdatesListener;
  final int Function(Entity a, Entity b)? updatesSortingMethod;

  const EntityListConfig({
    this.backendFilter,
    this.pageSize,
    this.customUpdatesListener,
    this.updatesSortingMethod,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityListConfig<Entity> &&
          runtimeType == other.runtimeType &&
          backendFilter == other.backendFilter &&
          pageSize == other.pageSize &&
          customUpdatesListener == other.customUpdatesListener &&
          updatesSortingMethod == other.updatesSortingMethod;

  @override
  int get hashCode =>
      backendFilter.hashCode ^
      pageSize.hashCode ^
      customUpdatesListener.hashCode ^
      updatesSortingMethod.hashCode;

  EntityListConfig<Entity> copyWith({
    NitBackendFilter? backendFilter,
    int? pageSize,
    Function(List<ObjectWrapper>)? customUpdatesListener,
    int Function(Entity a, Entity b)? updatesSortingMethod,
  }) {
    return EntityListConfig<Entity>(
      backendFilter: backendFilter ?? this.backendFilter,
      pageSize: pageSize ?? this.pageSize,
      customUpdatesListener:
          customUpdatesListener ?? this.customUpdatesListener,
      updatesSortingMethod: updatesSortingMethod ?? this.updatesSortingMethod,
    );
  }
}
