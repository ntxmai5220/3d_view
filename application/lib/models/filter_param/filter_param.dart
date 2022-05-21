class FilterParam {
  FilterParam({
    this.limit = 7,
    this.creatorIdEQ,
    this.areaGTE = 0,
    this.areaLTE = 999999,
    this.priceGTE = 0,
    this.priceLTE = 1000000,
    this.isRentEQ,
    this.isFavoriteEQ,
    this.isHiddenEQ,
  }) : _page = 1;

  int _page;
  int limit;
  String? creatorIdEQ;
  double? areaGTE;
  double? areaLTE;
  double? priceGTE;
  double? priceLTE;
  bool? isRentEQ;
  bool? isFavoriteEQ;
  bool? isHiddenEQ;

  void nextPage() => _page += 1;

  FilterParam updateFilter({
    String? creatorIdEQ,
    double? areaGTE,
    double? areaLTE,
    double? priceGTE,
    double? priceLTE,
    bool? isRentEQ,
    bool? isHiddenEQ,
  }) =>
      FilterParam(
        creatorIdEQ: creatorIdEQ ?? this.creatorIdEQ,
        areaGTE: areaGTE ?? this.areaGTE,
        areaLTE: areaLTE ?? this.areaLTE,
        priceGTE: priceGTE ?? this.priceGTE,
        priceLTE: priceLTE ?? this.priceLTE,
        isRentEQ: isRentEQ ?? this.isRentEQ,
        isHiddenEQ: isHiddenEQ ?? this.isHiddenEQ,
      );

  Map<String, dynamic> toHomeParam({bool sortByFavorite = false}) {
    return sortByFavorite
        ? {
            'page': _page,
            'limit': limit,
            'sort': '-favoriteCount',
          }
        : {
            'page': _page,
            'limit': limit,
          };
  }

  Map<String, dynamic> toUserParam() {
    return {
      'page': _page,
      'limit': limit,
      'creatorId[eq]': creatorIdEQ,
      'isHidden[eq]': false,
    };
  }

  Map<String, dynamic> toMyParam() {
    return isRentEQ != null
        ? {
            'page': _page,
            'limit': limit,
            'creatorId[eq]': creatorIdEQ,
            'isHidden[eq]': false,
            'isRent[eq]': isRentEQ,
          }
        : {
            'page': _page,
            'limit': limit,
            'creatorId[eq]': creatorIdEQ,
            'isHidden[eq]': false,
          };
  }

  Map<String, dynamic> toFilterParam() {
    Map<String, dynamic> json = {};
    Map<String, dynamic> tmp = {
      'page': _page,
      'limit': limit,
      'creatorId[eq]': creatorIdEQ,
      'area[gte]': areaGTE,
      'area[lte]': areaLTE,
      'price[gte]': priceGTE,
      'price[lte]': priceLTE,
      'isRent[eq]': isRentEQ,
    };

    tmp.forEach((key, value) {
      if (value != null) {
        json[key] = value;
      }
    });
    return json;
  }

  factory FilterParam.fromMap(Map<String, dynamic> map) {
    return FilterParam(
      limit: map['limit']?.toInt() ?? 0,
      creatorIdEQ: map['creatorId[eq]'],
      areaGTE: map['area[gte]']?.toDouble(),
      areaLTE: map['area[lte]']?.toDouble(),
      priceGTE: map['price[gte]']?.toDouble(),
      priceLTE: map['price[lte]']?.toDouble(),
      isRentEQ: map['isRent[eq]'],
    );
  }
}
