abstract class IConfigurationService {
  String getApiServiceURL();
}

class ConfigurationService implements IConfigurationService {
  @override
  String getApiServiceURL() {
    return "https://www.sabah.com.tr/imsakiye/";
  }
}
