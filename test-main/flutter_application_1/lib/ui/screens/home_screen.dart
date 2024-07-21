import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_sourec/products_data_source.dart';
import 'package:flutter_application_1/ui/widgets/error_widget.dart';
import 'package:flutter_application_1/ui/widgets/loading_widget.dart';
import 'package:flutter_application_1/ui/widgets/product_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (ProductsDataSource.myList.isEmpty) {
      ProductsDataSource.getProductsData().then((value) {
        setState(() {});
        if (value) {
          print('data is retrieved successfully');
        } else {
          print('errorrrrrrrrrrrrrrrrrrrrrrr');
        }
      });
    } else {
      print('data is already retrieved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductsDataSource.isLoading
          ? const LoadingWidget()
          : ProductsDataSource.isError
              ? MyErrorWidget(
                  errorMsg: ProductsDataSource.errorMessage,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                  ),
                  itemCount: ProductsDataSource.myList.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      index: index,
                    );
                  },
                ),
    );
  }
}

