import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping/core/components/product_card.dart';
import 'package:shopping/core/services/future_service.dart';

import 'home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _productPath = "https://fakestoreapi.com/products";
  late Future<List<Product>> futureProduct;

  final String searchTitle = "Search";

  @override
  void initState() {
    super.initState();
    futureProduct = FutureService().getHttpProduct(_productPath);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBar(width),
      body:  FutureBuilder<List<Product>>(
            future: futureProduct,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.none:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return Column(children: [
                    SizedBox(
                      height: height / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:  4,
                        itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                height:200,
                                width:  MediaQuery.of(context).size.width * 0.6,
                                color: Colors.blue,
                                child: Center(child: Text(snapshot.data![index].category.toString(),style: const TextStyle(color: Colors.white, fontSize: 16.0),)),
                              ),
                            );
                          }),
                          ),
                      SizedBox(
                        height: height / 1.8,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => ProductCard(
                              imgUrl: snapshot.data![index].image.toString(),
                              title: snapshot.data![index].title.toString(),
                              price: snapshot.data![index].price.toString()),
                        ),
                      ),
                    ]);
                  } else {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                case ConnectionState.waiting:
                  Logger().e(snapshot.data);
                  return const Center(child: CircularProgressIndicator());
                default:
                  return Lottie.network(
                      "https://assets5.lottiefiles.com/temp/lf20_dzWAyu.json");
              }
            }),
    );
  }

  AppBar buildAppBar(double width) {
    double paddingLR = width / 4;
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(left: paddingLR, right: paddingLR),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.amber,
            ),
            width: width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  searchTitle,
                  style: const TextStyle(color: Colors.black),
                ),
                const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
