import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final authProvider =
      StateNotifierProvider<AuthNotifier, AuthenticationState>((ref) {
    return AuthNotifier();
  });

  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (state.user != null) {
              checkUser(state.user);
            } else {
              const SizedBox.shrink();
            }
          }),
        ],
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: context.padding.normal,
                  child: firebase.LoginView(
                    action: firebase.AuthAction.signIn,
                    providers: firebase.FirebaseUIAuth.providersFor(
                      FirebaseAuth.instance.app,
                    ),
                  ),
                ),
                if (ref.watch(authProvider).isRedirect)
                  TextButton(
                    onPressed: () {},
                    child: const Text('Continue To App'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
