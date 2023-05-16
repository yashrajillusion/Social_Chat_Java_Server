import 'package:logger/logger.dart';

class CoinsResponse {
  Status? status;
  List<CoinsData>? data;

  CoinsResponse({this.status, this.data});

  CoinsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <CoinsData>[];
      json['data'].values.forEach((v) {
        data!.add(CoinsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<CoinsResponse?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CoinsResponse.fromJson(json!);
    } catch (e) {
      Logger().e("get coins data parseInfo exception : $e");
      return null;
    }
  }
}

class Status {
  String? timestamp;
  dynamic errorCode;
  String? errorMessage;
  dynamic elapsed;
  dynamic creditCount;
  String? notice;

  Status({this.timestamp, this.errorCode, this.errorMessage, this.elapsed, this.creditCount, this.notice});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'].toDouble();
    errorMessage = json['error_message'];
    elapsed = json['elapsed'].toDouble();
    creditCount = json['credit_count'].toDouble();
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['error_code'] = errorCode;
    data['error_message'] = errorMessage;
    data['elapsed'] = elapsed;
    data['credit_count'] = creditCount;
    data['notice'] = notice;
    return data;
  }
}

class CoinsData {
  dynamic id;
  String? name;
  String? symbol;
  String? slug;
  dynamic numMarketPairs;
  String? dateAdded;
  List<String>? tags;
  dynamic maxSupply;
  dynamic circulatingSupply;
  dynamic totalSupply;
  dynamic isActive;
  String? platform;
  dynamic cmcRank;
  dynamic isFiat;
  String? selfReportedCirculatingSupply;
  String? selfReportedMarketCap;
  String? tvlRatio;
  String? lastUpdated;
  Quote? quote;

  CoinsData(
      {this.id,
      this.name,
      this.symbol,
      this.slug,
      this.numMarketPairs,
      this.dateAdded,
      this.tags,
      this.maxSupply,
      this.circulatingSupply,
      this.totalSupply,
      this.isActive,
      this.platform,
      this.cmcRank,
      this.isFiat,
      this.selfReportedCirculatingSupply,
      this.selfReportedMarketCap,
      this.tvlRatio,
      this.lastUpdated,
      this.quote});

  CoinsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    numMarketPairs = json['num_market_pairs'];
    dateAdded = json['date_added'];
    tags = json['tags'].cast<String>();
    maxSupply = json['max_supply'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    isActive = json['is_active'];
    platform = json['platform'];
    cmcRank = json['cmc_rank'];
    isFiat = json['is_fiat'];
    selfReportedCirculatingSupply = json['self_reported_circulating_supply'];
    selfReportedMarketCap = json['self_reported_market_cap'];
    tvlRatio = json['tvl_ratio'];
    lastUpdated = json['last_updated'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['slug'] = slug;
    data['num_market_pairs'] = numMarketPairs;
    data['date_added'] = dateAdded;
    data['tags'] = tags;
    data['max_supply'] = maxSupply;
    data['circulating_supply'] = circulatingSupply;
    data['total_supply'] = totalSupply;
    data['is_active'] = isActive;
    data['platform'] = platform;
    data['cmc_rank'] = cmcRank;
    data['is_fiat'] = isFiat;
    data['self_reported_circulating_supply'] = selfReportedCirculatingSupply;
    data['self_reported_market_cap'] = selfReportedMarketCap;
    data['tvl_ratio'] = tvlRatio;
    data['last_updated'] = lastUpdated;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USD {
  dynamic price;
  dynamic volume24h;
  dynamic volumeChange24h;
  dynamic percentChange1h;
  dynamic percentChange24h;
  dynamic percentChange7d;
  dynamic percentChange30d;
  dynamic percentChange60d;
  dynamic percentChange90d;
  dynamic marketCap;
  dynamic marketCapDominance;
  dynamic fullyDilutedMarketCap;
  dynamic tvl;
  String? lastUpdated;

  USD(
      {this.price,
      this.volume24h,
      this.volumeChange24h,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.percentChange30d,
      this.percentChange60d,
      this.percentChange90d,
      this.marketCap,
      this.marketCapDominance,
      this.fullyDilutedMarketCap,
      this.tvl,
      this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    percentChange30d = json['percent_change_30d'];
    percentChange60d = json['percent_change_60d'];
    percentChange90d = json['percent_change_90d'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    fullyDilutedMarketCap = json['fully_diluted_market_cap'];
    tvl = json['tvl'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['volume_24h'] = volume24h;
    data['volume_change_24h'] = volumeChange24h;
    data['percent_change_1h'] = percentChange1h;
    data['percent_change_24h'] = percentChange24h;
    data['percent_change_7d'] = percentChange7d;
    data['percent_change_30d'] = percentChange30d;
    data['percent_change_60d'] = percentChange60d;
    data['percent_change_90d'] = percentChange90d;
    data['market_cap'] = marketCap;
    data['market_cap_dominance'] = marketCapDominance;
    data['fully_diluted_market_cap'] = fullyDilutedMarketCap;
    data['tvl'] = tvl;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
