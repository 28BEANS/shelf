import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_brand.dart';
import '../widgets/shelf_illustration.dart';
import '../widgets/shelf_text_field.dart';
import 'shell_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ShelfMobileRail(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const Row(
                children: [
                  ShelfLogoMark(compact: true),
                  SizedBox(width: AppSpacing.listItem),
                  Expanded(
                    child: Text(
                      'SHELF',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ShelfLocatorRail(),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR SPACE, REMEMBERED.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Know where\neverything belongs.',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Scan a workspace, confirm what Shelf finds, and retrieve anything in seconds.',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const ShelfIllustration(height: 150),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.listItem),
              HardShadowCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text('Sign in to open your shared spaces.'),
                    const SizedBox(height: AppSpacing.md),
                    ShelfTextField(
                      label: 'Email',
                      controller: _email,
                      hintText: 'name@organization.edu',
                      validator: _required,
                    ),
                    const SizedBox(height: AppSpacing.listItem),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      validator: _required,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: '••••••••',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PrimaryActionButton(
                      key: const Key('enter-shelf'),
                      label: 'Sign in',
                      onPressed: _enter,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Local-first • Your room data stays on device',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;

  void _enter() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const ShelfShell()));
  }
}
