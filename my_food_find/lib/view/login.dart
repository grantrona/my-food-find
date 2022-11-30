import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

/// Asks user for their login credentials (email and password). User is logged in using firebase authentication
class _LoginState extends State<Login> {
  // Text controllers used to store/read text from text input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _credentialsCorrect = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),

      // Container for Welcome message
      body: Center(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outlined,
                          size: 50,
                          color: Colors.blue,
                        ),
                        Text(
                          "ChatterBox",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 25.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              15.0,
                              15.0,
                            ))
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // Text inputs for password and email
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.person),
                              errorText: _credentialsCorrect ? null : "",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              errorText: _credentialsCorrect
                                  ? null
                                  : "Email or password incorrect",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(15)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                                onPressed: () async {
                                  // Check if user has provided correct credentials by passing the credentials to Auth()
                                  _credentialsCorrect = await Auth().signIn(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                      context);
                                  setState(() {});
                                },
                                child: Text(
                                  'Sign in',
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Register button for new users
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "New User? Register here!",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
