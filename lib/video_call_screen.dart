import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:firebase_database/firebase_database.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference signalingRef;

  RTCPeerConnection? peerConnection;
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
 bool _isMuted = false;
  MediaStream? localStream;

  @override
  void initState() {
    super.initState();
    signalingRef = database.ref('signaling');
    initRenderers();
    startWebRTC();
  }

  Future<void> initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  Future<void> startWebRTC() async {
    localStream = await navigator.mediaDevices.getUserMedia({
      'video': true,
      'audio': true,
    });

    localRenderer.srcObject = localStream;

    peerConnection = await createPeerConnection({
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    });

    localStream!.getTracks().forEach((track) {
      peerConnection!.addTrack(track, localStream!);
    });

    peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      signalingRef.child('iceCandidates').set(candidate.toMap());
    };

    peerConnection!.onAddStream = (MediaStream stream) {
      setState(() {
        remoteRenderer.srcObject = stream;
      });
    };
  }

  Future<void> createOffer() async {
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    signalingRef.child('offer').set(offer.toMap());
  }

  Future<void> createAnswer() async {
    DataSnapshot snapshot = await signalingRef.child('offer').get();
    if (snapshot.exists) {
      RTCSessionDescription offer = RTCSessionDescription(
          snapshot.child('sdp').value.toString(),
          snapshot.child('type').value.toString());
      await peerConnection!.setRemoteDescription(offer);

      RTCSessionDescription answer = await peerConnection!.createAnswer();
      await peerConnection!.setLocalDescription(answer);
      signalingRef.child('answer').set(answer.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call')),
      body: Column(
        children: [
          Expanded(child: RTCVideoView(localRenderer, mirror: true)),
          Expanded(child: RTCVideoView(remoteRenderer)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: createOffer, child: const Text('Create Offer')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: createAnswer, child: const Text('Create Answer')),
              IconButton(
                icon: Icon(_isMuted ? Icons.mic_off : Icons.mic),
                onPressed: _toggleMute,
              ),
            ],
          ),
        ],
      ),
    );
  }

    void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      localStream!.getAudioTracks()[0].enabled = !_isMuted;
    });
  }

  @override
  void dispose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    super.dispose();
  }
}

