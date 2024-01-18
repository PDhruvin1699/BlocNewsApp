// Future<void> shareArticle(ArticleModel? article) async {
//   try {
//     await FlutterShare.share(
//       title: 'Check out this article: ${article?.title}',
//       text: article?.description,
//       linkUrl: article?.url,
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to share article. Please try again.'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }
// Future<void> shareArticle(ArticleModel? article) async {
//   final String title = 'Check out this article: ${article?.title}';
//   final String text = article?.description ?? '';
//   final String linkUrl = article?.url ?? '';
//
//   try {
//     // Try to launch the app
//     await FlutterShare.share(
//       title: title,
//       text: text,
//       linkUrl: linkUrl,
//     );
//   } catch (e) {
//     // If the app is not installed, launch the browser
//     final String url = 'https://play.google.com/store/apps/details?id=com.example.newsapp';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       // If the browser couldn't be launched, show an error
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to open the link. Please install the app.'),
//           duration: Duration(seconds: 3),
//         ),
//       );
//     }
//   }
// }
// IconButton(
// icon: Icon(Icons.share),
// onPressed: () {
// // _shareArticle(article);
// String articleTitle = article?.title ?? '';
// String articleContent = article?.description ?? '';
// String deepLink = 'https://dv16.page.link/article?id=${article?.id}';
// // String deepLink = 'https://newsapp.page.link/article/${Uri.encodeComponent(article?.title ?? 'NoTitle')}';
//
//
// // Share the article title, content, and deep link
// Share.share(
// '$articleTitle\n\n$articleContent\n\n$deepLink',
// );
// },
// ),