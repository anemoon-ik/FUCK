import 'package:besmart_traveler/router/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/input.dart';
import 'package:besmart_traveler/forms/companies.dart';
import 'package:redux/redux.dart';

import '../../../api_service/services/company_service.dart';
import '../../../api_service/urls.dart';
import '../../../components/button.dart';
import '../../../components/company/company_card.dart';
import '../../../components/container.dart';
import '../../../models/company/company.dart';
import '../../../utils/scroll_bottom.dart';
import '../../../models/pagination.dart';
import '../../../redux/actions/pagination.dart';
import '../../../redux/app_state.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final formKey = GlobalKey<FormState>();
  final companyName = Controller();
  final ScrollController control = ScrollController();

  late Store<AppState> store;

  @override
  void initState() {
    super.initState();

    control.addListener(() {
      store = StoreProvider.of<AppState>(context);
      if (scrollBottom(control) && store.state.companies.next != null) {
        ApiCompany.getCompanies(store.state.companies.next).then((pgn) {
          if (pgn is Pagination) {
            store.dispatch(UpdatePgn(name: Company.modelName, pgn: pgn));
            setState(() {});
          }
        });
      }
    });
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  void submit(Store store, BuildContext context) {
    CompaniesForm form = store.state.companiesForm;

    String url = "${Urls.baseApiUrl}${Urls.companies}?";
    url += "search=${form.company.text}&";

    ApiCompany.getCompanies(url).then((pgn) {
      if (pgn != null) {
        store.dispatch(SetPgn(name: Company.modelName, pgn: pgn));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    CompaniesForm form = store.state.companiesForm;

    return Scaffold(
      bottomNavigationBar:
          bottomAppBar(context: context, currentPage: companiesPage),
      body: bodyContainer(
        controller: control,
        children: [
          Form(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: input(
                  controller: form.company,
                  text: 'Название',
                ),
              ),
              const SizedBox(width: 10),
              containerB20(
                child: buttonSm(
                  context: context,
                  text: '↻',
                  onPressed: () {
                    store.state.companiesForm = CompaniesForm();
                    submit(store, context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              containerB20(
                child: buttonSm(
                  context: context,
                  text: 'Поиск',
                  onPressed: () => submit(store, context),
                  active: true,
                ),
              ),
            ],
          )),
          StoreConnector<AppState, List>(
            converter: (store) => store.state.companies.results,
            builder: (context, companies) {
              return Column(
                children:
                    companies.map((e) => companyCard(context, e)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
