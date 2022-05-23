# json_view

![Pub Version](https://img.shields.io/pub/v/json_view)
![Pub Popularity](https://img.shields.io/pub/popularity/json_view)
![Pub Points](https://img.shields.io/pub/points/json_view)
![Pub Publisher](https://img.shields.io/pub/publisher/json_view)

A json preview package that has a not bad performance. 
lazy load json tree node that cause less jank. 
Support display large list json data like chrome dev tool.

![./resources/preview.png](https://raw.githubusercontent.com/laiiihz/json_view/Main/resources/preview.png)

## Highlight

* 👑 json type highlight.
* 🔆 lazy load large list & map. 
* 🚀 not bad performance.
* 📦 only depend on flutter.

## Usage

* simple usage

```dart
JsonView(json: data)
```

* customize style

```dart
JsonConfig(
    /// your customize configuration
    data: JsonConfigData(
        animation: true,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        itemPadding: EdgeInsets.only(left: 8),
        color: JsonColorScheme(
            stringColor: Colors.grey,
        ),
        style: JsonStyleScheme()
    ),
    /// any widget will contain jsonView
    child: ...,
)
```

## API reference

[pub.dev/documentation](https://pub.dev/documentation/json_view/latest/)


## Some thing went wrong 🤔

[create a new issue](https://github.com/laiiihz/json_view/issues/new)
& welcome [create a pull request](https://github.com/laiiihz/json_view/compare) 