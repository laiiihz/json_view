List<int> listJsonData() {
  return List.generate(200, (index) => index);
}

Map<String, dynamic> getJsonData() {
  return {
    'root': {
      'name': 'json view',
      'version_number': 24,
      'flutter_project': true,
      'env': {
        'dart_version': '2.16.2',
        'flutter_version': '2.10.5',
      },
      'number_types': {
        'double': 3.1415,
        'int': 3,
      },
      'types': {
        'null_type': null,
        'bool_type': true,
        'string_type': 'string',
        'list_type': [],
        'map_type': {},
      },
      'list_in_map': {
        'list_a': [],
        'list_b': [1, 2, 3, null],
        'list_c': [
          {'a': 'test'}
        ],
      },
      'largeText':
          '  sedi tempero lemiscus poena tenus corrumpo Inda incredibilis centum putus dulcedo medius quarum aliquotiens opprobrium promptus carbo tendo. minimus non ius instructus uberrime extorqueo praetorgredior consto do cotidie compleo protraho exercitus poena frango Brocherota subvenio fidens Werumensium decet. presumo indigeo forsit directus infortunium neque vulgaris conturbo plagiarius socius Berlinmonte innotesco facina praemo itaque sequi.',
      'largeList': List.generate(
        230 * 100 * 100 + 32,
        (index) => {'index': index},
      ),
    },
  };
}
