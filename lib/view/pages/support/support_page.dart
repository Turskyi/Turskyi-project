import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/presenter/support_form_presenter.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/routes/app_route.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SupportFormPresenter>(
      create: (_) => SupportFormPresenter(),
      child: Scaffold(
        backgroundColor: Configs.of(context).colors.background,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.of(context).popUntil(
                ModalRoute.withName(AppRoute.home.path),
              ),
              borderRadius: BorderRadius.circular(100),
              child: ClipOval(
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    '${Configs.of(context).configs.imageAssents}logo.png',
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Developer Turskyi Support',
            style: TextStyle(
              color: Colors.white,
              fontSize: TextTheme.of(context).headlineLarge?.fontSize,
            ),
          ),
          elevation: Dimens.noElevation,
          backgroundColor: Colors.transparent,
          toolbarHeight: Dimens.toolbarHeight,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Consumer<SupportFormPresenter>(
              builder: (
                BuildContext context,
                SupportFormPresenter presenter,
                _,
              ) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          presenter.updateFormData('name', value);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Your Email Address',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          presenter.updateFormData('email', value);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        // White text color
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          labelStyle: TextStyle(color: Colors.white),
                          // White label text
                          hintStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        maxLines: 5,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          presenter.updateFormData('message', value);
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: presenter.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await presenter.sendSupportEmail();
                                  if (presenter.isSuccess && context.mounted) {
                                    presenter.resetForm();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Email sent successfully!',
                                        ),
                                      ),
                                    );
                                  } else if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          presenter.errorMessage.isNotEmpty
                                              ? presenter.errorMessage
                                              : 'Failed to send email.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                        child: presenter.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Send'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
