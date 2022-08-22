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

  var fileUploadButtonText = 'Upload File';
  var uploadFileIcon = Icons.file_copy;
  bool isSelectionMode = false;
  var color = Colors.white;
  int? countryIndex;
  var isFormComplete = false;

  //
  //
  //* form variables ----->
  var productTitle = '';
  var productShortDescription = '';
  var deliveryTime = '';
  var dropDownValue = 'min';
  var selectedCategory = '';
  List<File> savedImagesOrVidoes = [];
  var selectedCountryName = '';
  var isReadyToShip = false;
  var regularPrice = '';
  var discountPercent = '';
  var couponCode = '';

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
//
//* select your country animations
  AnimationController? countryListTileController;
  Animation<double>? countryListTileAnimation;
//?#################################### end all animations variabes ############################
//
//
//*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ all lists @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  List<File> imagesOrVideos = [];
  final List deliveryTimes = [
    'min',
    'hour',
    'days',
    'months',
  ];

  final List<String> catagorys = [
    'Home & Kitchen',
    'Beauty & PersonalCare',
    'Toys & Games',
    'Cloth',
    'Shoes',
    'Jewelry',
    'Health & BabyCare',
    'Sports',
    'Books',
    'Electronics',
  ];

  final List<String> countryName = [
    'Usa',
    'China',
    'Uk',
    'Japan',
    'Taiwan',
    'Italy',
    'Malasia',
    'Qatar',
    'Bangladesh',
    'India',
    'Pakistan',
    'Sudi Arab'
  ];
  List<String> images = [];

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

  void formCompleteOrNot() {}

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
    //
    //
    //* this is for country List Tile Animation
    countryListTileController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    countryListTileAnimation =
        Tween<double>(begin: 0.0, end: 50.0).animate(countryListTileController!)
          ..addListener(() {
            setState(() {});
          });
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
              //
              //* start of the enter title section -------------->
              requiredTexts(text: 'Enter your product title'),
              requireTextOrTextFieldGap(),
              textField(
                hintText: 'Ex. : meetion mt-m915 mouse',
                isDescriptionTextField: false,
                onChange: (value) {
                  setState(() {
                    productTitle = value;
                  });
                },
                maxLengthForShortTextFields: 50,
                textInputType: TextInputType.text,
              ),
              //
              //? end of the title section ----------------->
              //
              //*start of the short description section ---------------->
              //
              requiredTexts(
                  text: 'Enter a short description about your product'),
              requireTextOrTextFieldGap(),
              textField(
                  hintText: 'this is a meetion gaming...',
                  isDescriptionTextField: true,
                  onChange: (value) {
                    setState(() {
                      productShortDescription = value;
                    });
                  },
                  textInputType: TextInputType.multiline),
              //
              //? end of the short description section ---------------->
              //
              //*start of the "enter delivery time" section ----------->
              requiredTexts(text: 'Enter delivery time'),
              requireTextOrTextFieldGap(),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    5.0,
                  ),
                  child: Row(
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
                            onChange: (value) {
                              setState(() {
                                deliveryTime = value;
                              });
                            },
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
                ),
              ),
              //
              //? end of the "enter delivery time" section ---------------->
              const SizedBox(
                height: 20,
              ),
              //
              //
              //* start of the "Select Product Catatgory " Section ----------->
              //
              //
              requiredTexts(text: 'Select product Catagory'),
              requireTextOrTextFieldGap(),
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
                    child: Card(
                      color: selectedCategorys.contains(value)
                          ? Style.defaultColor.withOpacity(0.7)
                          : null,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          40.0,
                        ),
                        side: BorderSide(
                          color: selectedCategorys.contains(value)
                              ? Style.defaultColor
                              : Colors.grey,
                          width: 0.7,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          5.0,
                        ),
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ),
                  );
                }).toList(),
              ),
              //
              //? end of the "select product catagory" section --------------->
              //
              //
              const SizedBox(
                height: 20.0,
              ),
              //
              //
              //*start of the "Upload product images or vidoes" section ------------->
              //
              //
              requiredTexts(text: 'Upload product images or vidoes'),
              requireTextOrTextFieldGap(),
              Padding(
                padding: const EdgeInsets.all(
                  5.0,
                ),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
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
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(uploadFileIconAnimation!.value, 0.0),
                          child: Icon(
                            uploadFileIcon,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
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
                              photoOrVidoes.path.endsWith('.JPG') ||
                              photoOrVidoes.path.endsWith('.png') ||
                              photoOrVidoes.path.endsWith('.PNG') ||
                              photoOrVidoes.path.endsWith('.jpeg') ||
                              photoOrVidoes.path.endsWith('.JPEG') ||
                              photoOrVidoes.path.endsWith('.gif') ||
                              photoOrVidoes.path.endsWith('.GIF') ||
                              photoOrVidoes.path.endsWith('.tif') ||
                              photoOrVidoes.path.endsWith('.TIF') ||
                              photoOrVidoes.path.endsWith('.tiff') ||
                              photoOrVidoes.path.endsWith('.TIFF')) {
                            return InkWell(
                              onTap: () async {
                                if (isSelectionMode) {
                                  setState(() {
                                    if (!selectedFiles
                                        .contains(photoOrVidoes)) {
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
                                  int photoIndexNum = savedImagesOrVidoes
                                      .indexOf(photoOrVidoes);
                                  Navigator.of(context).pushNamed(
                                    ImagePreviewScreen.routeName,
                                    arguments: {
                                      'file': photoOrVidoes,
                                      'index': photoIndexNum,
                                    },
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
                                  Hero(
                                    tag: savedImagesOrVidoes.indexOf(
                                      photoOrVidoes,
                                    ),
                                    child: Image.file(
                                      photoOrVidoes,
                                      fit: BoxFit.cover,
                                    ),
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
              //
              //
              //? end of the "Upload product images or vidoes" section ---------------->
              //
              //
              const SizedBox(
                height: 10.0,
              ),
              //
              //
              //* start of the "select your country" section ------------------->
              //
              //
              requiredTexts(
                text: 'select  country',
              ),
              requireTextOrTextFieldGap(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: countryName.map((countries) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      if (countryName.indexOf(countries) == countryIndex)
                        const Icon(
                          Icons.check,
                          size: 28,
                          color: Color(0xFF009905),
                        ),
                      Transform.translate(
                        offset: countryName.indexOf(countries) == countryIndex
                            ? Offset(
                                countryListTileAnimation!.value,
                                0.0,
                              )
                            : const Offset(0.0, 0.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedCountryName = countries;
                              });
                              countryIndex = countryName.indexOf(countries);
                              countryListTileController!.repeat();
                            },
                            leading: SizedBox(
                              width: 50,
                              height: 35,
                              child: Image.asset(
                                countries.contains('Usa')
                                    ? 'assets/images/usa_flag.png'
                                    : countries.contains('China')
                                        ? 'assets/images/china_flag.jpg'
                                        : countries.contains('Uk')
                                            ? 'assets/images/uk_flag.png'
                                            : countries.contains('Taiwan')
                                                ? 'assets/images/taiwan_flag.jpg'
                                                : countries
                                                        .contains('Bangladesh')
                                                    ? 'assets/images/bd_flag.png'
                                                    : countries
                                                            .contains('India')
                                                        ? 'assets/images/india_flag.png'
                                                        : countries.contains(
                                                                'Italy')
                                                            ? 'assets/images/itly_flag.png'
                                                            : countries
                                                                    .contains(
                                                                        'Japan')
                                                                ? 'assets/images/japan_flag.png'
                                                                : countries.contains(
                                                                        'Malasia')
                                                                    ? 'assets/images/malasia_flag.png'
                                                                    : countries.contains(
                                                                            'Pakistan')
                                                                        ? 'assets/images/pakistan_flag.jpg'
                                                                        : countries.contains('Qatar')
                                                                            ? 'assets/images/qatar_flag.jpg'
                                                                            : countries.contains('Sudi Arab')
                                                                                ? 'assets/images/sudi_flag.png'
                                                                                : 'assets/images/bazar_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              countries,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Style.corbel,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              //
              //
              //?end of the "select your country" section ----------------->
              //
              //
              const SizedBox(
                height: 15.0,
              ),
              //
              //
              //* start of the "please selected product current status" section ------------>
              //
              //
              //
              requiredTexts(text: 'please selected  product current status'),
              requireTextOrTextFieldGap(),
              Card(
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    50.0,
                  ),
                ),
                child: SwitchListTile(
                  activeThumbImage: const AssetImage(
                    'assets/images/ships_prd.png',
                  ),
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.5),
                  value: isReadyToShip,
                  onChanged: (value) {
                    setState(() {
                      isReadyToShip = value;
                    });
                  },
                  title: const Text(
                    'Ready To Ship',
                    style: TextStyle(
                      fontFamily: Style.corbel,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //
              //
              //? end of the "please product current status" section ---------------->
              //
              //
              const SizedBox(
                height: 15.0,
              ),
              //
              //
              //* start of the "set a price to this product " sectino -------------->
              //
              //
              requiredTexts(text: 'Set a price to this product'),
              requireTextOrTextFieldGap(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Set a Regular Price : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 150.0,
                                  child: Text(
                                    'this is the main/regular price of your product',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150.0,
                                  child: Text(
                                    'note : you can change this value late also',
                                    style: TextStyle(
                                        fontSize: 9.0, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 60.0,
                                ),
                                child: textField(
                                  hintText: 'EX. : 200',
                                  isDescriptionTextField: false,
                                  textInputType: TextInputType.number,
                                  onChange: (value) {
                                    setState(() {
                                      regularPrice = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Add Discount(optional) : '),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'buyers can buy your product by discount rate',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150.0,
                                  child: Text(
                                    'note : you can add discount rate late by edit your product',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 60.0,
                                ),
                                child: textField(
                                  hintText: 'EX. : 25',
                                  isDescriptionTextField: false,
                                  textInputType: TextInputType.number,
                                  onChange: (value) {
                                    setState(() {
                                      discountPercent = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              '%',
                              style: TextStyle(
                                fontFamily: Style.ard,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Add Coupon Code(optional) : ',
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'buyer can use this coupon code for get a discount,',
                                    style: TextStyle(
                                      fontSize: 9.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'note : you can add coupon code later by edit your product',
                                    style: TextStyle(
                                        fontSize: 9.0, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Flexible(
                                child: textField(
                              hintText: 'EX. : Fx?7EZzRy',
                              isDescriptionTextField: false,
                              textInputType: TextInputType.text,
                              onChange: (value) {
                                setState(() {
                                  couponCode = value;
                                });
                              },
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //
              //
              //? end of the "set a price to this product" section ---------------------->
            ],
          ),
        ),
        floatingActionButton: isFormComplete
            ? FloatingActionButton(
                onPressed: () {},
                child: const Text(
                  'Next',
                ),
              )
            : null);
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

//
//
//*gap between require text and TextFiled
Widget requireTextOrTextFieldGap() {
  return const SizedBox(
    height: 10.0,
  );
}
