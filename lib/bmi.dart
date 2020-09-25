import 'package:flutter/material.dart';
import 'person_details.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState()=> _BMIState();
}

class _BMIState extends State<BMI> {
  String _formatted_stringw="In Inches";
  String _formatted_stringh="In Pounds";
  person_details person = new person_details(0,"male",1,0);
  TextEditingController _conage = new TextEditingController();
  TextEditingController _conh = new TextEditingController();
  TextEditingController _conw = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  int _radiovalue = 0;
  int _radiovalue1 = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("BMI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.show_chart), onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Bmi_chart()));
          },
            color: Colors.white,iconSize: 50.0,)
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            Image.asset("images/bmi_log.png",height: 100,width: 300,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Container(
                  color: Colors.yellowAccent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Gender:"),
                                Radio<int>(value: 0, groupValue: _radiovalue, onChanged: radiochanger,
                                  activeColor: Colors.green,
                                ),
                                Text("Male"),
                                Radio<int>(value: 1, groupValue: _radiovalue, onChanged: radiochanger,
                                  activeColor: Colors.green,
                                ),
                                Text("Female"),


                              ],
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: _conage,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Age",
                            hintText: "In years",
                            icon: Icon(Icons.person),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return "Please enter age";
                          },
                        ),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Unit:"),
                                Radio<int>(value: 0, groupValue: _radiovalue1, onChanged: radiochanger1,
                                  activeColor: Colors.green,
                                ),
                                Text("Inches & lbs"),
                                Radio<int>(value: 1, groupValue: _radiovalue1, onChanged: radiochanger1,
                                  activeColor: Colors.green,
                                ),
                                Text("cm & kg"),


                              ],

                            ),
                          ),
                        ),



                        TextFormField(
                          controller: _conh,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Height",
                            hintText: _formatted_stringh,
                            icon: Icon(Icons.insert_chart),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return "Please enter height";
                          },

                        ),
                        TextFormField(
                          controller: _conw,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Weight",
                            hintText: _formatted_stringw,
                            icon: Icon(Icons.accessibility),
                          ),
                          validator: (value){
                            if(value.isEmpty)
                              return "Please enter weight";
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(


                              onTap: (){

                                if(_formkey.currentState.validate())
                                {
                                  setState(() {
                                    person.age = int.parse(_conage.text);
                                    person.height = double.parse(_conh.text);
                                    person.weight = double.parse(_conw.text);
                                    if(_radiovalue==0)
                                      person.gender="male";
                                    else
                                      person.gender="female";
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.pinkAccent,
                                  ),


                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("Calculate",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Your BMI : ${calculate_bmi(person,_radiovalue1).toStringAsFixed(1)}",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: health_status(person,_radiovalue1)
                    )
                )
              ],
            ),

          ],
        ),

      ),
    );
  }

  void radiochanger(int value) {
    setState(() {
      _radiovalue = value;
    });
  }

  void radiochanger1(int value) {
    setState(() {
      _radiovalue1 = value;
    });
    if (_radiovalue1 == 0|| _radiovalue1.toString().isEmpty) {
      _formatted_stringh = "In Inches";
      _formatted_stringw = "In Pounds";
    }
    else {
      _formatted_stringh = "In Centimetres";
      _formatted_stringw = "In Kilograms";
    }
  }

  double calculate_bmi(person_details person,int value) {
    if(value==0)
    {
      return person.weight/(person.height*person.height)*703;
    }
    else
    {
      return person.weight/(person.height*person.height)*10000;

    }
  }

  Widget health_status(person_details person,int value){

    var result = calculate_bmi(person, value);
    if(result==0)
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(""),
          )
      );
    if(result<=16)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Severe Thinness",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.red,
              fontSize: 30,
            ),
          ),
        ),
      );
    }

    if(result<=17&&result>16)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Moderate Thinness",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.deepOrangeAccent,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    if(result<=18.5&&result>17)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Mild Thinness",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orangeAccent,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    if(result<=25&&result>18.5)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Normal",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.green,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    if(result<=30&&result>25)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Overweight",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.deepOrange,
              fontSize: 30,

            ),
          ),
        ),
      );
    }
    if(result<=35&&result>30)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Obese Class I",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    if(result<=40&&result>35)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Obese Class II",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    if(result>40)
    {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Obese Class III",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
              fontSize: 30,
            ),
          ),
        ),
      );
    }

  }

}
class Bmi_chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("BMI Chart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            child: Image.asset("images/bmi_chart.png",height: 1000,width: 1000,),
          ),
        ),
      ),
    );
  }
}


//Category	BMI range - kg/m2
//Severe Thinness	< 16
//Moderate Thinness	16 - 17
//Mild Thinness	17 - 18.5
//Normal	18.5 - 25
//Overweight	25 - 30
//Obese Class I	30 - 35
//Obese Class II	35 - 40
//Obese Class III	> 40