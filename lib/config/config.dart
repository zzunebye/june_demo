abstract class BaseConfig {
  String get apiHost;

}

class DevConfig implements BaseConfig {
  String get apiHost =>  "https://api-staging.moovup.hk/v2";
}
