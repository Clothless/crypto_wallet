import 'package:crypto_wallet/screens/control_screen.dart';
import 'package:crypto_wallet/screens/create_password_screen.dart';
import 'package:crypto_wallet/screens/first_screen.dart';
import 'package:crypto_wallet/screens/home_screen.dart';
import 'package:crypto_wallet/screens/reminder_set_screen.dart';
import 'package:crypto_wallet/screens/secure_your_wallet_screen.dart';
import 'package:crypto_wallet/services/rpc_service.dart';
import 'package:crypto_wallet/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/control',
      builder: (context, state) => ControlScreen(),
    ),
    GoRoute(
      path: '/first',
      builder: (context, state) => FirstScreen(),
    ),
    GoRoute(
      path: '/create-password',
      builder: (context, state) => CreatePasswordScreen(),
    ),
    GoRoute(
      path: '/secure-your-wallet',
      builder: (context, state) => SecureYourWalletScreen(),
    ),
    GoRoute(
      path: '/reminder-set',
      builder: (context, state) => ReminderSetScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

void test() async {
  final x = await WalletService().createWallet();
  print('x: $x');
}

void connect() async {
  final x = await RpcService().connectToRPC();
  print('x: $x');
}

void walletAddress() async {
  final x = await RpcService().getWalletBalance();
  print('x: $x');
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    walletAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
