import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter/utils/constants.dart';
import 'package:todo_flutter/viewmodel/form_viewmodel.dart';

class FormView extends StatefulWidget {
  FormView({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _FormViewState createState() => _FormViewState(id);
}

class _FormViewState extends State<FormView> {
  int todoId;
  String title;
  String startDate;
  String endDate;
  bool isComplete;

  _FormViewState(int id) {
    this.todoId = id;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormsViewModel>.nonReactive(
        viewModelBuilder: () => FormsViewModel(),
        onModelReady: (model) => model.updateList(),
        builder: (_context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Add New To-Do List"),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Column(children: [
                    _firstRow(model),
                    _secondRow(model),
                    _thirdRow(model),
                    _fourthRow(model),
                    _fifthRow(model),
                    _sixthRow(model),
                  ]),
                  margin: EdgeInsets.all(4.0),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 70,
                child: RaisedButton(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      todoId == -1 ? 'CREATE NOW' : "SAVE TODO",
                      style: kWhite22Bold,
                    ),
                  ),
                  onPressed: () {
                    //model view will save here
                    //to login view
                  },
                ),
              ),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _firstRow(FormsViewModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "To-Do Title",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  Widget _secondRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            onSaved: (value) => this.title = value,
            validator: (value) {
              if (value.length < 3) {
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("a minimum of 3 characters is required"),
                // ));
                return 'a minimum of 3 characters is required';
              }
              return value;
            },
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.0),
        ),
      ),
    );
  }

  Widget _thirdRow(FormsViewModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Start Date",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  Widget _fourthRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              startDate != null ? startDate : "Please select a Date",
              style: kGrey16Regular,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    );
  }

  Widget _fifthRow(FormsViewModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "End Date",
            style: kGrey22Bold,
          ),
        ),
      ),
    );
  }

  Widget _sixthRow(FormsViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              endDate != null ? endDate : "Please select a Date",
              style: kGrey16Regular,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                blurRadius: 5.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    var currentDate = DateTime.now();
    var selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
