import 'dart:async';
import 'dart:convert';

import 'package:polkawallet_sdk/service/index.dart';

class ServiceAccount {
  ServiceAccount(this.serviceRoot);

  final SubstrateService serviceRoot;

  /// encode addresses to publicKeys
  Future<Map?> encodeAddress(List<String> pubKeys, ss58List) async {
    final Map? res = await (serviceRoot.webView!.evalJavascript(
            'account.encodeAddress(${jsonEncode(pubKeys)}, ${jsonEncode(ss58List)})')
        as FutureOr<Map<dynamic, dynamic>?>);
    return res;
  }

  /// decode addresses to publicKeys
  Future<Map?> decodeAddress(List<String?> addresses) async {
    final Map? res = await (serviceRoot.webView!
            .evalJavascript('account.decodeAddress(${jsonEncode(addresses)})')
        as FutureOr<Map<dynamic, dynamic>?>);
    return res;
  }

  /// check address matches ss58Format
  Future<bool?> checkAddressFormat(String address, int ss58) async {
    final bool? res = await (serviceRoot.webView!
            .evalJavascript('account.checkAddressFormat("$address", $ss58)')
        as FutureOr<bool?>);
    return res;
  }

  /// query balance
  Future<Map?> queryBalance(String? address) async {
    final Map? res = await (serviceRoot.webView!
            .evalJavascript('account.getBalance(api, "$address")')
        as FutureOr<Map<dynamic, dynamic>?>);
    return res;
  }

  /// Get on-chain account info of addresses
  Future<List?> queryIndexInfo(List addresses) async {
    final List? res = await (serviceRoot.webView!.evalJavascript(
            'account.getAccountIndex(api, ${jsonEncode(addresses)})')
        as FutureOr<List<dynamic>?>);
    return res;
  }

  /// query address with account index
  Future<List?> queryAddressWithAccountIndex(String index, int? ss58) async {
    final res = await serviceRoot.webView!.evalJavascript(
        'account.queryAddressWithAccountIndex(api, "$index", $ss58)');
    return res;
  }

  Future<List?> getPubKeyIcons(List<String?> keys) async {
    final List? res = await (serviceRoot.webView!
            .evalJavascript('account.genPubKeyIcons(${jsonEncode(keys)})')
        as FutureOr<List<dynamic>?>);
    return res;
  }

  Future<List?> getAddressIcons(List addresses) async {
    final List? res = await (serviceRoot.webView!
            .evalJavascript('account.genIcons(${jsonEncode(addresses)})')
        as FutureOr<List<dynamic>?>);
    return res;
  }
}
