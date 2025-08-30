import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NitAlerts {
  static String? _alertsChatId;
  static String? _alertsToken;
  static String? _alertsMessageThreadId;

  /// Инициализация из .env
  static Future<void> init() async {
    try {
      await dotenv.load();

      _alertsChatId = dotenv.maybeGet('NIT_ALERTS_CHAT_ID');
      _alertsToken = dotenv.maybeGet('NIT_ALERTS_TOKEN');
      _alertsMessageThreadId = dotenv.maybeGet('NIT_ALERTS_MESSAGE_THREAD_ID');

      if (_alertsChatId == null || _alertsToken == null) {
        debugPrint(
          '⚠️ TelegramAlerts: ошибка инициализации из .env Chat ID $_alertsChatId или Token $_alertsToken',
        );
      }
    } catch (e) {
      debugPrint('⚠️ TelegramAlerts: Ошибка загрузки .env: $e');
    }
  }

  /// Отправка уведомления
  static Future<void> sendAlert({
    required String message,
  }) async {
    if (_alertsChatId == null || _alertsToken == null) {
      // debugPrint(
      //     '⚠️ TelegramAlerts: Не настроен токен/чат, сообщение не отправлено.');
      return;
    }

    await _sendMessage(
      message: message,
      chatId: _alertsChatId!,
      token: _alertsToken!,
      messageThreadId: _alertsMessageThreadId,
    );
  }

  static Future<void> _sendMessage({
    required String message,
    required String chatId,
    required String token,
    String? messageThreadId,
  }) async {
    try {
      final url = Uri.parse("https://api.telegram.org/bot$token/sendMessage");

      final body = {
        "chat_id": chatId,
        "text": message,
        if (messageThreadId != null) "message_thread_id": messageThreadId,
      };

      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode != 200) {
        debugPrint(
            "⚠️ TelegramAlerts: Ошибка ответа ${res.statusCode}: ${res.body}");
      }
    } catch (e) {
      debugPrint("⚠️ TelegramAlerts: Exception при отправке: $e");
    }
  }
}
