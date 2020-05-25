import 'package:algolia/algolia.dart';

class SearchService {

  algolia(){
    Algolia algolia = Algolia.init(
      applicationId: 'AVAQIQDEYR',
      apiKey: 'd71fc1e848465113487486c0d77fedcc',

    );

    return algolia;
  }

}

