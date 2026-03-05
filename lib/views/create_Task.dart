import 'package:flutter/material.dart';
import 'package:mohib_apis/services/auth.dart';
import 'package:mohib_apis/services/task.dart';
import 'package:provider/provider.dart';

import '../provider/user_token.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("CreateTask"),
      ),
      body: Column(children: [
        TextField(controller: descriptionController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
          try{
            await TaskServices().createTask(
                token: userProvider.getToken().toString(),
                description: descriptionController.text)
                .then((value){
              isLoading = false;
              setState(() {});
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Create Successfully"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: Text("Okay"))
                  ],
                );
              },);
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));

          }
        }, child: Text("Create Task"))
      ],),
    );
  }
}
