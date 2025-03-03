import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  // Dummy credentials (replace with Firebase or API authentication)
  final String correctEmail = "test@example.com";
  final String correctPassword = "password123";

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email == correctEmail && password == correctPassword) {
      // Store login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Navigate to HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid email or password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return _buildDesktopLayout(context);
            } else if (constraints.maxWidth >= 600) {
              return _buildTabletLayout(context);
            } else {
              return _buildMobileLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const LoginTitle(),
                  if (errorMessage.isNotEmpty)
                    ErrorMessage(errorMessage: errorMessage),
                  const SizedBox(height: 20),
                  LoginTextField(
                    icon: Icons.email,
                    hint: "Enter the Email",
                    isPassword: false,
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  LoginTextField(
                    icon: Icons.lock,
                    hint: "Enter the Password",
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),
                  const ForgotPasswordButton(),
                  const SizedBox(height: 20),
                  LoginButton(onPressed: login),
                  const SizedBox(height: 15),
                  const SignUpText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                flex: 1,
                child: LoginHeaderImage(),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoginTitle(),
                      if (errorMessage.isNotEmpty)
                        ErrorMessage(errorMessage: errorMessage),
                      const SizedBox(height: 20),
                      LoginTextField(
                        icon: Icons.email,
                        hint: "Enter the Email",
                        isPassword: false,
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      LoginTextField(
                        icon: Icons.lock,
                        hint: "Enter the Password",
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 10),
                      const ForgotPasswordButton(),
                      const SizedBox(height: 20),
                      LoginButton(onPressed: login),
                      const SizedBox(height: 15),
                      const SignUpText(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                flex: 1,
                child: LoginHeaderImage(),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoginTitle(),
                      if (errorMessage.isNotEmpty)
                        ErrorMessage(errorMessage: errorMessage),
                      const SizedBox(height: 20),
                      LoginTextField(
                        icon: Icons.email,
                        hint: "Enter the Email",
                        isPassword: false,
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      LoginTextField(
                        icon: Icons.lock,
                        hint: "Enter the Password",
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 10),
                      const ForgotPasswordButton(),
                      const SizedBox(height: 20),
                      LoginButton(onPressed: login),
                      const SizedBox(height: 15),
                      const SignUpText(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Widgets

class LoginHeaderImage extends StatelessWidget {
  const LoginHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage('assets/login image.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String errorMessage;

  const ErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  const LoginTextField({
    super.key,
    required this.icon,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isVisible = !isPassword;

        return TextField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.blue),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't Have an Account? "),
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}