import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common.dart';
import 'package:hotel_booking_app/services/web_service.dart';
import 'package:hotel_booking_app/view/screens/uploadImage.dart';
import 'package:hotel_booking_app/view/widgets/roundButton.dart';
import 'package:hotel_booking_app/view/widgets/textInput.dart';

class PersonalInfo extends StatefulWidget {
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

  PersonalInfo(
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
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController cnic = new TextEditingController();
  TextEditingController fname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController address = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.07,
                ),
                Container(
                    height: screenSize.height * 0.2,
                    child: Image(image: AssetImage("assets/images/info.png"))),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                TextInput_widget(
                  labelText: "CNIC",
                  validationWarning: "CNIC cannot be empty",
                  keyboardType: TextInputType.number,
                  obsecureText: false,
                  cnic: true,
                  action: TextInputAction.next,
                  txtType: "password",
                  controller: cnic,
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput_widget(
                  labelText: "First Name",
                  cnic: null,
                  validationWarning: "First name cannot be empty",
                  keyboardType: TextInputType.name,
                  obsecureText: false,
                  action: TextInputAction.next,
                  txtType: "name",
                  controller: fname,
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput_widget(
                  labelText: "Last Name",
                  validationWarning: "Last name cannot be empty",
                  keyboardType: TextInputType.name,
                  obsecureText: false,
                  action: TextInputAction.next,
                  txtType: "name",
                  controller: lname,
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput_widget(
                  labelText: "Email",
                  validationWarning: "Email cannot be empty",
                  keyboardType: TextInputType.emailAddress,
                  obsecureText: false,
                  action: TextInputAction.next,
                  txtType: "email",
                  controller: email,
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput_widget(
                  labelText: "Address",
                  validationWarning: "Address cannot be empty",
                  keyboardType: TextInputType.name,
                  obsecureText: false,
                  action: TextInputAction.done,
                  txtType: "name",
                  controller: address,
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                RoundButton(
                  screenSize: screenSize,
                  ontap: () {
                    if (_formKey.currentState.validate()) {
                      speedyInfo(
                              fname: fname.text.toString(),
                              lname: lname.text.toString(),
                              email: email.text.toString(),
                              address: address.text.toString(),
                              cnic: cnic.text.toString(),
                              useId: 1)
                          .then((value) {
                        print(value.status);

                        if (value.status == "success") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadImage(
                                    discription: widget.discription,
                                    total: widget.total,
                                    adults: widget.adults,
                                    kids: widget.kids,
                                    dateFrom:
                                        widget.dateFrom.toString().length > 9
                                            ? widget.dateFrom
                                                .toString()
                                                .substring(0, 10)
                                            : widget.dateFrom.toString(),
                                    dateTo: widget.dateTo.toString().length > 9
                                        ? widget.dateTo
                                            .toString()
                                            .substring(0, 10)
                                        : widget.dateTo.toString(),
                                    roomType: widget.roomType,
                                    hall: widget.hall,
                                    timeFrom: widget.timeFrom,
                                    timeTo: widget.timeTo,
                                    paidServices: CommonUsed.paidServices),
                              ));
                        } else {
                          CommonUsed.showFloatingFlushbar(
                              context,
                              value.message ?? "Some thing went wrong!",
                              [Colors.red.shade900, Colors.redAccent.shade400]);
                        }
                      });
                    }
                  },
                  name: "CONFIRM",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
