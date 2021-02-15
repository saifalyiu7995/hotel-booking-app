import 'dart:convert';
import 'dart:io';

import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/models/imageUpload_model.dart';
import 'package:hotel_booking_app/view/screens/paymentConfirm.dart';
import 'package:hotel_booking_app/view/widgets/roundButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UploadImage2 extends StatefulWidget {
  String total,
      discription,
      kids,
      adults,
      dateTo,
      dateFrom,
      roomType,
      timeTo,
      timeFrom;
  List<String> paidServices;
  bool hall;

  UploadImage2(
      {this.total,
      this.discription,
      this.adults,
      this.kids,
      this.dateFrom,
      this.dateTo,
      this.roomType,
      this.timeTo,
      this.timeFrom,
      this.hall,
      this.paidServices});

  @override
  _UploadImage2State createState() => _UploadImage2State();
}

class _UploadImage2State extends State<UploadImage2> {
  PickedFile _image;
  String base64Image;
  ImagePicker _picker = ImagePicker();

  Future<ImageUploadModel> _imgFromCamera() async {
    final image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      base64Image = base64Encode(File(image.path).readAsBytesSync());
      _image = image;
    });

    var uri = Uri.parse('http://sub72.protegeglobal.com/hms/api/book/front');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath("front_side", image.path));
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      print("--->>> " + value);
      print(imageUploadModelFromJson(value).status.toString());
      if (imageUploadModelFromJson(value).status.toString() == "success") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentConfirmScreen(
                  discription: widget.discription,
                  total: widget.total,
                  adults: widget.adults,
                  kids: widget.kids,
                  dateFrom: widget.dateFrom.toString().length > 9
                      ? widget.dateFrom.toString().substring(0, 10)
                      : widget.dateFrom.toString(),
                  dateTo: widget.dateTo.toString().length > 9
                      ? widget.dateTo.toString().substring(0, 10)
                      : widget.dateTo.toString(),
                  roomType: widget.roomType,
                  hall: widget.hall,
                  timeFrom: widget.timeFrom,
                  timeTo: widget.timeTo,
                  speedy: true,
                  paidServices: CommonUsed.paidServices),
            ));
      } else {
        CommonUsed.showFloatingFlushbar(
            context,
            imageUploadModelFromJson(value).message.toString() ??
                "Something went wrong!",
            [Colors.red.shade900, Colors.redAccent.shade400]);
      }
    });
  }

  Future<ImageUploadModel> _imgFromGallery() async {
    final image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      base64Image = base64Encode(File(image.path).readAsBytesSync());
      _image = image;
    });

    var uri = Uri.parse('http://sub72.protegeglobal.com/hms/api/book/front');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath("front_side", image.path));
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      print("--->>> " + value);
      print(imageUploadModelFromJson(value).status.toString());
      if (imageUploadModelFromJson(value).status.toString() == "success") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentConfirmScreen(
                  discription: widget.discription,
                  total: widget.total,
                  adults: widget.adults,
                  kids: widget.kids,
                  dateFrom: widget.dateFrom.toString().length > 9
                      ? widget.dateFrom.toString().substring(0, 10)
                      : widget.dateFrom.toString(),
                  dateTo: widget.dateTo.toString().length > 9
                      ? widget.dateTo.toString().substring(0, 10)
                      : widget.dateTo.toString(),
                  roomType: widget.roomType,
                  hall: widget.hall,
                  timeFrom: widget.timeFrom,
                  timeTo: widget.timeTo,
                  speedy: true,
                  paidServices: CommonUsed.paidServices),
            ));
      } else {
        CommonUsed.showFloatingFlushbar(
            context,
            imageUploadModelFromJson(value).message.toString() ??
                "Something went wrong!",
            [Colors.red.shade900, Colors.redAccent.shade400]);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage() async {
    // final image = await _picker.getImage(
    //   source: ImageSource.camera,
    // );

    // setState(() {
    //   base64Image = base64Encode(File(image.path).readAsBytesSync());
    //   _image = image;
    // });

    // http://protegeglobal.com/uploadtest/

    print(base64Image);
    var uri = Uri.parse('http://sub72.protegeglobal.com/hms/api/book/front');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath("file", _image.path));
    var response = await request.send();

    print(response.stream.transform(utf8.decoder).listen((value) {
      print("--->>> " + value.toString());
    }));
    // print(response.contentLength);
    // print(response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // }));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "CNIC BACK",
              style: TextStyle(fontFamily: "SFproBold", fontSize: 22),
            ),
            _image == null
                ? SizedBox(
                    height: screenSize.height * 0.1,
                  )
                : SizedBox(
                    height: screenSize.height * 0.05,
                  ),
            _image == null
                ? SizedBox(
                    height: screenSize.height * 0.1,
                  )
                : SizedBox(),
            _image == null
                ? SizedBox(
                    height: screenSize.height * 0.1,
                  )
                : SizedBox(),
            _image == null
                ? Text(
                    "No, Image yet!",
                    style: TextStyle(fontSize: 22, fontFamily: "SFpro"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: screenSize.height * 0.56,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(File(_image.path))),
                    ),
                  ),
            _image == null
                ? SizedBox(
                    height: screenSize.height * 0.35,
                  )
                : SizedBox(),
            _image == null
                ? RoundButton(
                    screenSize: screenSize,
                    ontap: () {
                      _showPicker(context);
                    },
                    name: "UPLOAD",
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      RoundButton(
                        screenSize: screenSize,
                        ontap: () {
                          _showPicker(context);
                        },
                        name: "UPLOAD IMAGE",
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      RoundButton(
                        screenSize: screenSize,
                        ontap: null,
                        name: "CONFIRM",
                      ),
                    ],
                  ),
            SizedBox(
              height: screenSize.height * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
