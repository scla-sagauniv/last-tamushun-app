import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/hooks/logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          leadingWidth: 110,
          leading: TextButton(
            child: const Text('＜ route_list'),
            onPressed: () => context.go('/route_list'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => context.go('/auth'),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  await logout(context);
                })
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/location-browsing'),
                  child: const Text('location_browsing'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/picture-browsing'),
                  child: const Text('picture_browsing'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/registration'),
                  child: const Text('registration'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/ar-gallery'),
                  child: const Text('ar-gallery'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/ar'),
                  child: const Text('ar'),
                ),
              ),
            ],
          ),
        ),
      );
}
