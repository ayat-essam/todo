
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/task_model.dart';
import 'model/user_model.dart';


class FireBaseFunction{

  static Future<void> addUsertoFireBase(UserModel userModel){
    return getUserCollection().doc(userModel.id).set(userModel);
  }

  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
          fromFirestore: (docsnapshot, _) => UserModel.fromJson(docsnapshot.data()!),
          toFirestore: (UserModel, _) => UserModel.toJson());

  static CollectionReference<TaskModel> getTaskFireBase(String userId) =>
      getUserCollection().doc(userId).collection('tasks').withConverter<TaskModel>(
          fromFirestore: (docsnapshot, _) => TaskModel.fromJson(docsnapshot.data()!),
          toFirestore: (taskmodel, _) => taskmodel.toJson());

  static Future<void> addtaskFromFireBase(TaskModel taskModel, String userId)async{
    CollectionReference<TaskModel> taskcollection = getTaskFireBase(userId);
    DocumentReference<TaskModel> docref = taskcollection.doc();
    taskModel.id = docref.id;
    return docref.set(taskModel);
  }
  static Future<void> updateTask(TaskModel taskModel, String userId) async {
    CollectionReference<TaskModel> taskcollection = getTaskFireBase(userId);
    await taskcollection.doc(taskModel.id).update(taskModel.toJson());
  }
  static Future<List<TaskModel>> getAllTaskFromFireBase (String userId)async{
    CollectionReference<TaskModel> taskCollection = getTaskFireBase(userId);
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((querySnapshot) => querySnapshot.data()).toList();

  }

  static Future<void>deletetaskfromfirebase (String taskid, String userId){
    CollectionReference<TaskModel> taskscollection = getTaskFireBase(userId);
    return taskscollection.doc(taskid).delete();
  }


  static Future <UserModel> register ({
    required String name,
    required String email,
    required String password,

  })async {
    final credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password);
    final user =  UserModel(
        id: credentials.user!.uid,
        name: name,
        email: email);
    final userCollection = getUserCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({

    required String email,
    required String password,
  }) async {
    final credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password);
    final userCollection = getUserCollection();
    final docsnapshot = await userCollection.doc(credentials.user!.uid).get();
    return docsnapshot.data()!;
  }
  static Future <void> logout () => FirebaseAuth.instance.signOut();
}

