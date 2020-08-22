import 'package:flutter/material.dart';
import 'package:music_archiecture/utils/constants.dart';
import 'package:music_archiecture/utils/strings.dart';

class SearchBar extends StatelessWidget {

  final Function onChanged;
  final controller;

  SearchBar({@required this.onChanged, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).primaryColor
        ),
        maxLength: 20,
        maxLines: 1,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clear();

              ///To alert the viewModel that the text is now empty
              onChanged(Strings.empty);
            },
          ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Constants.borderRadius), bottomRight: Radius.circular(Constants.borderRadius))
            ),
            fillColor: Theme.of(context).accentColor,
            filled: true,
            hintText: Strings.searchHint,
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColor
            )
        ),
        onChanged: onChanged,
      ),
    );
  }
}
