import 'package:document_management_main/apis/ikon_service.dart';
import 'package:flutter/material.dart';

void addToStarred(
    isFolder, identifier, parameterType, parameterValue, filePath) {
  if (isFolder) {
    invokeUserSpecificDetails(
        "folder", identifier, parameterType, parameterValue);
  } else if (filePath.endsWith("pdf")) {
    invokeUserSpecificDetails("pdf", identifier, parameterType, parameterValue);
  } else if (filePath.endsWith("plain")) {
    invokeUserSpecificDetails("txt", identifier, parameterType, parameterValue);
  } else if (filePath.endsWith("png")) {
    invokeUserSpecificDetails("png", identifier, parameterType, parameterValue);
  } else if (filePath.endsWith("jpg")) {
    invokeUserSpecificDetails("jpg", identifier, parameterType, parameterValue);
  } else {
    print("FileFolder not Supported");
  }
}

void invokeUserSpecificDetails(
    itemType, identifier, parameterType, parameterValue) async {
  String taskId;
  Map<String, dynamic> itemData;
  // final Map<String, dynamic> userData = await IKonService.iKonService.getLoggedInUserProfileDetails();
  final Map<String, dynamic> userData =
      await IKonService.iKonService.getLoggedInUserProfile();
  String userId = userData["USER_ID"];
  print(userId);
  final List<Map<String, dynamic>> userSpecificFolderFileInstanceData =
      await IKonService.iKonService.getMyInstancesV2(
    processName: "User Specific Folder and File Details - DM",
    predefinedFilters: {"taskName": "Edit Details"},
    processVariableFilters: {"user_id": userId},
    taskVariableFilters: null,
    mongoWhereClause: null,
    projections: ["Data"],
    allInstance: false,
  );
  print("userSpecificFolderFileInstanceData");
  print(userSpecificFolderFileInstanceData);
  if (userSpecificFolderFileInstanceData.length > 0) {
    taskId = userSpecificFolderFileInstanceData[0]["taskId"];
    print("Task id");
    print(taskId);
    itemData = userSpecificFolderFileInstanceData[0]["data"];
    print("ItemData id");
    print(itemData);

    // if(!itemData[itemType]){
    //   itemData[itemType] = {};
    // }
    // if(!itemData[itemType][identifier]){
    //   itemData[itemType][identifier] = {};
    // }
    // if(!itemData[itemType][identifier][parameterType]){
    //   itemData[itemType][identifier][parameterType] = "";
    // }

    // itemData[itemType][identifier][parameterType] = parameterValue;
    itemData[itemType][identifier] != null ?
    itemData[itemType][identifier][parameterType] = parameterValue :
    itemData[itemType][identifier] = {
      parameterType: parameterValue
    };

    bool result = await IKonService.iKonService.invokeAction(
        taskId: taskId,
        transitionName: "Update Edit Details",
        data: itemData,
        processIdentifierFields: null);
    if(result){
      const SnackBar(
        content: Text("Transition Update Edit Details called successfully"),
      );
    }else{
      const SnackBar(
        content: Text("Transition Update Edit Details called failed"),
      );
    }
  } else {
    Map<String, Map<String, dynamic>> userWithObject = {};
    userWithObject[identifier] = {};
    userWithObject[identifier]![parameterType] = parameterValue;

    Map<String, dynamic> obj = {
      "user_id": userId,
      itemType: userWithObject,
    };

    String processId = await IKonService.iKonService.mapProcessName(
        processName: "User Specific Folder and File Details - DM");

    bool result = await IKonService.iKonService.startProcessV2(
        processId: processId, data: obj, processIdentifierFields: "user_id");
    if(result){
      const SnackBar(content: Text("Success - User Specific Folder and File Details - DM"));
    }else{
      const SnackBar(content: Text("Failed - User Specific Folder and File Details - DM"));
    }
  }
}
