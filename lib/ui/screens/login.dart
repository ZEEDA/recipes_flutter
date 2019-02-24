import 'package:flutter/material.dart';

import 'package:recipes_app/ui/widgets/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:    
    BoxDecoration _buildBackground(){
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.jpeg'),
          fit: BoxFit.cover,
        ),
      );
    }
    Text _buildText(_stringText) {
      return Text(
        _stringText,
        // style: TextStyle(
        //   fontFamily: 'Merriweather',
        //   fontSize: 40.0,
        //   color: const Color(0xFF807A6B),
        // ),
        style: Theme.of(context).textTheme.headline,
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText('Recipes'),
              
              // Space between "Recipes" and the button:
              SizedBox(height: 50.0),
              // Passing function callback as constructor argument:              
              GoogleSignInButton(
                onPressed: () => 
                  // We replace the current page.
                  // After navigating to the replacement, it's not possible
                  // to go back to the previus screen:
                  Navigator.of(context).pushReplacementNamed('/')
              ),
            ],
          ),
        ),
      )
    );
  }
}