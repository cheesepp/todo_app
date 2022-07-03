import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test/bloc/switch_bloc/bloc/switch_bloc.dart';
import 'package:test/screens/tabs_screen.dart';
import 'package:test/services/app_theme.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import 'package:test/screens/pending_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/services/app_router.dart';
import 'models/task.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
      () => runApp(MyApp(
            appRouter: AppRouter(),
          )),
      storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc())
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
