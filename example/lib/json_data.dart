List<int> listJsonData() {
  return List.generate(200, (index) => index);
}

Map<String, dynamic> getJsonData() {
  return {
    'name': 'John',
    'age': 30,
    'nullValue': null,
    'boolValue': false,
    'emptyMap': {},
    'details': {
      'sex': 'male',
      'outdated': false,
      'name': 'test',
      'innerEmptyMap': {},
      'innerMap': {
        'map2': {},
        'map3': {
          'test': 1,
          'test2': null,
        }
      },
    },
    'cars': [
      {
        'name': 'Ford',
        'models': ['Fiesta', 'Focus', 'Mustang']
      },
      {
        'name': 'BMW',
        'models': ['320', 'X3', 'X5']
      },
      {
        'name': 'Fiat',
        'models': ['500', 'Panda']
      }
    ],
    'largeList': List.generate(
      230 * 100 * 100,
      (index) => {'index': index},
    ),
  };
}
