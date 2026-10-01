import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/theme/app_colors.dart';

class FiltersWidgets extends StatefulWidget {
  const FiltersWidgets({
    super.key,
    required this.onSearch,
    required this.onCheckBox,
    required this.onRadioSelected,
    required this.onSwitchSelected,
    required this.onCategoryChanged,
  });

  final Function onSearch;
  final Function onCheckBox;
  final Function onRadioSelected;
  final Function onSwitchSelected;
  final Function onCategoryChanged;

  @override
  State<FiltersWidgets> createState() => _FiltersWidgetsState();
}

enum Options { AtoZ, ZtoA, none }

bool visibilityFilters = false;

List categories = ['All', ...MockData.products.map((v) => v.category).toSet()];
String? selectedCategory; // =categories.first ;
// final _formKey = GlobalKey<FormState>();

class _FiltersWidgetsState extends State<FiltersWidgets> {
  TextEditingController controller = TextEditingController();
  bool? checked = false;
  Options? radioSelected = Options.none;
  bool switchSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 5,
          children: [
            Expanded(child: _searchBar(context)),
            IconButton(
              onPressed: () {
                setState(() {
                  visibilityFilters = !visibilityFilters;
                  print(visibilityFilters);
                });
              },
              icon: visibilityFilters? Icon(Icons.close):Icon(Icons.menu),
            ),
          ],
        ),
        if (visibilityFilters) ...[_checkers(), _radioFilter(), _dropDown()],
        // ElevatedButton(
        //   // onPressed: () {
        //   //   if (_formKey.currentState!.validate()) {
        //   //     print('API Call');
        //   //   }
        //   },
        //   child: Text('Check'),
        // ),
      ],
    );
  }

  Widget _checkers() {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('A to Z'),

                Checkbox(
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      checked = value ?? false;
                    });

                    widget.onCheckBox(value);
                  },
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    'Less Than 100' /*overflow: TextOverflow.ellipsis,*/,
                  ),
                ),
                Switch(
                  value: switchSelected,
                  onChanged: (e) => {
                    setState(() {
                      if (!e) {
                        restFilters();
                      }
                      switchSelected = !switchSelected;
                    }),
                    widget.onSwitchSelected(e),
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropDown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedCategory,
          hint: Text('Select Category'),
          borderRadius: BorderRadius.circular(10),
          iconEnabledColor: Colors.green,
          dropdownColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10),
          style: TextStyle(color: AppColors.primary),
          items: [
            ...categories.map((category) {
              return DropdownMenuItem(value: category, child: Text(category));
            }),
          ],
          onChanged: (value) {
            setState(() {
              restFilters();
              selectedCategory = value.toString();
              widget.onCategoryChanged.call(value);
            });
          },
        ),
      ),
    );
  }

  void restFilters() {
    radioSelected = Options.none;
    checked = false;
    controller.clear();
    selectedCategory = 'All';
  }

  Widget _radioFilter() {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio<Options>(
                  value: Options.none,
                  groupValue: radioSelected,
                  onChanged: (Options? v) {
                    setState(() {
                      radioSelected = v;
                    });

                    widget.onRadioSelected.call(v);
                  },
                ),
                Text('No Filter'),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Radio<Options>(
                  value: Options.AtoZ,
                  groupValue: radioSelected,
                  onChanged: (Options? v) {
                    setState(() {
                      radioSelected = v;
                    });

                    widget.onRadioSelected.call(v);
                  },
                ),
                Text('A to Z'),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Radio<Options>(
                  value: Options.ZtoA,
                  groupValue: radioSelected,
                  onChanged: (Options? v) {
                    setState(() {
                      radioSelected = v;
                    });

                    widget.onRadioSelected.call(v);
                  },
                ),
                Text('Z to A'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator: (value) {
      //   if (value == null || value.trim().isEmpty) {
      //     return 'Plaes entar a value';
      //   }
      //   return null;
      // },
      onChanged: (value) {
        widget.onSearch.call(value);
        setState(() {
          if (value == '') {
            restFilters();
          }
        });
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
