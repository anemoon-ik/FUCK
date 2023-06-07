import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/icons.dart';
import 'package:redux/redux.dart';

import '../../../components/app_bar.dart';
import '../../../components/image.dart';
import '../../../components/container.dart';
import '../../../components/text.dart';
import '../../../models/company/company.dart';
import '../../../redux/app_state.dart';
import '../../../router/urls.dart';
import '../../accessable/photo_view.dart';

class CompanyPage extends StatefulWidget {
  final String? id;

  const CompanyPage({super.key, required this.id});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  late Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    Company company = store.state.companies.results.firstWhere(
      (c) => c.id.toString() == widget.id,
    );

    return Scaffold(
      appBar: appBar(context: context),
      bottomNavigationBar: bottomAppBar(
        context: context,
        currentPage: companiesPage,
      ),
      body: bodyContainer(
        children: [
          containerB20(child: heading2(company.name)),
          // Row(children: [stars(company.rating)],)
          // containerB15(heading3("4.0 -")),
          containerB20(
            child: SizedBox(
              width: double.infinity,
              height: 250,
              child: imageCard(
                Photo(
                  imageUrl: company.logo,
                  title: company.name,
                ),
              ),
            ),
          ),
          containerB10(child: heading4B('ОПИСАНИЕ')),
          containerB20(child: heading4("\t\t${company.description}")),
          Row(children: medias(company.phones, company.socialMedia))
        ],
      ),
    );
  }
}
