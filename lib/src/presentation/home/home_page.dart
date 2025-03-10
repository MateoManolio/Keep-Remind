import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/data_state/data_status.dart';
import '../../core/utils.dart';
import '../controllers/home_controller.dart';
import '../menu/menu_page.dart';
import '../send/send_page.dart';
import 'widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.homeController});

  static const routeName = '/';
  final HomeController homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Utils.mediaHeight(context) * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Keep and Remind',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      context.go(MenuPage.routeName);
                    },
                    icon: const Icon(Icons.login),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Utils.mediaHeight(context) * 0.01,
            ),
            SizedBox(
              width: Utils.mediaWidth(context) * 0.9,
              height: Utils.mediaHeight(context) * 0.7,
              child: CustomTextField(
                controller: _textController,
                label: "What are you thinking?",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: Utils.mediaWidth(context) * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    processing = true;
                  });
                  final notes = await widget.homeController
                      .generateNotes(_textController.text);
                  if (mounted) {
                    setState(() {
                      processing = false;
                    });
                    if (notes.status == DataStatus.success) {
                      context.push(SendPage.routeName, extra: notes.data);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(notes.error ?? 'Error'),
                        ),
                      );
                    }
                  }
                },
                child: processing
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator(),
                      )
                    : const Text('Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
