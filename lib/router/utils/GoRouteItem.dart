// ignore_for_file: file_names
import 'package:go_router/go_router.dart';


GoRoute route(String url, dynamic page){
  return  GoRoute(
    name: url,
    path: url,
    builder: (context, state) {
      return page;
    },
  );
}
