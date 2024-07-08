import 'package:unidwell_finder/features/institutions/data/institutions_model.dart';

class InstitutionFilterModel {
  List<InstitutionsModel> items;
  List<InstitutionsModel> filteredItems;

  InstitutionFilterModel({
    required this.items,
    required this.filteredItems,
  });
}
