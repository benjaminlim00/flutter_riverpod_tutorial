import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/counter_page.dart';

abstract class WebsocketClient {
  Stream<int> getCounterStream([int start]);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      yield i++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

// final counterProvider = StateProvider.autoDispose((ref) => 0);
final counterProvider = StreamProvider.family<int, int>((ref, startInt) =>
    ref.watch(websocketClientProvider).getCounterStream(startInt));

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Counter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Go to Counter Page'),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const CounterPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
