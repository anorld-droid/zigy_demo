import 'package:flutter/material.dart';
import 'package:zigy_demo/domain/network/get_user.dart';
import 'package:zigy_demo/domain/network/save_user.dart';
import 'package:zigy_demo/models/user.dart';
import 'package:zigy_demo/ui/widgets/follow_button.dart';
import 'package:zigy_demo/ui/widgets/text_field_input.dart';
import 'package:zigy_demo/utils/colors.dart';
import 'package:zigy_demo/utils/constants.dart';
import 'package:zigy_demo/utils/utils.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 28.06.2023.

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  late List<User> users;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    //dispose the controllers
    super.dispose();
    _nameController.dispose();
    _jobController.dispose();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var userSnap = await GetUsers().invoke();
      users = userSnap!;
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> displayMessageBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Notification Message'),
            content: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFieldInput(
                      hintText: "Enter your name",
                      textInputType: TextInputType.text,
                      textEditingController: _nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFieldInput(
                      hintText: "Enter your job",
                      textInputType: TextInputType.text,
                      textEditingController: _jobController,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    var addedUser = await SaveUser()
                        .invoke(_nameController.text, _jobController.text);
                    var message = "User saved successfully";
                    if (!addedUser) {
                      message = "User not saved, try aagain";
                    }
                    // ignore: use_build_context_synchronously
                    showSnackBar(message, context);

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text('SAVE')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: mobileBackgroundColor,
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(Constants.appName),
              centerTitle: true,
            ),
            backgroundColor: primaryColor,
            body: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  padding: const EdgeInsets.all(4.0),
                  itemBuilder: (context, index) => _userLayout(users[index]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FollowButton(
                        text: "Post(Save User)",
                        bgColor: blueColor,
                        textColor: primaryColor,
                        borderColor: Colors.grey,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.4,
                        function: () async {
                          displayMessageBox(context);
                        },
                      ),
                    ]),
              ],
            ),
          );
  }

  Widget _userLayout(User user) {
    return Card(
      color: primaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            user.avatar != null
                ? CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(user.avatar!),
                    radius: 40,
                  )
                : const SizedBox(),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      user.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
