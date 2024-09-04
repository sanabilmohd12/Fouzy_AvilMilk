import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fouzy/provider/mainprovider.dart';
import 'package:provider/provider.dart';

import '../constants/callfunctions.dart';
import '../constants/colors.dart';
import '../constants/myimages.dart';
import '../constants/widgets.dart';
import '../modelClass/MainCategoryModelClass.dart';

class AddJucieCategory extends StatelessWidget {
  String juicefrom;
  String jucieoldid;

  AddJucieCategory({super.key,required this.juicefrom,required this.jucieoldid});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            appbarbkgd,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: SizedBox(
            height: 49,
            width: width / 1.1,
            child: Consumer<Mainprovider>(builder: (context, value, child) {
              return   value.jucieloader?CircularProgressIndicator(color: cgreen,):
            FloatingActionButton(
              onPressed: () {
                final FormState? form = _formKey.currentState;
                if (form!.validate()) {

                if(juicefrom=="NEW"){
                  value.addJucieCategory(context,juicefrom,"");

                  back(context);
                }else{
                  value.addJucieCategory(context,juicefrom,jucieoldid);

                  back(context);
                }

                  }

              },
              elevation: 0,
              backgroundColor: cgreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              child: text(
                "Save",
                FontWeight.w700,
                cWhite,
                18,
              ),
            );
          }),
        ),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              back(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: cgreen,
              size: 24,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,

          title: text(
            "Add Fouzy Jucies Types",
            FontWeight.w700,
            cgreen,
            18,
          ),
        ),
        body:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height*0.2,),
                Consumer<Mainprovider>(
                  builder: (context,value,child) {
                    return textfield(
                        TextInputType.text, "enter your juice Category ", "Category",value.juciecategoryCt);

                  }
                ),
                // SizedBox(
                //   width: width / 1.5,
                //   child: Consumer<Mainprovider>(
                //       builder: (context, value, child) {
                //         return Autocomplete<MainCategory>(
                //           optionsBuilder:
                //               (TextEditingValue textEditingValue) {
                //             return value.mainCategorylist
                //                 .where((MainCategory item) => item.name
                //                 .toLowerCase()
                //                 .contains(
                //                 textEditingValue.text.toLowerCase()))
                //                 .toList();
                //           },
                //           displayStringForOption: (MainCategory option) =>
                //           option.name,
                //           fieldViewBuilder: (BuildContext context,
                //               TextEditingController
                //               fieldTextEditingController,
                //               FocusNode fieldFocusNode,
                //               VoidCallback onFieldSubmitted) {
                //             WidgetsBinding.instance.addPostFrameCallback((_) {
                //               fieldTextEditingController.text =
                //                   value.MainCategoryjucieyCt.text;
                //             });
                //
                //             return SizedBox(
                //               child: TextFormField(
                //                 maxLines: null,
                //                 decoration: InputDecoration(
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 16, horizontal: 14),
                //                   hintStyle: TextStyle(
                //                       color:cBlack.withOpacity(0.6),
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.bold),
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(30),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(30.0),
                //                     borderSide:  BorderSide(
                //                       color: cWhite,
                //                     ),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(30.0),
                //                     borderSide:  BorderSide(
                //                       color:cWhite,
                //                       width: 1,
                //                     ),
                //                   ),
                //                   hintText: "Select a category",
                //                   suffixIcon:  Icon(
                //                     Icons.keyboard_arrow_down_sharp,
                //                     size: 25,
                //                     color: cBlack,
                //                   ),
                //                 ),
                //                 onChanged: (txt) {
                //
                //                 },
                //                 controller: fieldTextEditingController,
                //                 focusNode: fieldFocusNode,
                //                 validator: (value) {
                //                   if (value!.isEmpty) {
                //                     return "This field is Required";
                //                   } else {
                //
                //                   }
                //                 },
                //               ),
                //             );
                //           },
                //           onSelected: (MainCategory selection) {
                //             value.MainCategoryjucieyCt.text = selection.name;
                //             value.selectedmaincategoryjucie = selection.id;
                //             print(selection.id + "asdfg");
                //           },
                //           optionsViewBuilder: (BuildContext context,
                //               AutocompleteOnSelected<MainCategory> onSelected,
                //               Iterable<MainCategory> options) {
                //             return Align(
                //               alignment: Alignment.topLeft,
                //               child: Material(
                //                 child: Container(
                //                   width: 200,
                //                   height: 300,
                //                   color:cWhite,
                //                   child: ListView.builder(
                //                     padding: const EdgeInsets.all(10.0),
                //                     itemCount: options.length,
                //                     itemBuilder:
                //                         (BuildContext context, int index) {
                //                       final MainCategory option =
                //                       options.elementAt(index);
                //
                //                       return GestureDetector(
                //                         onTap: () {
                //                           onSelected(option);
                //                         },
                //                         child: Container(
                //                           color: cWhite,
                //                           height: 50,
                //                           width: 200,
                //                           child: Column(
                //                               crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                               children: [
                //                                 Text(option.name,
                //                                     style: const TextStyle(
                //                                         fontWeight:
                //                                         FontWeight.bold)),
                //                                 const SizedBox(height: 10)]),
                //                         ),
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       }),
                // ),
              ],
            ),
          ),
        ) ,


      ),
    );
  }
}
