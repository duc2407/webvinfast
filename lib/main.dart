import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webvinfast/api/api_service.dart';
import 'package:webvinfast/providers/main_provider.dart';
import 'package:webvinfast/screens/user/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(Dio()),
        ),
        ChangeNotifierProxyProvider<ApiService, MainViewModel>(
          create: (context) =>
              MainViewModel(Provider.of<ApiService>(context, listen: false)),
          update: (context, apiService, loginProvider) =>
              MainViewModel(apiService),
        ),
      ],
      child: MaterialApp(
        title: "ECommerce Shopping",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 255, 17, 0),
          textTheme: GoogleFonts.interTextTheme(),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
        },
      ),
    );
  }
}
