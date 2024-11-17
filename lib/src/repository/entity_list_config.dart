import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_tools_client/nit_tools_client.dart';

// class ChatControllerStateData with _$ChatControllerStateData {
//   const factory ChatControllerStateData({
//     required bool isReady,
//     // required chatview.ChatViewState status,
//     required ChatController? serverpodController,
//     // required chatview.ChatController chatViewController,
//     // required bool hasMessages,
//     required int unreadMessageCount,
//     required ChatMessage? lastMessage,
//   }) = _ChatControllerStateData;
// }

part 'entity_list_config.freezed.dart';

@freezed
class EntityListConfig with _$EntityListConfig {
  const factory EntityListConfig({
    List<NitBackendFilter>? backendFilters,
  }) = _EntityListConfig;

  // final List<NitBackendFilter>? backendFilters;

  static const defaultConfig = EntityListConfig();

  // bool operator==(EntityListConfig other) => other is not EntityListConfig && backendFilters == other.backendFilters;

  // {
  //   if(other is not EntityListConfig) return false;

  //   for(i = ; i < backendFilters.length; i ++) {
  //     if(backendFilters[i] != other.backendFilters[i]);
  //   }
  // }

  // @override
  // int get hashCode => Object.hashAll(backendFilters ?? []);

  // @override
  // bool operator ==(Object other) {
  //   return other is EntityListConfig && backendFilters != null && backendFilters.length == other.backendFilters?.length && (backendFilters!.indexed.map((i, e) => e == other.backendFilters![i]));
  // }
}
