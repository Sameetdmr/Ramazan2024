// ignore_for_file: one_member_abstracts

abstract class IConfigurationService {
  String getApiServiceURL();
}

final class ConfigurationService implements IConfigurationService {
  @override
  String getApiServiceURL() {
    return 'https://www.sabah.com.tr/imsakiye/';
  }
}
