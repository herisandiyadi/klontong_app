import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router.dart';
import 'core/theme.dart';
import 'injection/injection.dart';
import 'domain/usecases/sample_usecase.dart';
import 'presentation/bloc/product_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ProductBloc>(create: (_) => sl<ProductBloc>())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Klontong App',
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
