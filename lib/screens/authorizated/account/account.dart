import 'dart:async';

import 'package:besmart_traveler/components/button.dart';
import 'package:besmart_traveler/components/divider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/router/urls.dart';
import 'package:redux/redux.dart';

import '../../../api_service/services/client_service.dart';
import '../../../components/alert.dart';
import '../../../components/container.dart';
import '../../../components/dialog.dart';
import '../../../components/loadingCircle.dart';
import '../../../components/text.dart';
import '../../../models/client/client.dart';
import '../../../models/user/User.dart';
import '../../../models/user/token.dart';
import '../../../redux/actions/auth.dart';
import '../../../redux/app_state.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Alert> alerts = [];
  bool loading = false;
  bool imageDownloaded = false;
  Completer<void> completer = Completer<void>();

  Widget image(imageUrl) {
    if (loading) {
      return const LoadingIndicator();
    }

    if (imageUrl == null) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/images/logo.png'),
      );
    }

    final image = NetworkImage(imageUrl);
    if (imageDownloaded) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: image,
      );
    } else {
      precacheImage(image, context).then((value) {
        setState(() {
          imageDownloaded = true;
        });
      });
    }

    return const LoadingIndicator();
  }

  void selectImageProfile(Store store) {
    FilePicker.platform
        .pickFiles(
            dialogTitle: 'Фотография для профиля',
            type: FileType.image,
            onFileLoading: (status) {
              if (status == FilePickerStatus.picking) {
                setState(() {
                  loading = true;
                });
              }
            })
        .then((filePickerResult) {
      if (filePickerResult == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final platformFile = filePickerResult.files.first;
      if (platformFile.size > 6 * 1024 * 1024) {
        dialog(
          context: context,
          completer: completer,
          title: 'Упс...',
          description: 'Размер картинки не должен превышать 6МБ',
          buttonAction: true,
        );
        setState(() {
          loading = false;
        });
        return;
      }

      final accessToken = store.state.token.access;

      ApiClient.changeProfileImage(
        platformFile,
        accessToken,
      ).then((response) {
        if (response == 'Error') {
          dialog(
            context: context,
            completer: completer,
            title: 'Упс...',
            description: response,
            buttonAction: true,
          );
        } else if (response.startsWith('http://')) {
          setState(() {
            store.state.client.profileImage = response;
          });
        } else {
          dialog(
            context: context,
            completer: completer,
            title: 'Упс...',
            description: response,
            buttonAction: true,
          );
        }
        setState(() {
          loading = false;
        });
      });
    });
  }

  void removeImageProfile(Store store) {
    ApiClient.removeProfileImage(store.state.token).then((value) {
      if (value == null) {
        store.state.client.profileImage = null;

        setState(() {});
      } else if (value == 'error') {
        dialog(
          context: context,
          completer: completer,
          title: 'Упс...',
          description: 'Случилась ошибка при удаление',
        );
      }
    });

    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget profileImage(String? imageUrl, Store store) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (imageUrl == null) {
            return selectImageProfile(store);
          }
          dialog(
            context: context,
            completer: completer,
            title: 'Выберите действие',
            children: [
              containerB20(
                child: buttonSm(
                  context: context,
                  text: 'Выбрать фото',
                  onPressed: () {
                    selectImageProfile(store);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
              containerB20(
                child: buttonSm(
                  context: context,
                  text: 'Удалить фото',
                  onPressed: () => removeImageProfile(store),
                ),
              ),
            ],
          );
        },
        child: Center(
          child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: imageUrl != null ? Colors.transparent : Colors.white,
              ),
              child: image(imageUrl)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Store store = StoreProvider.of<AppState>(context);

    Client client = store.state.client;
    User user = store.state.user;

    return Scaffold(
      bottomNavigationBar: bottomAppBar(
        context: context,
        currentPage: accountPage,
      ),
      body: bodyContainer(
        children: [
          containerB20(child: profileImage(client.profileImage, store)),
          containerB10(
            child: Center(
              child: heading2('${user.firstName} ${user.lastName}'),
            ),
          ),
          containerB20(child: Center(child: heading4B('@${user.username}'))),
          ListTile(
            leading: const Icon(Icons.person),
            title: heading4('Личная информация'),
            onTap: () => context.pushNamed(accountUserDetailPage),
          ),
          // ListTile(
          //   leading: const Icon(Icons.person),
          //   title: heading4('Допол. информация'),
          //   onTap: () => context.pushNamed(accountClientDetailPage),
          // ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: heading4('Настройки'),
          //   onTap: () {},
          // ),
          ListTile(
            leading: const Icon(Icons.help),
            title: heading4('Помощь'),
            onTap: () => context.pushNamed(helpPage),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: heading4('Удалить аккаунт'),
            onTap: () {
              dialog(
                context: context,
                title: 'Вы действительно хотите удалить свой аккаунт?',
                children: [
                  myDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buttonSm(
                        context: context,
                        size: 0.7,
                        text: 'Отменить',
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      buttonSm(
                        context: context,
                        text: 'Да',
                        size: 0.7,
                        onPressed: () {
                          ApiClient.disableProfile(
                            store.state.token,
                          ).then((value) {
                            if (value == true) {
                              Token.removeToken().then((value) {
                                store.dispatch(Logout());
                                context.pushNamed(welcomePage);
                              });

                              Navigator.of(context, rootNavigator: true).pop();
                            } else {
                              dialog(
                                context: context,
                                title: 'Произошла ошибка',
                                description: 'Свяжитесь с тех. поддержкой',
                              );
                            }
                          });
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: heading4('Выйти'),
            onTap: () {
              Token.removeToken().then((value) {
                store.dispatch(Logout());
                context.pushNamed(welcomePage);
              });
            },
          ),
        ],
      ),
    );
  }
}
