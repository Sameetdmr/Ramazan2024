abstract class IConfigurationService {
  String getApiServiceURL();
}

class ConfigurationService implements IConfigurationService {
  @override
  String getApiServiceURL() {
    return "https://namaz-vakti.vercel.app/api/";
  }
}
