import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:graphql/client.dart';

GraphQLClient client = null as GraphQLClient;
// InMemoryCache inMemoryCache;
initConnection() async {
  final HttpLink httpLink = HttpLink(
    'http://localhost:4000/graphql',
  );
  // inMemoryCache = InMemoryCache();

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink);
  // await Hive.openBox('class room');
  client = GraphQLClient(
    link: link,
    // The default store is the InMemoryStore, which does NOT persist to disk
    // cache: GraphQLCache(store: HiveStore()),
    cache: GraphQLCache(),
  );
  return client;
}

getGQLClient() {
  return client;
}

handleResponse(QueryResult queryResult) async {
  Map<String, dynamic> result = {"hasError": false};
  if (queryResult.hasException) {
    result["error"] = await handleException(queryResult);
    result['hasError'] = true;
  }
  result['data'] = queryResult.data;
  return result;
}

handleException(QueryResult queryResult) {
  if (queryResult.exception!.linkException is HttpLinkServerException) {
    HttpLinkServerException httpLink =
        queryResult.exception!.linkException as HttpLinkServerException;
    if (httpLink.parsedResponse?.errors?.isNotEmpty == true) {
      print(
          "::: GraphQL error message log: ${httpLink.parsedResponse?.errors?.first.message}");
      return {"message": httpLink.parsedResponse?.errors?.first.message};
    }
    return {};
  }
  if (queryResult.exception!.linkException is NetworkException) {
    NetworkException networkException =
        queryResult.exception!.linkException as NetworkException;
    print("::: GraphQL error message log: ${networkException.message}");
    return {"message": networkException.message};
  }
}
