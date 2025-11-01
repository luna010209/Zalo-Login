import 'package:zalo_flutter/zalo_flutter.dart';
import 'package:flutter/material.dart';

class ZaloLoginPage extends StatefulWidget {
  const ZaloLoginPage({super.key});

  @override
  State<ZaloLoginPage> createState() => _ZaloLoginPageState();
}

class _ZaloLoginPageState extends State<ZaloLoginPage> {
  String _status = 'Not logged in';
  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _userProfile;

  Future<void> _login() async {
    try {
      // Step 1: Login with Zalo (app or webview)
      final result = await ZaloFlutter.login();
      if (result == null) {
        setState(() => _status = 'Login canceled or failed');
        return;
      }

      _accessToken = result['data']['accessToken'];
      _refreshToken = result['data']['refreshToken'];

      print("ACCESS TOKEN: $_accessToken");

      // Step 2: Fetch user profile
      if (_accessToken != null) {
        final user = await ZaloFlutter.getUserProfile(accessToken: _accessToken!);
        setState(() {
          _userProfile = Map<String, dynamic>.from(user ?? {});
          print("USER PROFILE: $_userProfile");
          _status = 'Login successful 🎉';
        });
      }
    } catch (e) {
      setState(() => _status = 'Login failed: $e');
      print('❌ Zalo login error: $e');
    }
  }

  Future<void> _logout() async {
    await ZaloFlutter.logout();
    setState(() {
      _status = 'Logged out';
      _accessToken = null;
      _refreshToken = null;
      _userProfile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zalo Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login with Zalo'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
              const SizedBox(height: 20),
              if (_userProfile != null)
                Text(
                  'User: ${_userProfile!['name'] ?? 'Unknown'}\n'
                      'ID: ${_userProfile!['id'] ?? ''}',
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
