import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  CategoryService categoryService = CategoryService();
  BrandService brandService = BrandService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropdown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropdown = <DropdownMenuItem<String>>[];
  String currentCategory;
  String currentBrand;
  List<String> selectedSizes = <String>[];

  @override
  void initState() {
    getCategories();
    //getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data['brand']),
                value: brands[i].data['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          'Add product',
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: grey.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 40.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: grey.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 40.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: grey.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 40.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter a product name with 10 characters maximum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: red,
                  fontSize: 12,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    } else if (value.length > 10) {
                      return 'Product name can\'t have more than 1o letters';
                    }
                  },
                ),
              ),
            ),

            // SELECT CATEGORY

            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Category: ',
                    style: TextStyle(color: red),
                  ),
                ),
                DropdownButton(
                  items: categoriesDropdown,
                  onChanged: changeSelectedCategory,
                  value: currentCategory,
                ),

                // SELECT BRAND

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Brand: ',
                    style: TextStyle(color: red),
                  ),
                ),
                DropdownButton(
                  items: brandsDropdown,
                  onChanged: changeSelectedBrand,
                  value: currentCategory,
                ),
              ],
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: productQuantityController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product quantity';
                    }
                  },
                ),
              ),
            ),

            Text('Available Sizes'),

            Row(
              children: <Widget>[
                Checkbox(value: selectedSizes.contains('S'), onChanged: (value) => changeSelectedSize('S'),),
                Text('S'),
                Checkbox(value: selectedSizes.contains('M'), onChanged: (value) => changeSelectedSize('M'),),
                Text('M'),
                Checkbox(value: selectedSizes.contains('L'), onChanged: (value) => changeSelectedSize('L'),),
                Text('L'),
                Checkbox(value: selectedSizes.contains('XL'), onChanged: (value) => changeSelectedSize('XL'),),
                Text('XL'),
                Checkbox(value: selectedSizes.contains('XXL'), onChanged: (value) => changeSelectedSize('XXL'),),
                Text('XXL'),
              ],
            ),

            Row(children: <Widget>[
              Checkbox(value: selectedSizes.contains('XS'), onChanged: (value) => changeSelectedSize('XS'),),
              Text('XS'),
            ],),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(),
            ),

            Row(
              children: <Widget>[
                Checkbox(value: selectedSizes.contains('28'), onChanged: (value) => changeSelectedSize('28'),),
                Text('28'),
                Checkbox(value: selectedSizes.contains('34'), onChanged: (value) => changeSelectedSize('34'),),
                Text('34'),
                Checkbox(value: selectedSizes.contains('36'), onChanged: (value) => changeSelectedSize('36'),),
                Text('36'),
                Checkbox(value: selectedSizes.contains('38'), onChanged: (value) => changeSelectedSize('38'),),
                Text('38'),
                Checkbox(value: selectedSizes.contains('40'), onChanged: (value) => changeSelectedSize('40'),),
                Text('40'),
              ],
            ),


            Row(
              children: <Widget>[
                Checkbox(value: selectedSizes.contains('25'), onChanged: (value) => changeSelectedSize('25'),),
                Text('25'),
                Checkbox(value: selectedSizes.contains('29'), onChanged: (value) => changeSelectedSize('29'),),
                Text('29'),
                Checkbox(value: selectedSizes.contains('37'), onChanged: (value) => changeSelectedSize('37'),),
                Text('37'),
                Checkbox(value: selectedSizes.contains('41'), onChanged: (value) => changeSelectedSize('41'),),
                Text('41'),
                Checkbox(value: selectedSizes.contains('42'), onChanged: (value) => changeSelectedSize('42'),),
                Text('42'),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlatButton(
                color: red,
                textColor: white,
                onPressed: () {},
                child: Text('add product'),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCategories() async {
    List<DocumentSnapshot> data = await categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropdown = getCategoriesDropdown();
      currentCategory = categories[0].data['category'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => currentCategory = selectedCategory);
  }

  getBrands() async {
    List<DocumentSnapshot> data = await brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropdown = getBrandsDropdown();
      currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    }else{
      setState(() {
        selectedSizes.add(size);
      });
    }
  }
}
