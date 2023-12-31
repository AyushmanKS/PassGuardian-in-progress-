import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passdiary/screens/login_screen.dart';
import 'dart:math';

import 'package:passdiary/screens/validation_screen.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final generatorController = TextEditingController();

// disposing controller
  @override
  void dispose() {
    generatorController.dispose();
    super.dispose();
  }

  // generate password function
  String generatePassword() {
    const length = 8;
    const lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
    const lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const special = '@#%^&*(%)._-~<>?/*={}"';

    String chars = '';
    chars += '$lettersLowercase$lettersUppercase$numbers$special';

    return List.generate(length, (index) {
      final indexRandom = Random().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.white, //const Color(0xff024576),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 10,
        // title: PassGuardian
        title: const Center(
          child: Text(
            'PassGuardian',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
          ),
        ),
        // Log-Out Button
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/101.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            // 'Password Generator'
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Random Password Generator',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            const SizedBox(height: 15),
            // Notice..........
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff4f6c8b),
                  border: Border.all(width: 3, color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Generates a random password with a combination of Lowercase Letters, Uppercase Letters, Digits and Special Characters.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            // Text Field
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: generatorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  // copy Button
                  suffixIcon: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      final copyPassword =
                          ClipboardData(text: generatorController.text);
                      Clipboard.setData(copyPassword);
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            // ElevatedButton: Generate Password
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final password = generatePassword();
                  generatorController.text = password;
                },
                child: const Text('Generate Password'),
              ),
            ),

            const SizedBox(height: 12),
            // Password validator/ save
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Password Generator button
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      // navigating to validation screen
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ValidationScreen()));
                      },
                      child: const Text(
                        "Password Validator",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                // Save button
                Center(
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
