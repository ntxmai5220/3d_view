class FilterParam {
  FilterParam({
    this.limit = 6,
    this.creatorIdEQ,
    this.creatorIdNEQ,
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
  String? creatorIdNEQ;
  double? areaGTE;
  double? areaLTE;
  double? priceGTE;
  double? priceLTE;
  bool? isRentEQ;
  bool? isFavoriteEQ;
  bool? isHiddenEQ;

  void nextPage() => _page += 1;
  void resetPage() => _page = 1;

  FilterParam updateFilter({
    String? creatorIdEQ,
    String? creatorIdNEQ,
    double? areaGTE,
    double? areaLTE,
    double? priceGTE,
    double? priceLTE,
    bool? isRentEQ,
    bool? isHiddenEQ,
  }) =>
      FilterParam(
        creatorIdEQ: creatorIdEQ ?? this.creatorIdEQ,
        creatorIdNEQ: creatorIdEQ ?? this.creatorIdNEQ,
        areaGTE: areaGTE ?? this.areaGTE,
        areaLTE: areaLTE ?? this.areaLTE,
        priceGTE: priceGTE ?? this.priceGTE,
        priceLTE: priceLTE ?? this.priceLTE,
        isRentEQ: isRentEQ ?? this.isRentEQ,
        isHiddenEQ: isHiddenEQ ?? this.isHiddenEQ,
      );

  Map<String, dynamic> toHomeParam({bool sortByFavorite = false}) {
    Map<String, dynamic> json = {};
    Map<String, dynamic> tmp = {
      'page': _page,
      'limit': limit,
      'creatorId[ne]': creatorIdNEQ,
      'sort': sortByFavorite ? '-favoriteCount' : null,
    };

    tmp.forEach((key, value) {
      if (value != null) {
        json[key] = value;
      }
    });
    return json;
  }

  Map<String, dynamic> toUserParam() {
    return isHiddenEQ != null
        ? {
            'page': _page,
            'limit': limit,
            'creatorId[eq]': creatorIdEQ,
            'isHidden[eq]': isHiddenEQ,
          }
        : {
            'page': _page,
            'limit': limit,
            'creatorId[eq]': creatorIdEQ,
          };
  }

  // Map<String, dynamic> toMyParam() {
  //   return isRentEQ != null
  //       ? {
  //           'page': _page,
  //           'limit': limit,
  //           'creatorId[eq]': creatorIdEQ,
  //           'isHidden[eq]': false,
  //           'isRent[eq]': isRentEQ,
  //         }
  //       : {
  //           'page': _page,
  //           'limit': limit,
  //           'creatorId[eq]': creatorIdEQ,
  //           'isHidden[eq]': false,
  //         };
  // }

  Map<String, dynamic> toFilterParam() {
    Map<String, dynamic> json = {};
    Map<String, dynamic> tmp = {
      'page': _page,
      'limit': limit,
      'creatorId[eq]': creatorIdEQ,
      'creatorId[ne]': creatorIdNEQ,
      'area[gte]': areaGTE,
      'area[lte]': areaLTE,
      'price[gte]': priceGTE,
      'price[lte]': priceLTE,
      'isRent[eq]': isRentEQ,
      'isFavorite[eq]': isFavoriteEQ,
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
