import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/attachment_list.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/widget/add_attchment_button.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/widget/fullscreen_attachment_view.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/emoji/emoji_bubble.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/emoji/emoji_utils_extension.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/message_time.dart';
import 'package:nit_app/src/chats/UI/widget/message_bubbles/widgets/reply_indicator.dart';

import 'package:nit_app/src/chats/states/chat_ui_state/chat_ui_state.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';

part 'message_bubbles/personal_message_bubble.dart';
part 'message_bubbles/group_message_bubble.dart';
part 'attachment/widget/message_bubble_media_grid.dart';
part 'message_bubbles/widgets/read_indicator.dart';
part 'input/chat_input.dart';
part 'typing_indicator.dart';
part 'scroll_bottom_button.dart';
