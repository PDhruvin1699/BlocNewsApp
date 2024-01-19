// import 'dart:io';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../model/article_model.dart';
//
// class YourCardWidget extends StatelessWidget {
//   final ArticleModel? article;
//   final VoidCallback onMorePressed;
//
//   YourCardWidget({required this.article, required this.onMorePressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 7,
//       margin: EdgeInsets.all(7.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           FutureBuilder<bool>(
//             future: _isOnline(),
//             builder: (context, snapshot) {
//               final isOnline = snapshot.hasData && snapshot.data == true;
//
//               Widget imageWidget;
//
//               if (isOnline) {
//                 imageWidget = Image.network(
//                   article?.urlToImage ?? '',
//                   height: 150.0,
//                   fit: BoxFit.cover,
//                   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                     return _buildErrorImage();
//                   },
//                 );
//               } else {
//                 imageWidget = FutureBuilder<String>(
//                   future: _getOfflineImagePath(article?.urlToImage ?? ''),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done) {
//                       final String offlineImagePath = snapshot.data ?? '';
//                       return Image.file(
//                         File(offlineImagePath),
//                         height: 150.0,
//                         fit: BoxFit.cover,
//                       );
//                     } else {
//                       return _buildShimmerPlaceholder();
//                     }
//                   },
//                 );
//               }
//
//               return ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8.0),
//                   topRight: Radius.circular(8.0),
//                 ),
//                 child: isOnline ? _buildDelayedImage(imageWidget) : _buildShimmerPlaceholder(),
//               );
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               article?.title ?? 'No title available',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: onMorePressed,
//                 child: Row(
//                   children: [
//                     Text(
//                       'More',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: 150.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8.0),
//             topRight: Radius.circular(8.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorImage() {
//     return Container(
//       color: Colors.white38,
//       height: 150.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Image.asset(
//               'images/no-image-icon-23494.png',
//             ),
//           ),
//           Center(
//             child: Text('No image'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDelayedImage(Widget imageWidget) {
//     return FutureBuilder<bool>(
//       future: Future.delayed(Duration(seconds: 2), () => true),
//       builder: (context, snapshot) {
//         return snapshot.connectionState == ConnectionState.done ? imageWidget : _buildShimmerPlaceholder();
//       },
//     );
//   }
//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> _getOfflineImagePath(String onlineImagePath) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String fileName = onlineImagePath.split('/').last;
//     return '${appDocDir.path}/images/$fileName';
//   }
// // ... (rest of the code remains unchanged)
// }

///WOrking code
//
// import 'dart:io';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../model/article_model.dart';
//
// class YourCardWidget extends StatelessWidget {
//   final ArticleModel? article;
//   final VoidCallback onMorePressed;
//   final double textSize;
//   YourCardWidget({required this.article, required this.onMorePressed, required this.textSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 7,
//       margin: EdgeInsets.all(7.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildPhotoViewGallery(context),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               article?.title ?? 'No title available',
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: textSize,
//                 fontWeight: FontWeight.bold,
//
//               ),
//             //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//              ),
//
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: onMorePressed,
//                 child: Row(
//                   children: [
//                     Text(
//                       'More',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPhotoViewGallery(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _isOnline(),
//       builder: (context, snapshot) {
//         final isOnline = snapshot.hasData && snapshot.data == true;
//
//         if (isOnline) {
//           return Container(
//             height: 200.0, // Set a fixed height for the container
//             child: PhotoViewGallery.builder(
//               itemCount: 1,
//               builder: (context, index) {
//                 return PhotoViewGalleryPageOptions(
//                   imageProvider: NetworkImage(article?.urlToImage ?? ''),
//                   minScale: PhotoViewComputedScale.contained,
//                   maxScale: PhotoViewComputedScale.covered * 2,
//                 );
//               },
//               scrollPhysics: BouncingScrollPhysics(),
//               backgroundDecoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//             ),
//           );
//         } else {
//           return FutureBuilder<String>(
//             future: _getOfflineImagePath(article?.urlToImage ?? ''),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 final String offlineImagePath = snapshot.data ?? '';
//                 return Container(
//                   height: 200.0, // Set a fixed height for the container
//                   child: PhotoViewGallery.builder(
//                     itemCount: 1,
//                     builder: (context, index) {
//                       return PhotoViewGalleryPageOptions(
//                         imageProvider: FileImage(File(offlineImagePath)),
//                         minScale: PhotoViewComputedScale.contained,
//                         maxScale: PhotoViewComputedScale.covered * 2,
//                       );
//                     },
//                     scrollPhysics: BouncingScrollPhysics(),
//                     backgroundDecoration: BoxDecoration(
//                       color: Colors.white,
//                     ),
//                   ),
//                 );
//               } else {
//                 return _buildShimmerPlaceholder();
//               }
//             },
//           );
//         }
//       },
//     );
//   }
//
//
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: 150.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8.0),
//             topRight: Radius.circular(8.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> _getOfflineImagePath(String onlineImagePath) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String fileName = onlineImagePath.split('/').last;
//     return '${appDocDir.path}/images/$fileName';
//   }
// }
//
//
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/article_model.dart';

// ...

class YourCardWidget extends StatelessWidget {
  final ArticleModel? article;
  final VoidCallback onMorePressed;
  final double textSize;
  final BuildContext context;

  YourCardWidget({
    required this.article,
    required this.onMorePressed,
    required this.textSize,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Id ${article?.id}');
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPhotoViewGallery(context),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              article?.title ?? 'No title available',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onMorePressed,
                child: Row(
                  children: [
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  saveArticleToFirestore(article);
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Call the function to generate and share the dynamic link
                  shareDynamicLink(article);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoViewGallery(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isOnline(),
      builder: (context, snapshot) {
        final isOnline = snapshot.hasData && snapshot.data == true;

        if (isOnline) {
          return Container(
            height: 200.0,
            child: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(article?.urlToImage ?? ''),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return FutureBuilder<String>(
            future: _getOfflineImagePath(article?.urlToImage ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final String offlineImagePath = snapshot.data ?? '';
                return Container(
                  height: 200.0,
                  child: PhotoViewGallery.builder(
                    itemCount: 1,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: FileImage(File(offlineImagePath)),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return _buildShimmerPlaceholder();
              }
            },
          );
        }
      },
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
      ),
    );
  }

  void saveArticleToFirestore(ArticleModel? article) async {
    try {
      CollectionReference firestore = await FirebaseFirestore.instance
          .collection("savedArticles");
      await firestore.add({
        'title': article?.title,
        'description': article?.description,
        'url': article?.url,
        // Add other fields as needed
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Article saved successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save article $error'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save article. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<bool> _isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<String> _getOfflineImagePath(String onlineImagePath) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String fileName =
        onlineImagePath
            .split('/')
            .last;
    return '${appDocDir.path}/images/$fileName';
  }


Future<void> shareDynamicLink(ArticleModel? article) async {
  if (article == null || article.id == null) {
    // Handle the case where the article or its id is null
    return;
  }
  debugPrint("Article Id: ${article.id}");

  // Build the dynamic link with additional parameters directly in the Uri
  final Uri dynamicLink = Uri.parse(
    'https://newsdemo.page.link/article?articleId=${article.id}'
        '&title=${Uri.encodeComponent(article.title)}'
        '&author=${Uri.encodeComponent(article.author)}'
        '&description=${Uri.encodeComponent(article.description)}'
        '&url=${Uri.encodeComponent(article.url)}'
        '&urlToImage=${Uri.encodeComponent(article.urlToImage)}'
        '&publishedAt=${Uri.encodeComponent(article.publishedAt)}'
        '&content=${Uri.encodeComponent(article.content)}',

  );

  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://newsdemo.page.link',
    link: dynamicLink,
    androidParameters: AndroidParameters(
      packageName: 'com.example.newsapp',
    ),
  );

  final ShortDynamicLink shortLink =
  await FirebaseDynamicLinks.instance.buildShortLink(parameters);

  final Uri shortUrl = shortLink.shortUrl;

  debugPrint("Short Link: $shortUrl");

  final sharedText =
      '${article.title}\n\n${article.content}\n\nCheck out this article: $shortUrl';

  Share.share(sharedText);
}

  // Future<void> shareDynamicLink(ArticleModel? article) async {
  //   if (article == null || article.id == null) {
  //     // Handle the case where the article or its id is null
  //     return;
  //   }
  //   debugPrint("Article Id: ${article.id}");
  //
  //   // Build the dynamic link with additional parameters directly in the Uri
  //   final Uri dynamicLink = Uri.parse(
  //     'https://dv16.page.link/article?articleId=${article.id}'
  //         '&title=${Uri.encodeComponent(article.title)}'
  //         '&author=${Uri.encodeComponent(article.author)}'
  //         '&description=${Uri.encodeComponent(article.description)}'
  //         '&url=${Uri.encodeComponent(article.url)}'
  //         '&urlToImage=${Uri.encodeComponent(article.urlToImage)}'
  //         '&publishedAt=${Uri.encodeComponent(article.publishedAt)}'
  //         '&content=${Uri.encodeComponent(article.content)}',
  //   );
  //
  //   if (kIsWeb) {
  //     // For web, directly launch the URL
  //     if (await canLaunch(dynamicLink.toString())) {
  //       html.window.open(dynamicLink.toString(), '_blank');
  //     } else {
  //       throw 'Could not launch $dynamicLink';
  //     }
  //   } else {
  //     // For other platforms (iOS and Android), use the Share package
  //     final DynamicLinkParameters parameters = DynamicLinkParameters(
  //       uriPrefix: 'https://dv16.page.link',
  //       link: dynamicLink,
  //       androidParameters: AndroidParameters(
  //         packageName: 'com.example.newsapp',
  //       ),
  //     );
  //
  //     final ShortDynamicLink shortLink =
  //     await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //
  //     final Uri shortUrl = shortLink.shortUrl;
  //
  //     debugPrint("Short Link: $shortUrl");
  //
  //     final sharedText =
  //         '${article.title}\n\n${article.content}\n\nCheck out this article: $shortUrl';
  //
  //     Share.share(sharedText);
  //   }
  // }
}
