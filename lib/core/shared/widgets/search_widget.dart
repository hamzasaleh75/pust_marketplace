import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({
    super.key,
    required this.list,
    required this.onSearch,
  });
  final List<MockProduct> list;
  final Function(List<MockProduct>) onSearch;

  @override
  State<CustomSearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<CustomSearchWidget> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: (value) {
      //   if (value == null || value.trim().isEmpty) {
      //     return 'Plaes entar a value';
      //   }
      //   return null;
      // },
      onChanged: (value) {
        var result = widget.list
            .where(
              (element) =>
                  element.title.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
        widget.onSearch(result);
      },

      decoration: InputDecoration(
        hint: Text('Search'),
        label: Text('Search'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        prefixIcon: Icon(Icons.search),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
