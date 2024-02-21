import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  chooseImages() async {
    final XFile? gallery = await picker.pickImage(source: ImageSource.gallery);
    if (gallery != null) {
      setState(() {
        image = File(gallery.path);
      });
    }
  }

  captureImages() async {
    final XFile? camera = await picker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      setState(() {
        image = File(camera.path);
      });
    }
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
          children: [
            image != null
                ? Image.file(image!)
                : const Icon(
                    Icons.image,
                    size: 100,
                  ),
            ElevatedButton(
                onPressed: () {
                  chooseImages();
                },
                onLongPress: () {
                  captureImages();
                },
                child: const Text("Capture"))
          ],
        ),
      ),
    );
  }
}
