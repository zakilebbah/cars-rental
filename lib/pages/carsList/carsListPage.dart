import 'package:car_renting/models/car.dart';
import 'package:car_renting/pages/carDetail/CarPageDetail.dart';
import 'package:car_renting/providers/carListProvider.dart';
import 'package:car_renting/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsListPage extends StatefulWidget {
  const CarsListPage({super.key});

  @override
  State<CarsListPage> createState() => _CarsListPageState();
}

class _CarsListPageState extends State<CarsListPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  final TextStyle _valueStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  List<Car> _carsFilter(List<Car> cars, String searchOption, String searchTxt,
      String sortOption, List<bool> availability0) {
    if (searchOption != '') {
      cars = cars
          .where((e) => e
              .toJson()[searchOption]
              .toString()
              .toLowerCase()
              .contains(searchTxt))
          .toList();
    }

    if (sortOption == azOder) {
      cars.sort((a, b) => a
          .toJson()[searchOption]
          .toString()
          .toLowerCase()
          .compareTo(b.toJson()[searchOption].toString().toLowerCase()));
    } else if (sortOption == zaOder) {
      cars.sort((a, b) => a
          .toJson()[searchOption]
          .toString()
          .toLowerCase()
          .compareTo(b.toJson()[searchOption].toString().toLowerCase()));
      cars = cars.reversed.toList();
    } else if (sortOption == priceHigh) {
      cars.sort((a, b) => a.price!.compareTo(b.price!));
      cars = cars.reversed.toList();
    } else if (sortOption == priceLow) {
      cars.sort((a, b) => a.price!.compareTo(b.price!));
    }
    int index = availability0.indexWhere((element) => element == true);
    if (index >= 0) {
      cars =
          cars.where((car) => car.availability == availability[index]).toList();
    }
    return cars;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CarListProvider provider =
          Provider.of<CarListProvider>(context, listen: false);
      provider.getCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<CarListProvider>(
            builder: (context, carListProvider, child) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 0, 126, 230),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(52),
                          bottomRight: Radius.circular(52),
                        ),
                      ),
                      height: 65,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              PopupMenuButton(
                                onSelected: (c) {
                                  carListProvider.onSearchOptionChange(c);
                                  _searchController.clear();
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      carListProvider.searchOption,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                itemBuilder: (context) => carSearchOption
                                    .map((c) =>
                                        PopupMenuItem(value: c, child: Text(c)))
                                    .toList(),
                              ),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged: (value) => {
                                          carListProvider.onSearchChange(value)
                                        },
                                        decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.fromLTRB(8, 2, 8, 2),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusColor: Colors.white,
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            hintText: 'Search',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            )),
                                      )))
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ToggleButtons(
                          onPressed: (int index) {
                            carListProvider.onAvailabilityClick(index);
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor:
                              const Color.fromARGB(255, 0, 126, 230),
                          selectedColor: Colors.white,
                          fillColor: const Color.fromARGB(255, 0, 126, 230),
                          color: Colors.blue[400],
                          constraints: const BoxConstraints(
                            minHeight: 40.0,
                            minWidth: 80.0,
                          ),
                          isSelected: carListProvider.selectedAvailability,
                          children: [
                            Text(
                              availability[0],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(availability[1],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        PopupMenuButton(
                          onSelected: (c) {
                            carListProvider.onSortOptionChange(c);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                carListProvider.orderOption,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              )
                            ],
                          ),
                          itemBuilder: (context) => carSortOption
                              .map((c) =>
                                  PopupMenuItem(value: c, child: Text(c)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: carListProvider.cars,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator()),
                              );
                            }
                            List<Car>? carSnapshot = snapshot.data;

                            if (carSnapshot != null) {
                              carSnapshot = _carsFilter(
                                  carSnapshot,
                                  carListProvider.searchOption.toLowerCase(),
                                  carListProvider.searchTxt.toLowerCase(),
                                  carListProvider.orderOption,
                                  carListProvider.selectedAvailability);
                            } else if (carSnapshot!.isEmpty) {
                              return const Text("no data");
                            }

                            return ListView.builder(
                                itemCount: carSnapshot.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CarDetailsPage(
                                                    car: carSnapshot![index],
                                                  )),
                                        );
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.all(10),
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 12, 30, 12),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$${carSnapshot![index].price} / Day",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 0, 126, 230)),
                                                  ),
                                                  Text(
                                                    carSnapshot[index]
                                                        .availability!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                      color: carSnapshot[index]
                                                                  .availability ==
                                                              availability[0]
                                                          ? Colors.blue
                                                          : Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Make",
                                                    style: _titleStyle,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    carSnapshot[index].make!,
                                                    style: _valueStyle,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Model ",
                                                      style: _titleStyle),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    carSnapshot[index].model!,
                                                    style: _valueStyle,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Location ",
                                                      style: _titleStyle),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Flexible(
                                                      child: Text(
                                                    carSnapshot[index]
                                                        .location!,
                                                    style: _valueStyle,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                });
                            // } else {
                            //   return const Text("no data");
                            // }
                          }))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarDetailsPage()),
                      )
                    },
                child: const Icon(Icons.add)),
          );
        }));
  }
}
