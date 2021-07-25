import 'package:mjcoffee/helpers/constants.dart';
import 'package:mjcoffee/helpers/is_debug.dart';
import 'package:mjcoffee/models/auth0_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatService {
  static final ChatService instance = ChatService._internal();
  factory ChatService() => instance;
  ChatService._internal();

  final StreamChatClient client = StreamChatClient(
    STREAM_API_KEY,
    logLevel: isInDebugMode ? Level.INFO : Level.OFF,
  );

  Future<Auth0User> connectUser(Auth0User? user) async {
    if (user == null) {
      throw Exception('User was not received');
    }
    await client.connectUser(
      User(
        id: user.id,
        extraData: {
          'image': user.picture,
          'name': user.name,
        },
      ),
      // To be replaced with PRODUCTION TOKEN for user
      client.devToken(user.id).rawValue,
    );
    return user;
  }
}
