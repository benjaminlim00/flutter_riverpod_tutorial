import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/main.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  // if the value is above 5, we show a modal
  void _showModal(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Warning'),
          content: const Text('The value is above 5!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get value from riverpod
    final AsyncValue<int> counterValue = ref.watch(counterProvider(1000));

    // ref.listen<int>(counterProvider, (_, next) {
    //   if (next > 5) {
    //     _showModal(context);
    //   }
    // });

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Counter Page'),
          leading: CupertinoButton(
            padding: const EdgeInsets.all(10),
            child: const Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(10),
            child: const Text('Reset'),
            onPressed: () {
              // the difference between refresh and invalidate is that
              // invalidate will not rebuild the widget if the value is the same
              ref.invalidate(counterProvider);
            },
          ),
        ),
        child: Scaffold(
          body: Center(
            child: Text(
              counterValue
                  .when(
                      data: (int value) => value,
                      error: (Object e, _) => e,
                      loading: () => 0)
                  .toString(),
              style: const TextStyle(fontSize: 100),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: () {
          //     //update value to riverpod
          //     ref.read(counterProvider.notifier).state++;
          //   },
          // ),
        ));
  }
}
