# json_view

A json preview package that has a not bad performance. 
lazy load json tree node that cause less jank. 
Support display large list json data like chrome dev tool.

![preview](./resources/preview.png)

## Usage

* simple usage

```dart
JsonView(json: data)
```

* customize style

```dart
JsonConfig(
    /// your customize color scheme
    color: JsonColorScheme(...),
    /// any widget will contain jsonView
    child: ...,
)
```
