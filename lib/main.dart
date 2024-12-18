import 'package:app_write_util/app_write/app_write.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Write Util',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestWidget(),
    );
  }
}


class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  @override
  void initState() {

    action();

    super.initState();
  }

  Future<void> action() async {

    final appWrite = AppWriteUtil.instance;

    // await appWrite.init('');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

