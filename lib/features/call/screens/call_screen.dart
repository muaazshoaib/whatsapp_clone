import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/config/agora_config.dart';
import 'package:whatsapp_clone/features/call/controller/call_controller.dart';
import 'package:whatsapp_clone/models/call.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;

  const CallScreen({
    super.key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
  });

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  AgoraClient? client;

  String baseUrl =
      'https://flutter-whatsapp-clone-server-ee7a18bb2fff.herokuapp.com/';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );

    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : Stack(
              children: [
                AgoraVideoViewer(
                  client: client!,
                  layoutType: Layout.floating,
                  enableHostControls: true,
                ),
                AgoraVideoButtons(
                  client: client!,
                  addScreenSharing: false,
                  disconnectButtonChild: IconButton(
                    onPressed: () async {
                      await client!.engine.leaveChannel();
                      if (context.mounted) {
                        ref.read(callControllerProvider).endCall(
                              widget.call.callerId,
                              widget.call.receiverId,
                              context,
                            );
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.call_end,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
