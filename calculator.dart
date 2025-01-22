import 'dart:async';

import 'package:calculator1/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Map<String, bool> buttonStatus = {};
  void handleTap(String text) {
    if (text == "+/-") {
      Provider.of<CalculatorProvider>(context, listen: false).toggleSign();
    } else {
      setState(() {
        buttonStatus[text] = true;
      });
      Provider.of<CalculatorProvider>(context, listen: false).setValue(text);
      Timer(const Duration(milliseconds: 150), () {
        setState(() {
          buttonStatus[text] = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(115, 0, 0, 0),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "CALCULATOR",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12), // Add padding
                    child: FittedBox(
                      fit: BoxFit
                          .scaleDown, // Scale text to fit within its bounds
                      child: Text(
                        provider.displayText,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize:
                              100, // Original font size, scaled dynamically
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Ensure no overflow; add ellipsis for long text
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(Colors.grey[400]!, "AC", Colors.black87),
                    Button(Colors.grey[400]!, "+/-", Colors.black87),
                    Button(Colors.grey[400]!, "%", Colors.black87),
                    Button(Colors.amber[800]!, "/", Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(Colors.grey[800]!, "7", Colors.white),
                    Button(Colors.grey[800]!, "8", Colors.white),
                    Button(Colors.grey[800]!, "9", Colors.white),
                    Button(Colors.amber[800]!, "x", Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(Colors.grey[800]!, "4", Colors.white),
                    Button(Colors.grey[800]!, "5", Colors.white),
                    Button(Colors.grey[800]!, "6", Colors.white),
                    Button(Colors.amber[800]!, "-", Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(Colors.grey[800]!, "1", Colors.white),
                    Button(Colors.grey[800]!, "2", Colors.white),
                    Button(Colors.grey[800]!, "3", Colors.white),
                    Button(Colors.amber[800]!, "+", Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800]!,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width /
                              5.5, // Adjust width
                          vertical: 8, // Keep height consistent
                        ),
                      ),
                      onPressed: () => Provider.of<CalculatorProvider>(context,
                              listen: false)
                          .setValue("0"),
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Button(Colors.grey[800]!, ".", Colors.white),
                    Button(Colors.grey[800]!, "=", Colors.white),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget Button(Color btnColor, String btntext, Color textColor) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final buttonSize = screenWidth / 5.5; // Calculate button size dynamically
    bool isChange = buttonStatus[btntext] ?? false;

    return GestureDetector(
      onTap: () => handleTap(btntext),
      child: Container(
        height: buttonSize, // Use dynamic size
        width: buttonSize, // Use dynamic size
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChange ? Colors.white38 : btnColor,
        ),
        child: Center(
          child: Text(
            btntext,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
