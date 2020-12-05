import 'package:ecommerce_user/screens/payment.dart';
import 'package:ecommerce_user/services/addressService.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController _name = TextEditingController();
  TextEditingController _doorNo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _pinCode = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddressService addressService = AddressService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Address Details"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Fill your address details'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(hintText: 'Buyer name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the buyer name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _doorNo,
                  decoration: InputDecoration(
                    hintText: 'Door Number',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the door number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _address,
                  decoration: InputDecoration(
                    hintText: 'Full Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the complete address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _landmark,
                  decoration: InputDecoration(
                    hintText: 'Landmark',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the Landmark';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _pinCode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Pin code',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the pin code';
                    } else if (value.length == 6) {
                      return 'Please enter valid pin code';
                    }
                    return null;
                  },
                ),
              ),
              FlatButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                child: Text('Proceed'),
                onPressed: () {
                  validateAndUpload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_name != null &&
          _doorNo != null &&
          _address != null &&
          _landmark != null &&
          _pinCode != null) {
        addressService.uploadProduct({
          "name": _name.text,
          "doorNo": _doorNo.text,
          "address": _address.text,
          "landmark": _landmark.text,
          "pinCode": _pinCode.text,
        });
        _formKey.currentState.reset();
        setState(() => isLoading = false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Payment()));
      } else {
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }
}
