class ListResponse<T> {
  ListResponse({
    required this.list,
  });

  List<T> list;
}

class ObjectResponse<T> {
  ObjectResponse({
    required this.object,
  });

  T object;
}
