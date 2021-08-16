import 'package:flutter/material.dart';
import 'package:flutter_app/models/userApi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


dynamic product = 'Search product';
class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product page'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: TypeAheadField<User>(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: product,
              ),
            ),
            suggestionsCallback: UserApi.getUserSuggestions,
            itemBuilder: (context, User suggestion) {
              final user = suggestion;

              return ListTile(
                title: Text(user.name),
              );
            },
            noItemsFoundBuilder: (context) => Container(
              height: 100,
              child: Center(
                child: Text(
                  'No Users Found.',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            onSuggestionSelected: (User suggestion) {
              final user = suggestion;
              setState(() {
                product = '${user.name}';
              });
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('Selected user: ${user.name}'),
                ));
            },
          ),
        ),
      ),
    );
  }
}




class NetworkTypeAheadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: TypeAheadField<User>(
          hideSuggestionsOnKeyboardHide: false,
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: product,
            ),
          ),
          suggestionsCallback: UserApi.getUserSuggestions,
          itemBuilder: (context, User suggestion) {
            final user = suggestion;

            return ListTile(
              title: Text(user.name),
            );
          },
          noItemsFoundBuilder: (context) => Container(
            height: 100,
            child: Center(
              child: Text(
                'No Users Found.',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          onSuggestionSelected: (User suggestion) {
            final user = suggestion;

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Selected user: ${user.name}'),
              ));
          },
        ),
      ),
    ),
  );
}