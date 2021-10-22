import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gbv_break_the_cycle/components/slideDrawer.dart';
import 'package:gbv_break_the_cycle/models/dependentModel.dart';
import 'package:gbv_break_the_cycle/models/dependentViewModel.dart';
import 'package:gbv_break_the_cycle/screens/home/add_Dependents.dart';
import 'package:gbv_break_the_cycle/services/dataService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:contacts_service/contacts_service.dart';

class Dependents extends StatefulWidget {
  @override
  _DependentsState createState() => _DependentsState();
}

class _DependentsState extends State<Dependents> {
  DataService restAPI = DataService();
  ProgressDialog progressDialog;
  FlutterSecureStorage storage = FlutterSecureStorage();
  DependentModel dependentModel = DependentModel();
  DependentViewModel dependentViewModel = DependentViewModel();
  List<DependentModel> data = [];
  Contact contact = Contact();

  @override
  void initState() {
    // ignore: todo
    //TODO: implement initState
    super.initState();
    this.fetchDependent();
  }

  //Function to add dependent
  fetchDependent() async {
    String userId = await storage.read(key: "id");
    var response =
        await restAPI.getDependents("/dependent/get-dependents/" + userId);
    dependentViewModel = DependentViewModel.fromJson(response);
    setState(() {
      data = dependentViewModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    return Container(
      child: Scaffold(
          body: getBody(),
          floatingActionButton: SpeedDial(
            icon: Icons.person_add,
            activeIcon: Icons.close,
            children: [
              SpeedDialChild(
                child: Icon(Icons.contacts),
                label: "Add From Contacts",
                onTap: () async {
                  final PermissionStatus permissionStatus =
                      await _getPermission();
                  if (permissionStatus == PermissionStatus.granted) {
                    await ContactsService.openExistingContact(contact);
                  } else {
                    print("Denied");
                  }
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                label: "Add Manually",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddDependents())),
              )
            ],
          )),
    );
  }

  Widget getBody() {
    if (data.contains(null) || data.length < 0) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ));
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return SlidableWidget(
            onDismissed: (action) =>
                dismissSlidableItem(context, index, action),
            child: getCard(data[index]),
          );
        });
  }

  Future<void> dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) async {
    setState(() {
      data[index].id.toString();
    });

    switch (action) {
      case SlidableAction.edit:
        var dependentId = data[index].id.toString();
        break;
      case SlidableAction.delete:
        var dependentId = data[index].id.toString();
        var response = await restAPI
            .deleteDependents("/dependent/delete-dependents/" + dependentId);
        this.fetchDependent();
        break;
    }
  }

  Widget getCard(dependentModel) {
    var fullName = dependentModel.name.toString() +
        " " +
        dependentModel.surname.toString();
    var cellNumber = dependentModel.cellNumber.toString();
    storage.write(key: "deId", value: dependentModel.id.toString());
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullName,
                        style: TextStyle(fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    cellNumber,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Check contacts permission
  Future _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final permissionStatus = await Permission.contacts.request();
      return permissionStatus ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}
