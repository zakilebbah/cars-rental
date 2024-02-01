import 'package:car_renting/models/car.dart';
import 'package:car_renting/providers/carDetailProvider.dart';
import 'package:car_renting/utils/constants.dart';
import 'package:car_renting/utils/utilFunctions.dart';
import 'package:car_renting/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailsPage extends StatefulWidget {
  final Car? car;
  const CarDetailsPage({super.key, this.car});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _availability = availability[0];
  Car _car = Car();
  final _formKey = GlobalKey<FormState>();

  void _fillInCar() {
    _car = Car(
        // ignore: prefer_null_aware_operators
        id: widget.car != null ? widget.car!.id : null,
        make: _makeController.text,
        model: _modelController.text,
        location: _locationController.text,
        price: double.parse(_priceController.text),
        availability: _availability);
  }

  _addOrUpdateCar(CarDetailsProvider carDetailsProvider) async {
    try {
      if (_formKey.currentState!.validate()) {
        _fillInCar();
        await carDetailsProvider.addOrUpdateCar(_car);
        if (mounted) {
          Navigator.pop(context);
          MyFunct.showMessage(
              widget.car != null ? "Car updated!" : "Car added!", context);
        }
      }
    } catch (e) {
      if (mounted) {
        MyFunct.showErrorMessage(e.toString(), context);
      }
    }
  }

  _initCar() {
    if (widget.car != null) {
      _makeController.text = widget.car!.make ?? '';
      _modelController.text = widget.car!.model ?? '';
      _locationController.text = widget.car!.location ?? '';
      _priceController.text = widget.car!.price.toString();
      _availability = widget.car!.availability ?? '';
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CarDetailsProvider provider =
            Provider.of<CarDetailsProvider>(context, listen: false);
        provider.onAvailabilityClick(availability
            .indexWhere((element) => widget.car!.availability == element));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CarDetailsProvider provider =
            Provider.of<CarDetailsProvider>(context, listen: false);
        provider.initAvailability();
      });
    }
  }

  _deleteCar(CarDetailsProvider provider) async {
    try {
      _fillInCar();
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Do you want to delete this Car ?'),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await provider.deleteCar(_car);
                              if (mounted) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
    } catch (e) {
      if (mounted) MyFunct.showErrorMessage(e.toString(), context);
    }
  }

  @override
  void initState() {
    super.initState();
    _initCar();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: widget.car == null
                  ? const Text("Add Car")
                  : const Text("Edit Car"),
              backgroundColor: const Color.fromARGB(255, 0, 126, 230),
              foregroundColor: Colors.white,
            ),
            body: Consumer<CarDetailsProvider>(
                builder: (context, carDetailsProvider, child) {
              return Form(
                  key: _formKey,
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ToggleButtons(
                              onPressed: (int index) {
                                _availability = carDetailsProvider
                                    .onAvailabilityClick(index);
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
                              isSelected:
                                  carDetailsProvider.selectedAvailability,
                              children: [
                                Text(
                                  availability[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(availability[1],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              runAlignment: WrapAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(2),
                                  width: 150,
                                  child: TextFormField(
                                    controller: _makeController,
                                    validator: notEmpty,
                                    // onChanged: passwordValidation,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      labelText: 'Make',
                                      hintText: 'Enter make',
                                      errorMaxLines: 4,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    controller: _modelController,
                                    validator: notEmpty,
                                    // onChanged: passwordValidation,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      labelText: 'Model',
                                      hintText: 'Enter Model',
                                      errorMaxLines: 4,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _locationController,
                              validator: notEmpty,
                              // onChanged: passwordValidation,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                labelText: 'Location',
                                hintText: 'Enter Location',
                                errorMaxLines: 4,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: _priceController,
                                validator: notEmpty,
                                // onChanged: passwordValidation,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    labelText: 'Price',
                                    errorMaxLines: 4,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.attach_money_rounded),
                                    suffixText: "/ Day"),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.car != null
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              36, 16, 36, 16),
                                          backgroundColor: Colors.red,
                                          elevation: 0,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () {
                                          _deleteCar(carDetailsProvider);
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    : const SizedBox(),
                                widget.car != null
                                    ? const SizedBox(
                                        width: 12,
                                      )
                                    : const SizedBox(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        36, 16, 36, 16),
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 126, 230),
                                    elevation: 0,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    _addOrUpdateCar(carDetailsProvider);
                                  },
                                  child: carDetailsProvider.loading
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          widget.car == null
                                              ? "Add Car"
                                              : "Edit Car",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )));
            })));
  }
}
