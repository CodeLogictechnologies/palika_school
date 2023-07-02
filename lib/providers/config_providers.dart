import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/providers/auth_providers.dart';
import 'package:palika_school/services/config_service.dart';
import 'package:tuple/tuple.dart';

class SchoolBody {
  final String? ward;
  final String? searchKey;

  SchoolBody({this.ward, this.searchKey});
}

final schoolListProvider =
    FutureProvider.family((ref, Tuple2<String?, String?> body) async {
  ConfigService configService = ConfigService();
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  final data = configService.fetchSchools(state, body.item1, body.item2);
  return data;
});

final wardListProvider = FutureProvider((ref) async {
  ConfigService configService = ConfigService();
  final state = await ref.watch(getAuthenticatedUserProvider.future);
  return configService.fetchWards(state);
});
