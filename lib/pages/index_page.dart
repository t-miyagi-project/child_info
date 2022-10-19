import 'dart:async';

import 'package:child_info/models/parks.dart';
import 'package:flutter/material.dart';

import 'package:child_info/utils/constants.dart';
import 'package:timeago/timeago.dart';

import 'package:child_info/utils/castam_theme.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'property_details_widget.dart';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageALTWidget extends StatefulWidget {
  const HomePageALTWidget({Key? key}) : super(key: key);

  //ページ遷移用
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const HomePageALTWidget(),
    );
  }

  @override
  _HomePageALTWidgetState createState() => _HomePageALTWidgetState();
}

class _HomePageALTWidgetState extends State<HomePageALTWidget> {
  //テキストをコントロールするためのもの
  TextEditingController? textController;
  double? ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //
  late final Stream<List<Parks>> _parksStream;

  @override
  void initState() {
    //認証情報
    final myUserId = supabase.auth.currentUser!.id;
    //初期で公園情報を取得
    _parksStream = supabase
        .from('parks')
        .stream(['id'])
        .order('created_at')
        .execute()
        .map((maps) => maps
            .map((map) => Parks.fromMap(map))
            .toList());

    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //「Stack」ウィジェットを重ねることができるウィジェット
            Stack(
              children: [
                // トリミング※画像などに使う
                ClipRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 370,
                      decoration: BoxDecoration(
                        color: MyTheme.of(context).tertiaryColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/hero_home@3x.jpg',
                          ).image,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 370,
                  //ボーダーラインの色系
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E2429), Color(0x001E2429)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, 1),
                      end: AlignmentDirectional(0, -1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Image.asset(
                          'assets/images/logoUpHome@3x.png',
                          width: 230,
                          height: 90,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome!',
                                    style: GoogleFonts.getFont(
                                      'Urbanist',
                                      color: MyTheme.of(context).primaryText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Find your Dream Space',
                                    style: GoogleFonts.getFont(
                                      'Urbanist',
                                      color: MyTheme.of(context).primaryText,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: MyTheme.of(context)
                                      .tertiaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                        child: TextFormField(
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText:
                                                'Address, city, state...',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    MyTheme.of(context)
                                                        .tertiaryColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    MyTheme.of(context)
                                                        .tertiaryColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            filled: true,
                                            fillColor:
                                                MyTheme.of(context)
                                                    .tertiaryColor,
                                            prefixIcon: Icon(
                                              Icons.search_sharp,
                                              color:
                                                  MyTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                          style: GoogleFonts.getFont(
                                           'Urbanist',
                                          color: MyTheme.of(context).secondaryText,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 8, 0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        text: 'Search',
                                        options: FFButtonOptions(
                                          width: 100,
                                          height: 40,
                                          color: MyTheme.of(context)
                                              .primaryColor,
                                          textStyle: GoogleFonts.getFont(
                                            'Urbanist',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          elevation: 2,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          //borderRadius:
                                          //    BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: StreamBuilder<List<Parks>>(
                stream: _parksStream,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: MyTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  //parksのデータをリストに格納
                  List<Parks> columnPropertiesRecordList =
                      snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(columnPropertiesRecordList.length,
                        (columnIndex) {
                      //1件取得?
                      final columnPropertiesRecord =
                          columnPropertiesRecordList[columnIndex];
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyTheme.of(context).tertiaryColor,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x32000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PropertyDetailsWidget(),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PropertyDetailsWidget(
                                          propertyRef: columnPropertiesRecord,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: valueOrDefault<String>(
                                      columnPropertiesRecord.mainImageUrl,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg' +
                                          '$columnIndex',
                                    ),
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          columnPropertiesRecord.mainImageUrl,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg',
                                        ),
                                        width: double.infinity,
                                        height: 190,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        columnPropertiesRecord.name,
                                        style: GoogleFonts.getFont(
                                          'Urbanist',
                                          color: MyTheme.of(context).primaryText,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        columnPropertiesRecord
                                            .zipAddress1,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: MyTheme.of(context).primaryText,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      RatingBar.builder(
                                        onRatingUpdate: (newValue) => setState(
                                            () => ratingBarValue = newValue),
                                        itemBuilder: (context, index) => const Icon(
                                          Icons.star_rounded,
                                          color: Color(0xFFFFA130),
                                        ),
                                        direction: Axis.horizontal,
                                        initialRating: ratingBarValue ??= 3,
                                        unratedColor: const Color(0xFFD6D9DB),
                                        itemCount: 5,
                                        itemSize: 20,
                                        glowColor: const Color(0xFFFFA130),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          '4/5 reviews',
                                          style: GoogleFonts.getFont(
                                            'Lexend Deca',
                                            color: MyTheme.of(context).primaryText,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class IndexPage extends StatefulWidget {
//   const IndexPage({Key? key}) : super(key: key);

//   static Route<void> route() {
//     return MaterialPageRoute(
//       builder: (context) => const IndexPage(),
//     );
//   }

//   @override
//   State<IndexPage> createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   @override
//   Widget build(BuildContext context) {
//     //画面のサイズを取得しておく
//     var screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(screenSize.width, 1000),
//         child: Container(
//           color: Colors.blue,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 const Text('EXPLORE'),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {},
//                         child: const Text(
//                           'Discover',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                       SizedBox(width: screenSize.width / 20),
//                       InkWell(
//                         onTap: () {},
//                         child: const Text(
//                           'Contact Us',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: const Text(
//                     'Sign Up',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   width: screenSize.width / 50,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Container(),
//     );
//   }
  
// }