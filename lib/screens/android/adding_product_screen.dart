import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../theme/style.dart';
import '../android/image_preivew_screen.dart';

class AddingProductScreen extends StatefulWidget {
  static const routeName = 'addingProductScreen';
  const AddingProductScreen({Key? key}) : super(key: key);

  @override
  State<AddingProductScreen> createState() => _AddingProductScreenState();
}

class _AddingProductScreenState extends State<AddingProductScreen>
    with TickerProviderStateMixin {
  //
  //
  //*@@@@@@@@@@@@@@@@@@@@@@@@@@@@ all common variables @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  var dropDownValue = 'min';
  var fileUploadButtonText = 'Upload File';
  var uploadFileIcon = Icons.file_copy;
  bool isSelectionMode = false;

//
//?####################################### end commons Variables ###############################
//

//
//*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ start all animations variables @@@@@@@@@@@@@@@@@@@@@@@@@@
  AnimationController? categoryController;
  Animation? catagoryTextColorAnim;
  //
  //*this is for upload product image or videos button animations
  //
  AnimationController? uploadImageOrVideoButtonController;
  Animation<double>? buttonHightAnimation;
  //
  //* this is for upload file button text animation
  AnimationController? uploadFileTextController;
  Animation<double>? uploadFileTextAnimation;
  //
  //* upload file button icon animation
  AnimationController? uploadFileIconController;
  Animation<double>? uploadFileIconAnimation;
  //
  //
  //*this is 1st animation for delete button
  AnimationController? deleteButtonOneController;
  Animation<double>? deleteOneAnimation;
  //
  //* this is secound animation for delete button
  AnimationController? deleteButtonTwoController;
  Animation<double>? deleteTwoAnimation;
//
//?#################################### end all animations variabes ############################
//
//
//*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ all lists @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  List<File> imagesOrVideos = [];
  List<File> savedImagesOrVidoes = [];
  List deliveryTimes = [
    'min',
    'hour',
    'days',
    'months',
  ];

  List<String> catagorys = [
    ' Home & Kitchen',
    ' Beauty & PersonalCare',
    ' Toys & Games',
    'Cloth',
    'Shoes',
    'Jewelry',
    'Health & BabyCare',
    'Sports',
    'Books',
    'Electronics',
  ];

  List<String> selectedCategorys = [];
  List<File> selectedFiles = [];

//?#################################### end all lists #################################
  //
  //
  //*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ own methods @@@@@@@@@@@@@@@@@@@@@@@@
  Future<void> pickImageOrVideo() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.media);

    if (result != null) {
      imagesOrVideos = result.paths.map((path) {
        setState(() {
          savedImagesOrVidoes.add(File(path!));
          uploadImageOrVideoButtonController!.forward();
        });

        return File(path!);
      }).toList();
    }
  }

//
//
  void removeSelectedImage() {
    setState(() {
      savedImagesOrVidoes.removeWhere((files) {
        return selectedFiles.contains(files);
      });
    });
  }

//
//?##################################end own methods #####################################
  //
  //
  //
  //*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ flutter default methods @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @override
  void initState() {
    //
    //
    //* this is for Select Product Catagory Animation---->
    categoryController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    catagoryTextColorAnim =
        ColorTween(begin: Colors.white, end: Colors.black).animate(
      CurvedAnimation(
        parent: categoryController!,
        curve: Curves.easeInBack,
      ),
    );

    catagoryTextColorAnim!.addListener(() {
      setState(() {});
    });

    //
    //
    //* this is for Upload Image Or Video Button Animations
    uploadImageOrVideoButtonController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          uploadFileTextController!.forward();
          uploadFileIconController!.forward();
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            fileUploadButtonText = 'Upload File';
            uploadFileIcon = Icons.file_copy;
          });
        }
      });
    buttonHightAnimation = Tween<double>(
      begin: 150,
      end: 40,
    ).animate(uploadImageOrVideoButtonController!);

//
//
//
//* this animation for upload file text convert to add more text

    uploadFileTextController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          uploadFileTextController!.reverse();
          setState(() {
            fileUploadButtonText = 'Add More';
          });
        }
      });

    uploadFileTextAnimation =
        Tween<double>(begin: 0.0, end: -200).animate(uploadFileTextController!);

    //*this is for upload file button icon changes animation
    //
    //
    uploadFileIconController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          uploadFileIconController!.reverse();
          setState(() {
            uploadFileIcon = Icons.add_a_photo_outlined;
          });
        }
      });
    uploadFileIconAnimation = Tween<double>(
      begin: 0.0,
      end: 200,
    ).animate(uploadFileIconController!);

    //
    //
    //* this is for 1st delete button animation
    deleteButtonOneController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          deleteButtonTwoController!.repeat();
        }
      });
    deleteOneAnimation = Tween<double>(begin: -200, end: 0.0)
        .animate(deleteButtonOneController!);
    //
    //* this is for 2nd delete button animation
    deleteButtonTwoController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    )..addListener(() {
        setState(() {});
      });
    deleteTwoAnimation = Tween<double>(begin: 24.0, end: 35).animate(
        CurvedAnimation(
            parent: deleteButtonTwoController!, curve: Curves.bounceIn));
    super.initState();
  }

  //
  //
  @override
  void dispose() {
    categoryController!.dispose();
    uploadImageOrVideoButtonController!.dispose();
    uploadFileTextController!.dispose();
    uploadFileIconController!.dispose();
    deleteButtonOneController!.dispose();
    deleteButtonTwoController!.dispose();

    super.dispose();
  }
  //?############################################# end of flutter  default methods ##########################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Your Products',
        ),
        actions: [
          if (isSelectionMode)
            Transform.translate(
              offset: Offset(deleteOneAnimation!.value, 0.0),
              child: IconButton(
                onPressed: () async {
                  removeSelectedImage();
                  setState(() {
                    selectedFiles.clear();
                  });
                  deleteButtonTwoController!.stop();
                  deleteButtonOneController!.reverse();
                  Future.delayed(const Duration(milliseconds: 500)).then((_) {
                    setState(() {
                      isSelectionMode = false;
                    });
                  });

                  if (savedImagesOrVidoes.isEmpty) {
                    uploadImageOrVideoButtonController!.reverse();
                  }
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: deleteTwoAnimation!.value,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            requiredTexts(text: 'Enter your product title'),
            textField(
              hintText: 'Ex. : meetion mt-m915 mouse',
              isDescriptionTextField: false,
              onChange: (value) {},
              maxLengthForShortTextFields: 50,
              textInputType: TextInputType.text,
            ),
            requiredTexts(text: 'Enter a short description about your product'),
            textField(
                hintText: 'this is a meetion gaming...',
                isDescriptionTextField: true,
                onChange: (value) {},
                textInputType: TextInputType.multiline),
            requiredTexts(text: 'Enter delivery time'),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 75,
                    child: textField(
                      hintText: 'EX. : 5',
                      isDescriptionTextField: false,
                      maxLengthForShortTextFields: 10,
                      onChange: (value) {},
                      textInputType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Text(
                    ':',
                    style: TextStyle(
                      fontFamily: Style.ard,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: DropdownButton(
                    underline: Container(
                      width: double.infinity,
                      height: 2.0,
                      color: Style.defaultColor,
                    ),
                    isDense: true,
                    style: const TextStyle(
                      fontFamily: Style.corbel,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Style.isDark ? Colors.white : Colors.black,
                    ),
                    icon: const Icon(
                      Icons.expand_more_rounded,
                      color: Style.defaultColor,
                    ),
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    value: dropDownValue,
                    items: deliveryTimes.map((items) {
                      return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: items,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                items,
                              ),
                              const SizedBox(
                                width: 3.0,
                              ),
                              const Icon(Icons.timelapse_sharp),
                            ],
                          ));
                    }).toList(),
                    onChanged: ((items) {
                      setState(() {
                        dropDownValue = items.toString();
                      });
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            requiredTexts(text: 'Select product Catagory'),
            const SizedBox(
              height: 10.0,
            ),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 5,
                mainAxisExtent: 40,
              ),
              children: catagorys.map((value) {
                return InkWell(
                  onTap: () {
                    if (!selectedCategorys.contains(value)) {
                      setState(() {
                        selectedCategorys.add(value);
                        categoryController!.repeat();
                      });
                    } else {
                      setState(() {
                        selectedCategorys.remove(value);
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(40.0),
                  highlightColor: Style.defaultColor.withOpacity(0.5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedCategorys.contains(value)
                          ? Style.defaultColor.withOpacity(0.7)
                          : null,
                      borderRadius: BorderRadius.circular(
                        40.0,
                      ),
                      border: Border.all(
                        color: selectedCategorys.contains(value)
                            ? Style.defaultColor
                            : Colors.grey,
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedCategorys.contains(value)
                              ? catagoryTextColorAnim!.value
                              : Colors.grey,
                          fontFamily: Style.corbel,
                          // fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            requiredTexts(text: 'Upload product images or vidoes'),
            Padding(
              padding: const EdgeInsets.all(
                5.0,
              ),
              child: Container(
                alignment: Alignment.center,
                height: buttonHightAnimation!.value,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  border: Border.all(
                    color: Style.defaultColor,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(uploadFileTextAnimation!.value, 0.0),
                      child: TextButton(
                        onPressed: pickImageOrVideo,
                        child: Text(
                          fileUploadButtonText,
                          style: const TextStyle(
                            fontFamily: Style.ard,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                              255,
                              65,
                              65,
                              65,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(uploadFileIconAnimation!.value, 0.0),
                      child: Icon(
                        uploadFileIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: savedImagesOrVidoes.isNotEmpty
                  ? GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3 / 2,
                        mainAxisExtent: 150,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 5,
                      ),
                      children: savedImagesOrVidoes.map((photoOrVidoes) {
                        if (photoOrVidoes.path.endsWith('.jpg') ||
                            photoOrVidoes.path.endsWith('.png')) {
                          return InkWell(
                            onTap: () async {
                              if (isSelectionMode) {
                                setState(() {
                                  if (!selectedFiles.contains(photoOrVidoes)) {
                                    selectedFiles.add(photoOrVidoes);
                                  } else {
                                    selectedFiles.remove(photoOrVidoes);
                                    if (selectedFiles.isEmpty) {
                                      Future.delayed(
                                        const Duration(
                                          milliseconds: 500,
                                        ),
                                      ).then(
                                        (_) {
                                          setState(() {
                                            isSelectionMode = false;
                                          });
                                        },
                                      );

                                      deleteButtonTwoController!.stop();
                                      deleteButtonOneController!.reverse();
                                    }
                                  }
                                });
                              } else {
                                Navigator.of(context).pushNamed(
                                  ImagePreviewScreen.routeName,
                                  arguments: photoOrVidoes,
                                );
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                selectedFiles.add(photoOrVidoes);
                                isSelectionMode = true;
                              });
                              deleteButtonOneController!.forward();
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  photoOrVidoes,
                                  fit: BoxFit.cover,
                                ),
                                if (selectedFiles.contains(photoOrVidoes))
                                  const Icon(
                                    Icons.check_circle,
                                    color: Style.defaultColor,
                                  ),
                              ],
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            if (isSelectionMode) {
                              setState(() {
                                if (!selectedFiles.contains(photoOrVidoes)) {
                                  selectedFiles.add(photoOrVidoes);
                                } else {
                                  selectedFiles.remove(photoOrVidoes);
                                  if (selectedFiles.isEmpty) {
                                    Future.delayed(const Duration(seconds: 1))
                                        .then(
                                      (_) {
                                        setState(() {
                                          isSelectionMode = false;
                                        });
                                      },
                                    );

                                    deleteButtonTwoController!.stop();
                                    deleteButtonOneController!.reverse();
                                  }
                                }
                              });
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              selectedFiles.add(photoOrVidoes);
                              isSelectionMode = true;
                            });
                            deleteButtonOneController!.forward();
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 150,
                                color: Colors.green,
                                child: const Text('video'),
                              ),
                              if (selectedFiles.contains(photoOrVidoes))
                                const Icon(
                                  Icons.check_circle,
                                  color: Style.defaultColor,
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  //
  ///
  //
  //
  //* -------------------------------- All Widget Methods Start Form Here---------------->

//
//
//
//
//* required text method
//* this widget for knowing user to this form are must be entered
  RichText requiredTexts({required String text}) {
    return RichText(
      text: TextSpan(
        text: '$text ',
        style: const TextStyle(
          color: Style.isDark ? Colors.white : Colors.black,
          fontFamily: Style.corbel,
          fontWeight: FontWeight.bold,
        ),
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
              fontFamily: Style.ard,
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//
//
//* ---------------------- text field for user input -------------------->
TextField textField(
    {required String hintText,
    required bool isDescriptionTextField,
    int? maxLengthForShortTextFields,
    required TextInputType textInputType,
    required Function(String value) onChange}) {
  return TextField(
    keyboardType: textInputType,
    onChanged: onChange,
    maxLength: isDescriptionTextField ? 200 : maxLengthForShortTextFields,
    maxLines: isDescriptionTextField ? 15 : 1,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: Style.ard,
        color: Colors.grey.withOpacity(0.7),
      ),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          isDescriptionTextField ? 10 : 30.0,
        ),
        borderSide: const BorderSide(
          color: Style.defaultColor,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          isDescriptionTextField ? 10 : 30.0,
        ),
        borderSide: const BorderSide(
          color: Style.defaultColor,
          width: 1.0,
        ),
      ),
    ),
  );
}
