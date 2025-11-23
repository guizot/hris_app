import '../../domain/repositories/hive_repo.dart';
import '../datasource/local/hive_data_source.dart';



class HiveRepoImpl implements HiveRepo {

  final HiveDataSource hiveDataSource;

  HiveRepoImpl({
    required this.hiveDataSource,
  });









  // region BOOKING





  // endregion



  // region LOCATION





  // endregion

  // region PATH





  // endregion



  // region SETTING

  @override
  dynamic getSetting(String key) {
    return hiveDataSource.settingBox.get(key);
  }

  @override
  Future<void> saveSetting(String key, item) async {
    await hiveDataSource.settingBox.put(key, item);
  }

  @override
  Future<void> deleteSetting(String key) async {
    await hiveDataSource.settingBox.delete(key);
  }

  // endregion

}