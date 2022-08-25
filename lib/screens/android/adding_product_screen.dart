//* dart imports --->
import 'dart:io';
import 'dart:math';

//*flutter package imports -------->
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_compress/video_compress.dart';

//* defferent dart file imports----->
import '../../theme/style.dart';
import '../android/image_preivew_screen.dart';
import '../android/video_preview_screen.dart';

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
//
//
//* random variables ------------------->
  var fileUploadButtonText = 'Upload File';
  var uploadFileIcon = Icons.file_copy;
  bool isSelectionMode = false;
  var color = Colors.white;
  int? countryIndex;
  var isFormComplete = false;
  var isReviewPage = false;
  var videoButtonText = 'Add Video';
  var isVideoButtonHight = false;
  var showDeleteWidget = false;
  //
  //
  //* product form variables ---------------->
  var productTitle = '';
  var productShortDescription = '';
  var deliveryTime = '';
  var dropDownValue = 'min';
  List<File> savedImagesLists = [];
  var selectedCountryName = '';
  var isReadyToShip = false;
  var regularPrice = '';
  var discountPercent = '';
  var couponCode = '';
  var couponDiscountPercent = '';
  File? video;
  File? videoThumnail;
  //
  //
//* product form textfield controllers -------------------->
//! if you remove contollers form textfield than textfeild values remove automatically when you scroll down or up
//
  final titleController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final regularPriceController = TextEditingController();
  final discountContoller = TextEditingController();
  final couponController = TextEditingController();
  final couponDiscountPersentController = TextEditingController();
//
//
//?####################################### end commons Variables ###############################
//
//
//
//*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ start all animations variables @@@@@@@@@@@@@@@@@@@@@@@@@@
  AnimationController? categoryController;
  Animation? catagoryTextColorAnim;
  //
  //*this is for upload product image or videos button animations
  //
  AnimationController? uploadImageButtonController;
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
  //
  //
  //* this is review page animations
  AnimationController? reviewPageController;
  Animation<double>? reviewPageAnimation;
  //
  //
  //* this is the video button animation
  AnimationController? videoButtonTextController;
  Animation<double>? videoButtonTextAnimation;
//?#################################### end all animations variabes ############################
//
//
//*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ all lists @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
  List<File> imageLists = [];

//?#################################### end all lists #################################
  //
  //
  //*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ own methods @@@@@@@@@@@@@@@@@@@@@@@@
  //
  //
  //* this is for pick image ---------->
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      imageLists = result.paths.map((path) {
        setState(() {
          savedImagesLists.add(File(path!));
          uploadImageButtonController!.forward();
        });

        return File(path!);
      }).toList();
    }
  }

//
//
//* this is for pick video-------->
  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        result.files.single.path!,
      );
      setState(() {
        isVideoButtonHight = true;
        videoThumnail = thumbnailFile;
        video = File(result.files.single.path!);
      });
      videoButtonTextController!.forward();
    }
  }

//
//
//* this is remove selected image form "savedImageLists"--->
  void removeSelectedImage() {
    setState(() {
      savedImagesLists.removeWhere((files) {
        return selectedFiles.contains(files);
      });
    });
  }

//
//
//?##################################end own methods #####################################
  //
  //
  //*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ flutter default methods @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @override
  void initState() {
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
    uploadImageButtonController = AnimationController(
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
    ).animate(uploadImageButtonController!);
//
//
//* this animation for upload file text convert to add more text
//
//
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
//
//
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
//
//
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
//
//* this is for 2nd delete button animation
//
//
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
//
//
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
//
//
//* this is for review page animations
//
//
    reviewPageController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..addListener(() {
        setState(() {});
      });
    reviewPageAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(reviewPageController!);
//
//
//* this is for the video button animation
//
//
    videoButtonTextController = AnimationController(
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
          if (isVideoButtonHight) {
            setState(() {
              videoButtonText = 'Change Video';
            });
          } else {
            setState(() {
              videoButtonText = 'Add Video';
            });
          }

          videoButtonTextController!.reverse();
        }
      });
    videoButtonTextAnimation = Tween<double>(begin: 0.0, end: 85.0).animate(
      CurvedAnimation(
        parent: videoButtonTextController!,
        curve: Curves.bounceOut,
      ),
    );

    super.initState();
  }

//
//
  @override
  void dispose() {
    categoryController!.dispose();
    uploadImageButtonController!.dispose();
    uploadFileTextController!.dispose();
    uploadFileIconController!.dispose();
    deleteButtonOneController!.dispose();
    deleteButtonTwoController!.dispose();
    videoButtonTextController!.dispose();

    super.dispose();
  }
  //?############################################# end of flutter  default methods ##########################

  @override
  Widget build(BuildContext context) {
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%% show next button (floating action button)  %%%%%%%%%%%%%%%%
    if (productTitle.isNotEmpty &&
        productShortDescription.isNotEmpty &&
        deliveryTime.isNotEmpty &&
        selectedCategorys.isNotEmpty &&
        savedImagesLists.isNotEmpty &&
        selectedCountryName.isNotEmpty &&
        regularPrice.isNotEmpty) {
      setState(() {
        isFormComplete = true;
      });
    } else {
      setState(() {
        isFormComplete = false;
      });
    }
//*%%%%%%%%%%%%%%  END - show next button (floating action button)   %%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
//*%%%%%%%%%%%%%%%%%%%%%                 THE APP BAR                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    final appBar = AppBar(
      title: Text(
        isReviewPage ? 'Review Your Selection\'s' : 'Add Your Products',
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

                if (savedImagesLists.isEmpty) {
                  uploadImageButtonController!.reverse();
                }
                Style.toast(message: 'Remove Form List', context: context);
              },
              icon: Icon(
                Icons.delete_forever,
                size: deleteTwoAnimation!.value,
              ),
            ),
          ),
      ],
    );
//*%%%%%%%%%%%%%%%%%%%%%%%%%%                 END APP BAR                   %%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%                        SCREEN HIGHT AND WIDTH                  %%%%%%%%%%%%%%%%%%%%%%%%%
    final screenHight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final screenWidth = MediaQuery.of(context).size.width;
//*%%%%%%%%%%%%%%%%%%%%                    END SCREEN HIGHT AND WIDTH                  %%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
//
    return Scaffold(
      appBar: appBar,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%                             ENTER PRODUCT TITLE                          %%%%%%%%%%%%%%%%%%%%%%%%%
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
                        controller: titleController),
//* %%%%%%%%%%%%%%%%%%                               END ENTER PRODUCT TITLE                           %%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%                     ENTER PRODUCT SHORT DESCRIPTION             %%%%%%%%%%%%%%%%%%%%%%
                    requiredTexts(
                        text: 'Enter a short description about your product'),
                    requireTextOrTextFieldGap(),
                    textField(
                      controller: shortDescriptionController,
                      hintText: 'this is a meetion gaming...',
                      isDescriptionTextField: true,
                      onChange: (value) {
                        setState(() {
                          productShortDescription = value;
                        });
                      },
                      textInputType: TextInputType.multiline,
                    ),
//*%%%%%%%%%%%%%%%%%                        END PRODUCT SHORT DESCRIPTION                 %%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//*%%%%%%%%%%%%%%%%%%%%                ENTER DELIVERY TIME                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                                  controller: deliveryTimeController,
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
                                  color: Style.isDark
                                      ? Colors.white
                                      : Colors.black,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
//*%%%%%%%%%%%%%%%%%%%%%                  END ENTER DELIVERY TIME                  %%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 20,
                    ),
//
//
//
//
//
//*%%%%%%%%%%%%%%%%%%                       SELECT PRODUCT CATAGORY                     %%%%%%%%%%%%%%%%%%%%%%%%%%
                    requiredTexts(text: 'Select product Catagory'),
                    requireTextOrTextFieldGap(),
                    GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
//*%%%%%%%%%%%%%%%%%%%%%%%                     END SELECT PRODUCT CATAGORY                      %%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 20.0,
                    ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%                     UPLOAD IMAGE                    %%%%%%%%%%%%%%%%%%%%%%%%%%
                    requiredTexts(text: 'Upload product images'),
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
                                offset:
                                    Offset(uploadFileTextAnimation!.value, 0.0),
                                child: TextButton(
                                  onPressed: pickImage,
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
                                offset:
                                    Offset(uploadFileIconAnimation!.value, 0.0),
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
                      child: savedImagesLists.isNotEmpty
                          ? GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 3 / 2,
                                mainAxisExtent: 110,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 5,
                              ),
                              children: savedImagesLists.map((photoOrVidoes) {
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
//
//* this is for the photo view --------------->
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
                                              deleteButtonOneController!
                                                  .reverse();
                                            }
                                          }
                                        });
                                      } else {
                                        int photoIndexNum = savedImagesLists
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
                                          tag: savedImagesLists.indexOf(
                                            photoOrVidoes,
                                          ),
                                          child: Image.file(
                                            photoOrVidoes,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (selectedFiles
                                            .contains(photoOrVidoes))
                                          const Icon(
                                            Icons.check_circle,
                                            color: Style.defaultColor,
                                          ),
                                      ],
                                    ),
                                  );
                                }
                                //
                                //
                                return Container();
                              }).toList(),
                            )
                          : null,
                    ),
//* %%%%%%%%%%%%%%%%%%%%%%%%%%%%                     END UPLOAD IMAGE                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 10.0,
                    ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%%                SELECT YOUR COUNTRY              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                              offset:
                                  countryName.indexOf(countries) == countryIndex
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
                                    countryIndex =
                                        countryName.indexOf(countries);
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
                                                      : countries.contains(
                                                              'Bangladesh')
                                                          ? 'assets/images/bd_flag.png'
                                                          : countries.contains(
                                                                  'India')
                                                              ? 'assets/images/india_flag.png'
                                                              : countries
                                                                      .contains(
                                                                          'Italy')
                                                                  ? 'assets/images/itly_flag.png'
                                                                  : countries.contains(
                                                                          'Japan')
                                                                      ? 'assets/images/japan_flag.png'
                                                                      : countries
                                                                              .contains('Malasia')
                                                                          ? 'assets/images/malasia_flag.png'
                                                                          : countries.contains('Pakistan')
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
//* %%%%%%%%%%%%%%%%%%%%%%%%%%             END SELECT YOUR COUNTRY            %%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 15.0,
                    ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%                  SELECT PRODUCT CURRENT STATUS                %%%%%%%%%%%%%%%%%%%%%%%%%
                    const Text(
                      'please selected  product current status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        fontFamily: Style.corbel,
                      ),
                    ),
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
                    //* %%%%%%%%%%%%%%%%%%%%%%%%%%%%                END PRODUCT CURRENT STATUS              %%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 20.0,
                    ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%%               ADD VIDEO FOR PRODUCT               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    const Text(
                      'Add video for this product',
                      style: TextStyle(
                        fontFamily: Style.corbel,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        side: const BorderSide(
                          color: Style.defaultColor,
                          width: 0.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: isVideoButtonHight ? 50 : 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: pickVideo,
                          label: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(
                                  videoButtonTextAnimation!.value / 180 * pi),
                            child: Text(
                              videoButtonText,
                              style: const TextStyle(
                                fontFamily: Style.ard,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.video_collection_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    if (video != null)
                      InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {},
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((ctx) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.delete,
                                ),
                                title: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    video = null;
                                    isVideoButtonHight = false;
                                  });
                                  videoButtonTextController!.forward();
                                  Style.toast(
                                      message: 'Delete', context: context);
                                  Navigator.of(ctx).pop();
                                },
                              );
                            }),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return VideoPreviewScreen(video!);
                                  },
                                ));
                              },
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                    maxWidth: double.infinity,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                    child: Image.file(
                                      videoThumnail!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.play_arrow,
                              size: 60,
                              color: Style.defaultColor,
                            ),
                          ],
                        ),
                      ),
//* %%%%%%%%%%%%%%%%%%%%%%%%%%%%               END ADD VIDEO FOR THIS PRODUCT                   %%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    const SizedBox(
                      height: 15.0,
                    ),
//
//
//
//
//
//*%%%%%%%%%%%%%%%%%%%%%%%%%            SET PRICE TO PRODUCT        %%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        controller: regularPriceController,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('Add Discount Persent(optional) : '),
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
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Flexible(
                                    child: textField(
                                      controller: discountContoller,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      controller: couponController,
                                      hintText: 'EX. : Fx?7EZzRy',
                                      isDescriptionTextField: false,
                                      textInputType: TextInputType.text,
                                      onChange: (value) {
                                        setState(() {
                                          couponCode = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              if (couponCode.isNotEmpty)
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text('Add Coupon Discount Percent : '),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            'buyer\'s can get this percent of discount by apply coupon code',
                                            style: TextStyle(
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150.0,
                                          child: Text(
                                            'note : you can change this value later also',
                                            style: TextStyle(
                                              fontSize: 9.0,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Flexible(
                                      child: textField(
                                        controller:
                                            couponDiscountPersentController,
                                        hintText: 'EX. : 25',
                                        isDescriptionTextField: false,
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          setState(() {
                                            couponDiscountPercent = value;
                                          });
                                        },
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
                            ],
                          ),
                        ),
                      ),
                    ),
//* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                END SET PRICE TO PRODUCT                %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                  ],
                ),
              ],
            ),
          ),
//
//
//
//
//
//
//! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                        REVIEW ENTERED DETAILS                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          if (isReviewPage)
            Transform.scale(
              scale: reviewPageAnimation!.value,
              child: Container(
                height: screenHight * 0.95,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  border: Border.all(
                    color: Style.defaultColor,
                    width: 0.5,
                  ),
                  color: Style.isDark
                      ? const Color.fromARGB(255, 24, 24, 24).withOpacity(
                          0.99,
                        )
                      : const Color.fromARGB(255, 235, 235, 235).withOpacity(
                          0.99,
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ListView(
                          children: [
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%%%                    TITLE                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Title : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  productTitle,
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%%%                   END TITLE              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%                  SHORT DESCRIPTION             %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'short description : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    productShortDescription,
                                    style: const TextStyle(
                                      fontFamily: Style.corbel,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%                       END SHORT DESCRIPTION                %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%                  DELIVERY TIME             %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'delivery time : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '$deliveryTime $dropDownValue',
                                    style: const TextStyle(
                                      fontFamily: Style.corbel,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%                  END DELIVERY TIME              %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%                  PRODUCT CATAGORY             %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'product catagory\'s : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 170,
                                  child: Text(
                                    selectedCategorys
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    style: const TextStyle(
                                      fontFamily: Style.corbel,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%                  END  PRODUCT CATAGORY             %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           PRODUCT IMAGES                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'photos : ',
                                      style: TextStyle(
                                        fontFamily: Style.corbel,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 5,
                                    mainAxisExtent: 100,
                                  ),
                                  shrinkWrap: true,
                                  children:
                                      savedImagesLists.map((imageAndVideos) {
                                    if (imageAndVideos.path.endsWith('.jpg') ||
                                        imageAndVideos.path.endsWith('.JPG') ||
                                        imageAndVideos.path.endsWith('.png') ||
                                        imageAndVideos.path.endsWith('.PNG') ||
                                        imageAndVideos.path.endsWith('.jpeg') ||
                                        imageAndVideos.path.endsWith('.JPEG') ||
                                        imageAndVideos.path.endsWith('.gif') ||
                                        imageAndVideos.path.endsWith('.GIF') ||
                                        imageAndVideos.path.endsWith('.tif') ||
                                        imageAndVideos.path.endsWith('.TIF') ||
                                        imageAndVideos.path.endsWith('.tiff') ||
                                        imageAndVideos.path.endsWith('.TIFF')) {
                                      return InkWell(
                                        child: Image.file(imageAndVideos),
                                      );
                                    }
                                    return Container();
                                  }).toList(),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%                  END PRODUCT IMAGES             %%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 5.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           PRODUCT VIDEO               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Video : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: 200,
                                        maxWidth: screenWidth,
                                      ),
                                      child: Image.file(videoThumnail!),
                                    ),
                                    const Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END PRODUCT VIDEO              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           COUNTRY              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'country : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  selectedCountryName,
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END  COUNTRY              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           READY TO SHIP              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'Ready To Ship : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  isReadyToShip ? 'Yes' : 'No',
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END READY TO SHIP              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           REGULAR PRICE              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'Regular Price : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  '$regularPrice\$',
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END REGULAR PRICE              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           DISCOUNT PERCENT               %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'Discount Persent : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  discountPercent.isEmpty
                                      ? 'N/A'
                                      : '$discountPercent%',
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END DISCOUNT PERCENT              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           COUPON CODE              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'Coupon Code : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  couponCode.isEmpty ? 'N/A' : couponCode,
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END COUPON CODE              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                            const SizedBox(
                              height: 10.0,
                            ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           COUPON CODE PERSENT              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Row(
                              children: [
                                const Text(
                                  'Coupon Code Percent : ',
                                  style: TextStyle(
                                    fontFamily: Style.corbel,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  couponDiscountPercent.isEmpty
                                      ? 'N/A'
                                      : '$couponDiscountPercent%',
                                  style: const TextStyle(
                                    fontFamily: Style.corbel,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           END COUPON CODE PERCENT              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                          ],
                        ),
                      ),
//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           BOTTOM BUTTONS              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          submitOrResetButton(
                            isSubmit: false,
                            buttonName: 'Reset',
                            onTap: () {
                              reviewPageController!.reverse();
                              Future.delayed(
                                const Duration(
                                  milliseconds: 700,
                                ),
                              ).then(
                                (_) {
                                  setState(() {
                                    isReviewPage = false;
                                    isFormComplete = true;
                                  });
                                },
                              );
                            },
                          ),
                          submitOrResetButton(
                              isSubmit: true,
                              buttonName: 'Submit',
                              onTap: () {}),
                        ],
                      ),
//* %%%%%%%%%%%%%%%%%%%%%%%%           BOTTOM BUTTONS              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//
//
//
//
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
//
//
//* this is the floating action button for go to review page
      floatingActionButton: (isFormComplete && isReviewPage == false)
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  isReviewPage = true;
                  isFormComplete = false;
                });
                reviewPageController!.forward();
              },
              child: const Text(
                'Next',
              ),
            )
          : null,
    );
  }

//
//
//
//
//
//* %%%%%%%%%%%%%%%%%%%%%%%%           WIDGET METHODS              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
//* this is upload or reset button on review page
  GestureDetector submitOrResetButton({
    required bool isSubmit,
    required String buttonName,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 43.0,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            30.0,
          ),
          color: isSubmit ? Style.defaultColor : null,
          border: isSubmit
              ? null
              : Border.all(
                  color: Style.defaultColor,
                  width: 1.0,
                ),
        ),
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: Style.corbel,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }

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
TextField textField({
  required String hintText,
  required bool isDescriptionTextField,
  int? maxLengthForShortTextFields,
  required TextInputType textInputType,
  required Function(String value) onChange,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
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
//* %%%%%%%%%%%%%%%%%%%%%%%%           END WIDGET METHODS              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

