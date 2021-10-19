import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_product/color/my_colors.dart';
import 'package:my_product/dummy_data.dart';
import 'package:my_product/modules/families.dart';
import 'package:my_product/pages/taps_screen.dart';
import 'package:my_product/widgets/family_item.dart';
import 'package:my_product/widgets/main_drawer.dart';

class FamiliesScreen extends StatelessWidget {
  static const routeName = '/families_categories';

  @override
  Widget build(BuildContext context) {
    //استقبل البيانات من خلال بوش ناميد
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    //اخزن البيانات الي اخذتها في متغير عنشان اعرضها او اي شي
    final categoryId = routeArg['id'];
    final categoryName = routeArg['title'];

    //ميثود ال where لاوم احولها الى لستة لانه حتلف علة مجموعة عناصر ف اذا رح ترجعلي اشياء كتيييير
    // لستة مفلترة بس فيها العوائل الي لهم تصنيف نعين حسب الاي دي
    final familiesStores = DUMMY_FAMILIES_STORES.where((store) {
      return store.categoryId == categoryId;
    }).toList();

    /*.where((store){
       return store.categoryId.contains(categoryId);
         }).toList(); ;*/
//print(familiesStores);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(categoryName);
          },
          color: Colors.white,
        ),

        title: Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text("${categoryName.toString()} Families Stores",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ),
        backgroundColor: Color(0xFF90A4AE),
        toolbarHeight: 80,
      ),
      endDrawer: MainDrawer(),
       backgroundColor: Color(0xFF90A4AE),
        body: ListView(

            children: <Widget>[
              SizedBox(height: 20,), //between them
          Container(
            height: MediaQuery.of(context).size.height - 180,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100),bottomRight:Radius.circular(150),
                )
            ),


            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25, right: 25),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 45),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 300,
                    child: ListView(
                      children: familiesStores.map((familyItem) =>
                          FamilyItem(
                            familyImage: familyItem.familyImage,
                              description: familyItem.description,
                              familyName: familyItem.familyName,
                              categoryId: familyItem.categoryId,
                              userId: familyItem.userId, familyId: familyItem.familyId,
                            )

                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
        ),

        );
  }
}
