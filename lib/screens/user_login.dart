import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amateurs/project/routes/app_route_constants.dart';
import 'package:amateurs/screens/user_main.dart';

class UserLogin extends StatelessWidget {
  final String initialRoute;

  const UserLogin({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: initialRoute,
      routes: {
        MyAppRouteConstants.UserLoginRouteName: (context) =>
            const LoginScreen(),
        MyAppRouteConstants.UserMainRouteName: (context) => const UserMain(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  Future<void> loginUser() async {
    try {
      final authResponse = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final accessToken = authResponse.session?.accessToken;

      if (accessToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken); // Save session
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful!'),
      ));

      context.goNamed(MyAppRouteConstants.UserMainRouteName);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 254, 244),
        actions: [
          IconButton(
            onPressed: () {},
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Color(0xFF70AC4B), Color(0xF72E8231)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Image.asset(
                "assets/icons/hugeicons_leaf-01.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 242, 254, 244),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User\nLogin.',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Color(0xFF70AC4B), Color(0xF72E8231)],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome back! Please enter your credentials to login.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.firaCode(
                    color: const Color.fromARGB(153, 37, 35, 35),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: const Color(0xFFE8FFDB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 109, 109)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 109, 109), width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: const Color(0xFFE8FFDB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 109, 109), width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .pushNamed(MyAppRouteConstants.UserSignupRouteName);
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Color(0xFF70AC4B), Color(0xF72E8231)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          "\t"
                          "Sign Up",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Switch to ",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "Factory User",
                            style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF70AC4B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensures the button adjusts to the content size
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width:
                                190), // Adds some spacing between text and icon
                        const Icon(
                          Icons.arrow_forward_sharp,
                          size: 30, // Adds a right arrow icon
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
