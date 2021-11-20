import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:get/get.dart';
import 'package:my_product/pages/chat/database_methods.dart';
import 'package:my_product/pages/products_screen.dart';
import 'package:my_product/widgets/main_drawer.dart';
import 'package:toast/toast.dart';

import '../search.dart';
import 'conversation_screen.dart';

class ChatRoomsScreen extends StatefulWidget {
  const ChatRoomsScreen({Key key}) : super(key: key);

  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  TextEditingController searchTextController = TextEditingController();
  QuerySnapshot<Map<String, dynamic>> searchSnapshot;
  User firebaseUser = FirebaseAuth.instance.currentUser;
  DatabaseMethods databaseMethods = DatabaseMethods();

  var docData; // for printing
  String username; // for display to user
  String useremail;
  String uid;

  bool isSearching = false;
  Stream familiesNamesStream, chatRoomsStream;

  onSearchButtonClick() async {
    isSearching = true;
    setState(() {});
    // familiesNamesStream= await
    // databaseMethods.getSearchedStoreName(searchTextController.text.trim().toLowerCase());
  }

  Widget SearchChatTile({String searchStoreValue,
    String storeDesc,
    String familyName,
    String category,
    String imageStore,
    String familyId,
    String userIdForFamily, String myName}) {
    return Container(
      width: double.infinity,
      child: ListView(shrinkWrap: true, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Hero(
                  tag: imageStore,
                  child: imageStore != null
                      ? Image.network(
                    imageStore,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  )
                      : Image.network(
                    "https://previews.123rf.com/images/thesomeday123/thesomeday1231712/thesomeday123171200009/91087331-default-avatar-profile-icon-for-male-grey-photo-placeholder-illustrations-vector.jpg",
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  )),
            ),
            Spacer(),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchStoreValue,
                    style: TextStyle(color: black, fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  Text(storeDesc,
                      //maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: black, fontSize: 12)),
                  Text(category,
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            Spacer(),
            Flexible(
              flex: 2,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: basicColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    createChatRoomAndStartConversation(
                        userIdForFamily, familyName,
                        firebaseUser.uid, myName);
                  },
                  child: Text(
                    "message",
                    style: TextStyle(color: black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  createChatRoomAndStartConversation(String receiverUserId, String familyName,
      String uid, String myName) {
    String chatRoomId = getChatRoomId(receiverUserId, uid);

    List<String> chatters = [receiverUserId, uid];
    List<String> chattersNames = [familyName, myName];

    Map<String, dynamic> chatRoomMap = {
      "chatter": chatters,
      "chatRoomId": chatRoomId,
      "recevierName": familyName,
      "recevierId": receiverUserId,
      "senderName": myName,
      "senderId": uid,
      "chatterName": chattersNames,

    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Get.to(() =>
        ConversationScreen(
          recevierId: receiverUserId,
          recevierName: familyName.toString(),
          chatRoomId: chatRoomId,
        ));
  }

// to generate the doc id to be contain  two ids for sender and recevier
  getChatRoomId(String receiver, String sender) {
    if (receiver.substring(0, 1).codeUnitAt(0) > sender.substring(0, 1).codeUnitAt(0)) {
      return "$sender\_$receiver";
    } else {
      return "$receiver\_$sender";
    }
  }

  Widget searchFamiliesNamesList() {
    return StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('familiesStores')
            .where('family store name', isEqualTo: searchTextController.text.trim().toLowerCase())
            .snapshots(),
        // familiesNamesStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, i) {
                  DocumentSnapshot familyDoc = snapshot.data.docs[i];
                  return InkWell(
                    onTap: () {
                      Get.to(() =>
                          ProductsScreen(selectedFamilyStore: familyDoc,
                              familyDescription: familyDoc['store description'].toString()));
                    },
                    child: SearchChatTile(
                      searchStoreValue: familyDoc['family store name'].toString(),
                      familyName: familyDoc['family store name'].toString(),
                      category: familyDoc['category name'].toString(),
                      storeDesc: familyDoc['store description'].toString(),
                      imageStore: familyDoc['image family store'].toString(),
                      familyId: familyDoc['family id'].toString(),
                      userIdForFamily: familyDoc['uid'].toString(),
                      myName: username,
                    ),
                  );
                });
          } else {
            return Center(
              child: Text("No item search"),
            );
          }
        });
  }

  Widget ChatRoomTile(String userIdForRecevier,String recevierName,String name, String lastMessage){
    return InkWell(
      onTap: (){

      },
      child: ListTile(
        title:Text(name),
        subtitle: Text(lastMessage),
      ),
    );
  }
  Widget chatRoomsList() {
    return StreamBuilder(
        stream:
        chatRoomsStream,
        // FirebaseFirestore.instance
        //     .collection("chatRoom")
        //     .orderBy('lastMessageTS',descending: true)
        //     .where('chatter',arrayContains: uid).snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context,i)=> Divider(),
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, i) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
                  return InkWell(
                    onTap: () {
                    //   Get.to(() =>
                    //       ConversationScreen(recevierName:
                    //       documentSnapshot['senderId']
                    //           == firebaseUser.uid ?
                    //       documentSnapshot['recevierName'] : documentSnapshot['senderName']));
                     },
                    child: ChatRoomTile(
                      documentSnapshot['recevierId'],
                        documentSnapshot['recevierName'],
                        documentSnapshot['chatter'][0] == uid?
                        documentSnapshot['chatterName'][1]: documentSnapshot['chatterName'][0],
                        documentSnapshot['lastMessage'],
                        // documentSnapshot.id.replaceAll(firebaseUser.uid, "")
                        // .replaceAll("_", "")
                    ),
                    // ListTile(
                    //   title: Text(
                    //     documentSnapshot['senderId']
                    //         ==firebaseUser.uid?
                    //         documentSnapshot['recevierName']:documentSnapshot['senderName'],
                    //     style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                    //   ),
                    //   subtitle: Text(
                    //     documentSnapshot['lastMessage'],
                    //     style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                  );
//كيف اجيب الداتا الي في حقل في اراي داخل الدوكينت ==========================================
                });
          } else {
            return Center(child: Text("Don't have any chats rooms"));
          }
        });
  }

  getUserData() async {
    //اجيب بيانات دوكيمنت واحد فقط
    DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
    //get will return docs Query snapshot
    await documentReference.get().then((value) {
      //value.data is the full fields for this doc
      if (value.exists) {
        setState(() {
          docData = value.data();
          uid = docData['uid'];
          useremail = docData['email'];
          username = docData['username'];
        });
        print(docData['first name']);
      } else {}
      // getChatRooms();

    });
  }

  getChatRooms() async {
    chatRoomsStream = await databaseMethods.getChatRooms(uid);
    setState(() {

    });
  }

  onScreenLoaded() async {
    await getUserData();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();

    print("My all chats rooms screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              "    My chats",
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: basicColor,
          toolbarHeight: 80,
        ),
        endDrawer: MainDrawer(
          username: username,
          useremail: useremail,
        ),
        backgroundColor: basicColor,
        body: SafeArea(
            child: Container(
                width: 500,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 130,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    )),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          isSearching
                              ? InkWell(
                            onTap: () {
                              setState(() {
                                isSearching = false;
                                searchTextController.clear();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                size: 35,
                              ),
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: white, boxShadow: [
                                BoxShadow(
                                  color: basicColor,
                                  offset: Offset(5, 10),
                                  blurRadius: 8,
                                )
                              ]),
                              child: ListTile(
                                leading: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: basicColor,
                                ),
                                title: TextField(

                                  controller: searchTextController,
                                  decoration: InputDecoration(
                                    hintText: "searching...",
                                    hintStyle: TextStyle(color: basicColor, fontWeight: FontWeight.bold),
                                    border: InputBorder.none,
                                  ),
                                ),
                                trailing: TextButton(
                                  child: Text(
                                    "Find",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    if (searchTextController.text.isNotEmpty) {
                                      onSearchButtonClick();
                                    } else {}
                                    //searchToGetStoresNames(searchTextController.text);
                                    // initSearch();
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    isSearching ? searchFamiliesNamesList()
                    // لما احط اللستيتن مع بعض
                    // يطلع الخلل اللحظي بس لو كل وحدة لحال عادي
                    // :Text("hj")
                        : chatRoomsList()
                    // :Text('jkk'),
                    // searchList(context),
                  ]),
                ))));
  }
}
//   initSearch() {
//     searchToGetStoresNames(searchTextController.text.trim().toLowerCase()).then((value) {
//       print(value.docs[0].data()['family store name']);
//       setState(() {
//         // هذا كويري من جدول المتاجر في معلومات لكل متجر ط
//         searchSnapshot = value;
//       });
//     }).catchError((onError) {
//       Fluttertoast.showToast(msg: "No store with this name", backgroundColor: Colors.redAccent);
//       print("Error searching: $onError ");
//     });
//   }
//
//   Widget searchList(BuildContext context) {
//     return searchSnapshot == null
//         ? Text("No search family store")
//         : ListView.separated(
//             separatorBuilder: (context, i) {
//               return Divider();
//             },
//             shrinkWrap: true,
//             // scrollDirection: Axis.vertical,
//             itemCount: searchSnapshot.docs.length,
//             itemBuilder: (context, i) {
//               return InkWell(
//                 onTap: () {
//                   Get.to(() => ProductsScreen(
//                         selectedFamilyStore: searchSnapshot.docs[i],
//                       ));
//                 },
//                 child: SearchChatTile(
//                     searchStoreValue: searchSnapshot.docs[i].data()['family store name'].toString(),
//                   familyName: searchSnapshot.docs[i].data()['family store name'].toString(),
//                   category:searchSnapshot.docs[i].data()['category name'].toString(),
//                   storeDesc:searchSnapshot.docs[i].data()['store description'].toString(),
//                   imageStore:searchSnapshot.docs[i].data()['image family store'].toString(),
//                     familyId: searchSnapshot.docs[i].data()['family id'].toString(),
//                     userIdForFamily: searchSnapshot.docs[i].data()['uid'].toString(),
//                 ),
//               );
//             });
//   }
//
//   searchToGetStoresNames(String storeName) async {
//     return await FirebaseFirestore.instance.
//     collection('familiesStores').where('family store name', isEqualTo: storeName)
//         .where('uid', isNotEqualTo: firebaseUser.uid).get();
//   }
// }

// class ChatRoomTile extends StatelessWidget {
//   final String recevierName;
//   final String recevierId;
//   final String chatRoomId;
//   final message ;
//
//   ChatRoomTile({this.recevierName,this.recevierId, this.chatRoomId,this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//          onTap: () {
//         //   Get.to(() =>
//         //       ConversationScreen(
//         //          chatRoomId: chatRoomId,
//         //         recevierName: recevierName,
//         //         recevierId: recevierId,
//         //
//         //       )
//           //);
//         },
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Row(
//             children: [
//               Container(
//                   height: 40,
//                   width: 40,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.cyanAccent,
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   child: Text("${recevierName.substring(0, 1)}")),
//               SizedBox(
//                 width: 5,
//               ),
//               ListTile(
//                 title: Text(
//                 recevierName,
//                 style: TextStyle(fontSize: 15)),
//                 subtitle: message,
//               ),
//             ],
//           ),
//           // ),
//         ));
//   }
// }


