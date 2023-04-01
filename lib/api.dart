import 'dart:convert';

import 'package:backendapi/show_snackbar.dart';
import 'package:backendapi/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;


class CustomerAgentForm extends StatefulWidget {

  @override
  State<CustomerAgentForm> createState() => _CustomerAgentFormState();
}

class _CustomerAgentFormState extends State<CustomerAgentForm> {
  var formKey = GlobalKey<FormState>();
  ShowSnackBar showSnackBar=ShowSnackBar();
  var registrationDate;
  var patientName;
  var mobNumber;
  var age;
  var gender;
  var isTablets;
  var isInsulin;
  var profession;
  var address;
  var isKneePain;
  var height;
  var Feet;
  var Inches;
  var weight;
  var durationYears;
  var durationMonths;
  var FBS;
  var PPBS;
  var Hba1c;
  var RBS;
  var kneePain;
  List medNameList = [];
  List MgList = [];
  List timesList = [];
  List insulinInjectionList = [];
  List morIuList = [];
  List noonIuList = [];
  List evenIuList = [];
  var remarks;
  var medicine = '';

  var noOfTablets;
  var noOfInsulin;

  var finalDate = 'choose date';
  final firstDate = DateTime(DateTime.now().year - 1);
  final lastDate = DateTime.now();
  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  var selectedDate = DateTime.now();

  List<Widget> medicineList = [];
  List<Widget> insulinList = [];
  List languageList=[];

  var patientModel;

  var callLaterTime;

  var call;

  var url;
  var clicked = false;

  var rejectReason;
  var rejectReason1;

  var isFoot;
  var isBP;

  var language;
  var verifyLoading = false;

  @override
  void initState() {
    _selectDate(context);
    super.initState();
  }

  Widget heightInput(var height, var setState) {
    return Container(
      width: height == 'feet'
          ? (MediaQuery.of(context).size.width * 0.4)
          : height == 'inch'
          ? (MediaQuery.of(context).size.width * 0.4)
          : (MediaQuery.of(context).size.width * 0.9),
      height: height == 'reject'
          ? MediaQuery.of(context).size.height * 0.08
          : MediaQuery.of(context).size.height * 0.11,
      margin: height == 'language'?EdgeInsets.only(bottom: 5):EdgeInsets.only(bottom: 15),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height == 'feet'
              ? Container(
            padding: EdgeInsets.only(left: 7),
            child: Text('Height : ',
                style: Theme.of(context).textTheme.headline3),
          )
              : height == 'inch'
              ? Text('', style: Theme.of(context).textTheme.headline3)
              : height == 'tablets'
              ? Text('no. of tablets',
              style: Theme.of(context).textTheme.headline3)
              : height == 'insulin'
              ? Text('no. of types of insulin',
              style: Theme.of(context).textTheme.headline3)
              : height == 'language'
              ? Text('Language',
              style: Theme.of(context).textTheme.headline3)
              : Container(),
          Container(
            // height: 45,
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color.fromRGBO(142, 142, 142, 1))),
            child: height == 'feet'
                ? heightDropdownButton()
                : height == 'inch'
                ? inchDropdownButton("Inches", null)
                : height == 'tablets'
                ? inchDropdownButton("no. of tablets", null)
                : height == 'insulin'
                ? inchDropdownButton(
                "no. of types of insulin", null)
                : height == 'language'
                ? inchDropdownButton("patient's language", null)
                : inchDropdownButton(
                "rejection reason", setState),
          ),
        ],
      ),
    );
  }

  Widget inchDropdownButton(var title, var set) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          isExpanded: true,
          //borderRadius: BorderRadius.circular(10.0),
          hint: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          value: title == "Inches"
              ? Inches
              : title == "no. of tablets"
              ? noOfTablets
              : title == "no. of types of insulin"
              ? noOfInsulin
              : title == "patient's language"
              ? language
              : rejectReason,
          style: TextStyle(color: Colors.black),
          items: title == "Inches"
          ? ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11']
          .map(
          (val) {
    return DropdownMenuItem<String>(
    value: val,
    child: Text(
    val,
    style: Theme.of(context).textTheme.headline1,
    ),
    );
    },
    ).toList()
        : title == "rejection reason"
    ? [
    'age is more than 65',
    'type-1 diabetes',
    'Liver problem',
    'Kidney problem',
    'not interested',
    'price problem',
    'called on behalf of someone',
    'other'
    ].map(
    (val) {
    return DropdownMenuItem<String>(
    value: val,
    child: Text(
    val,
    style: Theme.of(context).textTheme.headline1,
    ),
    );
    },
    ).toList()
        : title == "patient's language"
    ? languageList.map(
    (val) {
    return DropdownMenuItem<String>(
    value: val,
    child: Text(
    val,
    style: Theme.of(context).textTheme.headline1,
    ),
    );
    },
    ).toList()
        : ['1', '2', '3', '4', '5'].map(
    (val) {
    return DropdownMenuItem<String>(
    value: val,
    child: Text(
    val,
    style: Theme.of(context).textTheme.headline1,
    ),
    );
    },
    ).toList(),
    onChanged: title == "Inches"
    ? (inches) {
    setState(
    () {
    // FocusScope.of(context).requestFocus(new FocusNode());
    print(inches);
    Inches = inches;
    },
    );

    print(inches);
    }
        : title == "no. of tablets"
    ? (tablets) {
    setState(
    () {
    // FocusScope.of(context).requestFocus(new FocusNode());
    print(tablets);
    noOfTablets = tablets;
    medicineList.clear();
    },
    );

    print(tablets);
    }
        : title == "no. of types of insulin"
    ? (insulin) {
    setState(
    () {
    // FocusScope.of(context).requestFocus(new FocusNode());
    print(insulin);
    noOfInsulin = insulin;
    insulinList.clear();
    },
    );

    print(insulin);
    }
        : title == "patient's language"
    ? (lang) {
    setState(
    () {
    // FocusScope.of(context).requestFocus(new FocusNode());
    language = lang;
    },
    );
    print(language);
    }
        : (reason) {
    set(
    () {
    // FocusScope.of(context).requestFocus(new FocusNode());
    print(reason);
    rejectReason = reason;
    },
    );

    print(reason);
    },
    ),
    );
  }

  Widget heightDropdownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //isDense: true,
        isExpanded: true,
        //borderRadius: BorderRadius.circular(10.0),
        hint: Text(
          "Feet",
          style: TextStyle(fontSize: 15),
        ),
        value: Feet,
        style: TextStyle(color: Colors.black),
        items: ['0', '1', '2', '3', '4', '5', '6', '7'].map(
              (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: Theme.of(context).textTheme.headline1,
              ),
            );
          },
        ).toList(),
        onChanged: (feet) {
          setState(
                () {
              // FocusScope.of(context).requestFocus(new FocusNode());
              print(feet);
              Feet = feet;
            },
          );

          print(feet);
          Text(
            '$feet',
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  Widget radioInput(var title) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 6),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline3),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              title == 'Gender : '
                  ? radioButtons(true, 'Male', 'gender')
                  : title == 'Is patient suffering from Thyroid problem?'
                  ? radioButtons(true, 'Yes', 'knee pain')
                  : title == 'Is patient taking any diabetes tablets?'
                  ? radioButtons(true, 'Yes', 'tablets')
                  : title == 'Is patient taking insulin?'
                  ? radioButtons(true, 'Yes', 'insulin')
                  : title ==
                  'Is patient having burning foot sensation?'
                  ? radioButtons(true, 'Yes', 'burning foot')
                  : radioButtons(true, 'Yes', 'BP'),
              SizedBox(
                width: 20,
              ),
              title == 'Gender : '
                  ? radioButtons(false, 'Female', 'gender')
                  : title == 'Is patient suffering from Thyroid problem?'
                  ? radioButtons(false, 'No', 'knee pain')
                  : title == 'Is patient taking any diabetes tablets?'
                  ? radioButtons(false, 'No', 'tablets')
                  : title == 'Is patient taking insulin?'
                  ? radioButtons(false, 'No', 'insulin')
                  : title ==
                  'Is patient having burning foot sensation?'
                  ? radioButtons(false, 'No', 'burning foot')
                  : radioButtons(false, 'No', 'BP'),
            ],
          ),
        ],
      ),
    );
  }

  Widget radioButtons(bool Value, String YN, var title) {
    return Row(
      children: [
        Radio(
          value: Value,
          groupValue: title == 'knee pain'
              ? isKneePain
              : title == 'gender'
              ? gender
              : title == 'tablets'
              ? isTablets
              : title == 'insulin'
              ? isInsulin
              : title == 'burning foot'
              ? isFoot
              : isBP,
          onChanged: title == 'knee pain'
              ? YN == 'Yes'
              ? (val) => setState(() => isKneePain = true)
              : (val) => setState(() => isKneePain = false)
              : title == 'gender'
              ? YN == 'Male'
              ? (val) {
            return setState(() => gender = true);
          }
              : (val) => setState(() => gender = false)
              : title == 'tablets'
              ? YN == 'Yes'
              ? (val) => setState(() => isTablets = true)
              : (val) {
            return setState(() {
              noOfTablets = null;
              medicineList.clear();
              isTablets = false;
            });
          }
              : title == 'insulin'
              ? YN == 'Yes'
              ? (val) => setState(() => isInsulin = true)
              : (val) => setState(() {
            noOfInsulin = null;
            //add list to clear here
            isInsulin = false;
          })
              : title == 'burning foot'
              ? YN == 'Yes'
              ? (val) => setState(() => isFoot = true)
              : (val) => setState(() {
            isFoot = false;
          })
              : YN == 'Yes'
              ? (val) => setState(() => isBP = true)
              : (val) => setState(() {
            isBP = false;
          }),
        ),
        Text(
          YN,
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 14),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) {
    // final DateTime? picked = await showDatePicker(
    //     context: context,
    //     initialDate: selectedDate,
    //     firstDate: firstDate,
    //     lastDate: lastDate);
    // if (picked != null && picked != selectedDate) {
    //   setState(() {
    //     selectedDate = picked;
    //     finalDate = formatter.format(selectedDate);
    //   });
    // }

    setState(() {
      var picked = DateTime.now();
      selectedDate = picked;
      finalDate = formatter.format(selectedDate);
    });
  }

  Widget textFields(String labelText, var inputFormatters, var limit) {
    return TextFormField(
      maxLength: limit,
      initialValue: labelText == 'mobile number'
          ? '9632675745'
          : labelText == 'Mg'
          ? '00'
          : labelText == 'medicine name'
          ? 'nad'
          : labelText == 'Insulin'
          ? 'nad'
          : (labelText == 'morning iu' ||
          labelText == 'afternoon iu' ||
          labelText == 'evening iu')
          ? '00'
          : null,
      keyboardType:
      labelText == 'Remarks' ? TextInputType.multiline : TextInputType.text,
      maxLines: labelText == 'Remarks' ? 5 : null,
      style: Theme.of(context).textTheme.headline3,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: labelText == 'medicine name'
          ? (value) {
        medNameList.add(value);
      }
          : (value) {},
      onChanged:
      //labelText == 'medicine name'?(value){ medNameList.add(value);}:labelText == 'Mg'?(value){MgList.add(value);}:labelText == 'times'?(value){timesList.add(value);}:labelText == 'morning iu'?(value){morIuList.add(value);}:labelText == 'afternoon iu'?(value){noonIuList.add(value);}:labelText == 'evening iu'?(value){evenIuList.add(value);}:labelText == 'Insulin'?(value){insulinInjectionList.add(value);}:
          (value) {},
      decoration:
      InputDecoration(labelText: labelText, border: OutlineInputBorder()),
      validator: (value) {
        if (labelText == 'Name') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (value.length < 3) {
            return 'name length shouldn\'t be less than 3 letters';
          } else if (value.length > 45) {
            return 'name length shouldn\'t be more than 45 letters';
          } else {
            return null;
          }
        } else if (labelText == 'mobile number') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (value.isEmpty) {
            return 'Please enter your mobile number!';
          } else if (value.length < 10 || value.length > 10) {
            return 'should contain only 10 digits';
          } else {
            return null;
          }
        } else if (labelText == 'age') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (int.parse(value) <= 0 || int.parse(value) > 120) {
            return "age should be in the range of 1-120";
          } else {
            return null;
          }
        } else if (labelText == 'Address') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (value.length < 3) {
            return 'shouldn\'t be less than 3 letters';
          } else if (value.length > 150) {
            return 'shouldn\'t be more than 150 letters';
          } else {
            return null;
          }
        } else if (labelText == 'Profession') {
          if (value!.length > 40) {
            return 'shouldn\'t be more than 40 letters';
          } else {
            return null;
          }
        } else if (labelText == 'Weight') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (int.parse(value) <= 0 || int.parse(value) >= 199) {
            return "weight should be in the range of 1-199";
          } else {
            return null;
          }
        } else if (labelText == 'Years') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (int.parse(value) < 0 || int.parse(value) > 90) {
            return "should be in the range of 0-90";
          } else {
            return null;
          }
        } else if (labelText == 'Months') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (int.parse(value) < 0 || int.parse(value) > 11) {
            return "should be in the range of 0-90";
          } else {
            return null;
          }
        } else if (labelText == 'FBS' ||
            labelText == 'PPBS' ||
            labelText == 'Hba1c' ||
            labelText == 'RBS') {
          return null;
        } else if (labelText == 'medicine name' || labelText == 'Insulin') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else if (value!.length > 45) {
            return 'shouldn\'t be more than 45 letters';
          } else {
            return null;
          }
        } else if (labelText == 'Mg') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else {
            return null;
          }
        } else if (labelText == 'times') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else {
            return null;
          }
        } else if (labelText == 'morning iu') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else {
            return null;
          }
        } else if (labelText == 'afternoon iu') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else {
            return null;
          }
        } else if (labelText == 'evening iu') {
          if (value!.isEmpty) {
            return 'can\'t be empty';
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      onSaved: (value) {
        if (labelText == 'Name') {
          patientName = value;
        } else if (labelText == 'mobile number') {
          mobNumber = value;
        } else if (labelText == 'age') {
          age = value;
        } else if (labelText == 'Address') {
          address = value;
        } else if (labelText == 'Profession') {
          profession = value!;
        } else if (labelText == 'Weight') {
          weight = value;
        } else if (labelText == 'Years') {
          durationYears = value;
        } else if (labelText == 'Months') {
          durationMonths = value;
        } else if (labelText == 'FBS') {
          FBS = value!;
        } else if (labelText == 'PPBS') {
          PPBS = value!;
        } else if (labelText == 'Hba1c') {
          Hba1c = value!;
        } else if (labelText == 'RBS') {
          RBS = value!;
        } else if (labelText == 'medicine name') {
          medNameList.add(value!);
        } else if (labelText == 'Insulin') {
          insulinInjectionList.add(value!);
        } else if (labelText == 'Mg') {
          MgList.add(value!);
        } else if (labelText == 'times') {
          timesList.add(value!);
        } else if (labelText == 'morning iu') {
          morIuList.add(value!);
        } else if (labelText == 'afternoon iu') {
          noonIuList.add(value!);
        } else if (labelText == 'evening iu') {
          evenIuList.add(value!);
        }
      },
    );
  }

  Widget medWidget(var type) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              alignment: Alignment.topCenter,
              width: type == 'medicine'
                  ? MediaQuery.of(context).size.width * 0.40
                  : MediaQuery.of(context).size.width * 0.30,
              child: type == 'medicine'
                  ? textFields('medicine name', null, null)
                  : textFields(
                  'morning iu',
                  <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  null)),
          Container(
            alignment: Alignment.topCenter,
            width: type == 'medicine'
                ? MediaQuery.of(context).size.width * 0.20
                : MediaQuery.of(context).size.width * 0.30,
            child: type == 'medicine'
                ? textFields(
                'Mg',
                <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                4)
                : textFields(
                'afternoon iu',
                <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                null),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: type == 'medicine'
                ? MediaQuery.of(context).size.width * 0.20
                : MediaQuery.of(context).size.width * 0.30,
            child: type == 'medicine'
                ? textFields(
                'times',
                <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                1)
                : textFields(
                'evening iu',
                <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                null),
          ),
        ],
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      )
    ]);
  }

  void _showDialog(String textContent) {
    //disableSubmitButton=true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog(textContent: textContent);
      },
    );
  }
  customerApi(var body) async {
    try{
      var url=Uri.parse('http://127.0.0.1:8000/api/'+'info_from_customer');
      print(url);
      print(body);
      var Response=await http.post(url,body: json.encode(body),headers: {
        'content-Type' : 'application/json',
      });

      if(Response.statusCode==200)
      {
        var response=json.decode(Response.body);
        print(response);
        return response['status'];
      }
      else{
        throw Response;
      }

    }catch(error)
    {
      print(error);
    }
  }
  submitForm() async {
    //medicine=medicine+'Tab $medName of $Mg mg $times times in a day';
    var heightInMeter = double.tryParse("$Feet.$Inches")! / 3.2808;
    var durationInYears =
        ((double.parse(durationYears) * 12) + double.parse(durationMonths)) /
            12;
    registrationDate = finalDate;
    if (isKneePain) {
      kneePain = 'yes';
    }
    if (!isKneePain) {
      kneePain = 'no';
    }
    print('prof$profession');
    print('medList:$medNameList');
    print('MgList:$MgList');
    print('timesList:$timesList');
    var body = {
      'CallSid': mobNumber.toString(),
      'date': registrationDate.toString(),
      'PatientName': patientName.toString(),
      'mobile_no': mobNumber.toString(),
      'isTablets': isTablets.toString(),
      'noOfTabs': noOfTablets == null ? 'empty' : noOfTablets,
      'isInsulin': isInsulin.toString(),
      'tablets': medNameList.isEmpty ? 'empty' : medNameList,
      'Mg': MgList.isEmpty ? 'empty' : MgList,
      'times': timesList.isEmpty ? 'empty' : timesList,
      'age': age.toString(),
      'gender': gender ? 'male' : 'female',
      'city': address.toString(),
      'FBS': FBS == '' ? 'empty' : FBS.toString(),
      'PPBS': PPBS == '' ? 'empty' : PPBS.toString(),
      'HBA1C': Hba1c == '' ? 'empty' : Hba1c.toString(),
      'RBS': RBS == '' ? 'empty' : RBS.toString(),
      'Diabetes_duration': durationInYears.toStringAsPrecision(4),
    };
    print('body:${json.encode(body)}');
    var response = await customerApi(body);

    if (response == 'success') {
      showSnackBar.showToast(' Submitted Successfully!!', context);
      setState(() {
        isKneePain = null;
        gender = null;
        Feet = null;
        Inches = null;
        finalDate = 'choose date';
        formKey.currentState!.reset();
      });
    }
    setState(() {
      verifyLoading = false;
    });
  }

  callRejectReason() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      titleTextStyle: Theme.of(context).textTheme.headline2,
      contentTextStyle: Theme.of(context).textTheme.headline3,
      title: Text(
        "Reason for Rejection",
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
      ),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return heightInput('reject', setState);
          }),
      actions: <Widget>[
        new TextButton(
          child: new Text(
            "Close",
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: new Text(
            "Submit",
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          onPressed: () {
            if (rejectReason != null) {
              Navigator.of(context).pop(rejectReason);
            } else {
              _showDialog("Please provide reason for rejection");
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      Widget insulinFun() {
        return Column(
          children: [
            textFields('Insulin', null, null),
            SizedBox(
              height: constraint.maxHeight * 0.01,
            ),
            medWidget('insulin'),
            SizedBox(
              height: constraint.maxHeight * 0.015,
            ),
          ],
        );
      }

      Widget insulinDetails() {
        insulinList.clear();
        for (int i = 0; i < int.parse(noOfInsulin.toString()); i++) {
          insulinList.add(insulinFun());
        }
        return Column(children: insulinList.map((e) => e).toList());
      }

      Widget medicineDetails() {
        // medicineList.add(medWidget());
        medicineList.clear();
        for (int i = 0; i < int.parse(noOfTablets.toString()); i++) {
          medicineList.add(medWidget('medicine'));
        }
        return Container(
          width: constraint.maxWidth,
          //height: constraint.maxHeight*0.20,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 7),
                  child: Text(
                    'Patient present medication',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.add),
                //   onPressed: () {
                //     medicine=medicine +'Tab $medName of $Mg mg $times times in a day, ';
                //     setState(() {
                //       medicineList.add(medWidget('medicine'));
                //     });
                //   },
                // )
              ],
            ),
            //medWidget('medicine'),
            Column(
              children: medicineList.map((e) => e).toList(),
            ),
            medicineList.length == 1
                ? Container()
                : SizedBox(
              height: constraint.maxHeight * 0.01,
            ),
          ]),
        );
      }

      Widget multipleTextFields(var heading) {
        return Container(
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 7, bottom: 5),
                    child: Text(
                      heading,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: constraint.maxWidth * 0.45,
                    child: heading == 'Diabetes duration'
                        ? textFields(
                        'Years',
                        <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        2)
                        : textFields(
                        'FBS',
                        <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        null),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      width: constraint.maxWidth * 0.45,
                      child: heading == 'Diabetes duration'
                          ? textFields(
                          'Months',
                          <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          2)
                          : textFields(
                          'PPBS',
                          <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'))
                          ],
                          null)),
                ],
              ),
              SizedBox(
                height: constraint.maxHeight * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: constraint.maxWidth * 0.45,
                    child: heading != 'Diabetes duration'
                        ? textFields(
                        'Hba1c',
                        <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        null)
                        : Container(),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: constraint.maxWidth * 0.45,
                    child: heading != 'Diabetes duration'
                        ? textFields(
                        'RBS',
                        <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        null)
                        : Container(),
                  )
                ],
              )
            ]));
      }
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Customer Form",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            call != null
                ? IconButton(
                onPressed: () {
                  // var recording=await exotelApis.exotelCallDetailsApi(call['Call']['Sid'].toString(), context);
                  // print('recording:$recording');
                  //  final player = AudioPlayer();
                  //  if(recording!=null)
                  //    {
                  //      setState(() {
                  //        url=Uri.parse(recording['Call']['RecordingUrl'].toString());
                  //        clicked=!clicked;
                  //      });
                  //    }
                  clicked = !clicked;
                  setState(() {});
                },
                icon: Icon(
                  Icons.mic,
                  size: 25,
                ))
                : Container()
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Text(
                                      'Date : $finalDate',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.date_range),
                                    //   onPressed: () {
                                    //     _selectDate(context);
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          textFields('Name', null, null),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: constraint.maxWidth * 0.50,
                                child: textFields(
                                    'mobile number',
                                    <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    10),
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  width: constraint.maxWidth * 0.37,
                                  child: textFields(
                                      'age',
                                      <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      3))
                            ],
                          ),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          textFields('Profession', null, null),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          textFields('Address', null, null),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          radioInput('Gender : '),
                          //SizedBox(height:constraint.maxHeight*0.02,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heightInput('feet', null),
                                heightInput('inch', null)
                              ],
                            ),
                          ),
                          textFields(
                              'Weight',
                              <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              3),
                          SizedBox(
                            height: constraint.maxHeight * 0.03,
                          ),
                          multipleTextFields('Diabetes duration'),
                          multipleTextFields('Recent blood sugar test report'),
                          SizedBox(
                            height: constraint.maxHeight * 0.03,
                          ),
                          radioInput('Is patient suffering from Thyroid problem?'),
                          radioInput('Is patient having burning foot sensation?'),
                          radioInput(
                              'Is patient suffering from low or high blood pressure(BP)?'),
                          radioInput('Is patient taking any diabetes tablets?'),
                          isTablets == true
                              ? heightInput('tablets', null)
                              : Container(),
                          isTablets != null &&
                              isTablets == true &&
                              noOfTablets != null
                              ? medicineDetails()
                              : Container(),
                          radioInput('Is patient taking insulin?'),
                          isInsulin == true
                              ? heightInput('insulin', null)
                              : Container(),
                          isInsulin == true &&
                              isInsulin != null &&
                              noOfInsulin != null
                              ? insulinDetails()
                              : Container(),
                          SizedBox(
                            height: constraint.maxHeight * 0.02,
                          ),
                          Container(
                            //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                            height: constraint.maxHeight * 0.12,
                            child:
                            //textFields('Remarks', null),)
                            TextFormField(
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: Theme.of(context).textTheme.headline3,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  //labelText: 'Remarks',
                                  hintText: 'Remarks',
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                print('value$value');
                                if (value!.isEmpty) {
                                  return 'can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                remarks = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: constraint.maxHeight * 0.07,
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Color.fromRGBO(1, 127, 251, 1))),
                              //color: Color.fromRGBO(1, 127, 251, 1),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'Poppins',
                                    fontSize: 14),
                              ),
                              onPressed: () {
                                final isValid = formKey.currentState!.validate();
                                FocusScope.of(context).unfocus();
                                if (isValid) {
                                  formKey.currentState!.save();
                                  print(mobNumber);
                                  print(patientName);
                                  print(durationMonths);
                                  print(durationYears);
                                  print(insulinInjectionList);
                                }
                                if (finalDate == 'choose date') {
                                  _showDialog('please enter the date');
                                } else if (!isValid) {
                                  null;
                                }
                                // else if (finalDate == 'choose date') {
                                //   _showDialog('please enter the date');
                                // }
                                else if (durationYears == 0.toString() &&
                                    durationMonths == 0.toString()) {
                                  _showDialog(
                                      'both diabetes duration years and months can\'t be 0');
                                } else if (gender == null) {
                                  _showDialog("Please select your gender");
                                } else if (Feet == null) {
                                  _showDialog("Please provide Feet");
                                } else if (int.parse(Feet) == 0) {
                                  _showDialog(
                                      "Please provide value for Feet greater than 0");
                                } else if (Inches == null) {
                                  _showDialog("Please provide Inches");
                                } else if (isTablets == null) {
                                  _showDialog(
                                      "Please provide information on patient\'s diabetes tablet intake");
                                } else if (isTablets == true &&
                                    noOfTablets == null) {
                                  _showDialog(
                                      "Please choose number of diabetes tablets");
                                } else if (isInsulin == null) {
                                  _showDialog(
                                      "Please provide information on patient\'s insulin intake");
                                } else if (isInsulin == true &&
                                    noOfInsulin == null) {
                                  _showDialog(
                                      "Please choose number of types of insulin");
                                } else if (isInsulin == false &&
                                    (FBS == '' &&
                                        PPBS == '' &&
                                        Hba1c == '' &&
                                        RBS == '')) {
                                  _showDialog(
                                      "Please provide blood sugar test values");
                                } else if (isKneePain == null) {
                                  _showDialog(
                                      "Please provide information about thyroid problem");
                                } else if (isFoot == null) {
                                  _showDialog(
                                      "Please provide information about burning foot sensation");
                                } else if (isBP == null) {
                                  _showDialog(
                                      "Please provide information about blood pressure(BP)");
                                }
                                // else if (remarks == null) {
                                //   _showDialog(
                                //       "Please provide remarks");
                                // }
                                else {
                                  submitForm();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}