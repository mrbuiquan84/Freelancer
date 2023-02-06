import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_theme.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/bloc/auth_repo.dart';
import 'package:freelancer/modules/auth/bloc/auth_state.dart';
import 'package:freelancer/modules/bloc/app_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/bloc/app_state.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/ui/load_screen.dart';
import 'package:freelancer/utils/ui/show_hide_statusbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isShowIntro = true;
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    hideStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => AppRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            var authRepo = context.read<AuthRepo>();
            var appRepo = context.read<AppRepo>();
            return AuthBloc(
              authRepo: authRepo,
              appRepo: appRepo,
            );
          }),
          BlocProvider(create: (context) {
            var appRepo = context.read<AppRepo>();
            return AppBloc(appRepo);
          }),
        ],
        child: MaterialApp(
          title: 'Freelancer',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.themeData,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocBuilder<AppBloc, AppState>(
              builder: (_, appState) {
                if (appState is AppLoadDoneState) {
                  return BlocListener<AuthBloc, AuthState>(
                    // buildWhen: (_, state) => state is! AuthUnknownState,
                    listener: (context, authState) {
                      if (authState is AuthenticatedState) {
                        showStatusBar();
                        AppRouter.replaceAllWithPage(
                          context,
                          AppPages.home,
                          navigatorState: navigator,
                        );
                        _isShowIntro = false;
                      } else if (authState is UnAuthenticatedState) {
                        hideStatusBar();
                        AppRouter.replaceAllWithPage(
                          context,
                          _isShowIntro ? AppPages.intro : AppPages.waiting,
                          navigatorState: navigator,
                        );
                        _isShowIntro = false;
                        // if (_isShowIntro) {
                        //   _isShowIntro = false;
                        //   return const IntroPage();
                        // }
                        // else {
                        //   return const WaittingScreen();
                        // }
                      }
                      // return const LoadingScreen();
                    },
                    child: child!,
                  );
                } else if (appState is AppErrorState) {
                  var appBloc = context.read<AppBloc>();
                  return _PreLoadErrorScreen(
                    error: appState.error,
                    onPressed: () {
                      appBloc.preLoad();
                    },
                  );
                }
                return child!;
              },
            );
          },
          home: const LoadingScreen(),
        ),
      ),
    );
  }
}

class _PreLoadErrorScreen extends StatelessWidget {
  const _PreLoadErrorScreen({
    Key? key,
    this.error,
    this.onPressed,
  }) : super(key: key);
  final String? error;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: ErrorActionWidget(
          error: error,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
