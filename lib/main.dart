import 'package:flutter/material.dart';
import 'confirmation.dart';
import 'package:intl/intl.dart'; 

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Sign Up';
    
    

    return MaterialApp(
       title: appTitle,
       
      theme: ThemeData(
        
        scaffoldBackgroundColor: Colors.white
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0), // Adds padding around the form
          child: MyCustomForm(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();

  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _dobController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0, // Adjusted width for a thicker border
                ),
              ),
              hintText: 'Enter your Username',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10), // Adds spacing between fields

          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0, // Adjusted width for a thicker border
                ),
              ),
              hintText: 'Enter your email address',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),

          TextFormField(
            controller: _dobController, // Connect the controller to the text field
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0, // Adjusted width for a thicker border
                ),
              ),
              hintText: 'Enter your date of birth',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  // Show the date picker when the user taps the calendar icon
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    // If the user selects a date, format and display it in the text field
                    _dobController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
                  }
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your date of birth';
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          TextFormField(
            obscureText: true, // Hides the password input
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0, // Adjusted width for a thicker border
                ),
              ),
              hintText: 'Enter your password',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 20), // Adds spacing before the submit button

          Center(
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmation(),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
