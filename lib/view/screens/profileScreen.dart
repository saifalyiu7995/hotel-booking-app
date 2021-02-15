import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/city_model.dart';
import 'package:hotel_booking_app/models/imageUpload_model.dart';
import 'package:hotel_booking_app/models/state_model.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/widgets/roundButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_session/flutter_session.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController address = new TextEditingController();

  var dateMask = new MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

  String dropdownValue = 'Passport';

  int _selectedId;
  String _selectedCountryName;

  int _selectedZoneId;
  String _selectedZoneName;

  int _selectedCityId;
  String _selectedCityName;

  Future<StateModel> futureZOne;
  Future<Cities> futureCity;

  ImagePicker _picker = ImagePicker();
  PickedFile _image;
  String base64Image;
  String imagePath, userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePath = "";
    getUserId();
  }

  Future<ImageUploadModel> _imgFromCamera() async {
    final image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      base64Image = base64Encode(File(image.path).readAsBytesSync());
      _image = image;
      imagePath = _image.path;
      print(_image.path);
    });

    var uri = Uri.parse(
        'http://sub72.protegeglobal.com/hms/api/account/upload_files');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath("id_upload", image.path));
    var response = await request.send();
    print(response.statusCode);
  }

  Future<void> _handleCountry() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Select Country',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          message: Text(
            'Please select your Country.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            FutureBuilder(
                future: getCountry(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 180,
                      child: CupertinoPicker(
                        magnification: 1,
                        itemExtent: 70,
                        onSelectedItemChanged: (n) {
                          print(snapshot.data.countries[n].id);
                          setState(() {
                            _selectedId = int.parse(
                                snapshot.data.countries[n].id.toString());
                            _selectedCountryName =
                                snapshot.data.countries[n].name.toString();
                          });

                          print(_selectedId);
                        },
                        children: List<Widget>.generate(
                            snapshot.data.countries.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    snapshot.data.countries[index].name,
                                    style: TextStyle(
                                        color: Color(0xff7E57C2),
                                        fontFamily: "SFproBold"),
                                  ),
                                )),
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                })
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Select'),
            onPressed: () {
              setState(() {
                futureZOne = getState(id: _selectedId.toString());
              });

              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Future<void> _handleZone() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Select Zone',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          message: Text(
            'Please select your Zone.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            FutureBuilder(
                future: futureZOne,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 180,
                      child: CupertinoPicker(
                        magnification: 1,
                        itemExtent: 70,
                        onSelectedItemChanged: (n) {
                          print(snapshot.data.states[n].id);
                          setState(() {
                            _selectedZoneId = int.parse(
                                snapshot.data.states[n].id.toString());
                            _selectedZoneName =
                                snapshot.data.states[n].name.toString();
                          });

                          print(_selectedId);
                        },
                        children: List<Widget>.generate(
                            snapshot.data.states.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    snapshot.data.states[index].name,
                                    style: TextStyle(
                                        color: Color(0xff7E57C2),
                                        fontFamily: "SFproBold"),
                                  ),
                                )),
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                })
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Select'),
            onPressed: () {
              setState(() {
                futureCity = getCity(id: _selectedZoneId.toString());
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Future<void> _handleCity() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Select City',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          message: Text(
            'Please select your City.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            FutureBuilder(
                future: futureCity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 180,
                      child: CupertinoPicker(
                        magnification: 1,
                        itemExtent: 70,
                        onSelectedItemChanged: (n) {
                          print(snapshot.data.cities[n].id);
                          setState(() {
                            _selectedCityId = int.parse(
                                snapshot.data.cities[n].id.toString());
                            _selectedCityName =
                                snapshot.data.cities[n].name.toString();
                          });

                          print(_selectedId);
                        },
                        children: List<Widget>.generate(
                            snapshot.data.cities.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    snapshot.data.cities[index].name,
                                    style: TextStyle(
                                        color: Color(0xff7E57C2),
                                        fontFamily: "SFproBold"),
                                  ),
                                )),
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CircularProgressIndicator(),
                    ));
                  }
                })
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Select'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  getUserId() {
    FlutterSession().get("id").then((value) {
      setState(() {
        userid = value.toString();
        print(userid);
        getProfileInfo(id: userid).then((value) {
          setState(() {
            fname.text = value.firstname;
            lname.text = value.lastname;
            email.text = value.email;
            mobile.text = value.mobile;
            dob.text = value.dob;
            gender.text = value.gender;
            address.text = value.address;
            print(value.firstname);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getProfileInfo(id: userid ?? "1"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      height: screenSize.height * 0.96,
                      child: Stack(
                        children: [
                          Container(
                            height: screenSize.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff7E57C2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 40,
                            child: Text(
                              "My Profile.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFproBold",
                                  fontSize: 27),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xff7E57C2).withOpacity(0.5),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        spreadRadius: 5)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      maxLines: 1,
                                      controller: fname,
                                      textInputAction: TextInputAction.next,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.firstname == ""
                                            ? "First Name"
                                            : snapshot.data.firstname,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: lname,
                                      textInputAction: TextInputAction.next,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.lastname == ""
                                            ? "Last Name"
                                            : snapshot.data.lastname,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: email,
                                      textInputAction: TextInputAction.next,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.email == ""
                                            ? "Email"
                                            : snapshot.data.email,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: mobile,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      maxLength: 11,
                                      buildCounter: (BuildContext context,
                                              {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                          null,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.mobile == ""
                                            ? "Mobile"
                                            : snapshot.data.mobile,
                                        fillColor: Colors.white,

                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: dob,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [dateMask],
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                        hintText:
                                            snapshot.data.dob == "0000-00-00"
                                                ? "DOB"
                                                : snapshot.data.dob,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: gender,
                                      textInputAction: TextInputAction.next,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.gender == "0"
                                            ? "Gender"
                                            : snapshot.data.gender,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: address,
                                      textInputAction: TextInputAction.done,
                                      decoration: new InputDecoration(
                                        hintText: snapshot.data.address == ""
                                            ? "Address"
                                            : snapshot.data.address,
                                        fillColor: Colors.white,
                                        // border: InputBorder.none,
                                        //fillColor: Colors.green
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _handleCountry();
                                      },
                                      child: TextFormField(
                                        maxLines: 1,
                                        enabled: false,
                                        decoration: new InputDecoration(
                                          hintText: _selectedCountryName == null
                                              ? "Country"
                                              : _selectedCountryName,
                                          fillColor: Colors.white,
                                          // border: InputBorder.none,
                                          //fillColor: Colors.green
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _handleZone();
                                      },
                                      child: TextFormField(
                                        maxLines: 1,
                                        enabled: false,
                                        decoration: new InputDecoration(
                                          hintText: _selectedZoneName == null
                                              ? "State"
                                              : _selectedZoneName,
                                          fillColor: Colors.white,
                                          // border: InputBorder.none,
                                          //fillColor: Colors.green
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _handleCity();
                                      },
                                      child: TextFormField(
                                        maxLines: 1,
                                        enabled: false,
                                        decoration: new InputDecoration(
                                          hintText: _selectedCityName == null
                                              ? "City"
                                              : _selectedCityName,
                                          fillColor: Colors.white,
                                          // border: InputBorder.none,
                                          //fillColor: Colors.green
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DropdownButton<String>(
                                            value: dropdownValue,
                                            icon: Icon(Icons.arrow_downward),
                                            iconSize: 16,
                                            elevation: 16,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 1,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            items: <String>[
                                              'Passport',
                                              'National ID',
                                              'Adhaar Card'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _imgFromCamera();
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff7E57C2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                      imagePath == ""
                                                          ? "+ UPLOAD"
                                                          : "+ " +
                                                              imagePath.substring(
                                                                  imagePath
                                                                          .length -
                                                                      8,
                                                                  imagePath
                                                                      .length),
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RoundButton(
                      screenSize: screenSize,
                      name: "UPDATE",
                      ontap: () {
                        updateProfile(
                                address: address.text.toString(),
                                cityId: _selectedCityId.toString(),
                                countryId: _selectedId.toString(),
                                dob: dob.text.toString(),
                                email: email.text.toString(),
                                fname: fname.text.toString(),
                                lname: lname.text.toString(),
                                gender: gender.text.toString(),
                                id: userid ?? "1",
                                idno: "",
                                idtype: "",
                                mobile: mobile.text.toString(),
                                stateId: _selectedZoneId.toString())
                            .then((value) {
                          print(value.status);
                          CommonUsed.showFloatingFlushbar(
                              context,
                              value.message ?? "Something went wrong!",
                              [Colors.red.shade900, Colors.redAccent.shade400]);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
              } else {
                return Container(
                    height: screenSize.height,
                    child: Center(child: CircularProgressIndicator()));
              }
            }),
      ),
    );
  }
}
