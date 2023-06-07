import 'package:besmart_traveler/api_service/urls.dart';

import '../../models/company/company.dart';
import '../../models/pagination.dart';
import '../methods.dart';

const companies = Urls.baseApiUrl + Urls.companies;

class ApiCompany {
  static Future<Pagination?> getCompanies([url = companies]) async {
    var body = await httpGet(url);
    
    return body == null
        ? null
        : Pagination.fromJson(body, (json) => Company.fromJson(json));
  }

  static Future<List<CompanyName>?> getAllCompanies() async {
    var body = await httpGet(Urls.baseApiUrl + Urls.allCompanies);
    return body
        ?.map<CompanyName>((company) => CompanyName.fromJson(company))
        .toList();
  }
}
