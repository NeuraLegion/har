# har [![CI](https://github.com/NeuraLegion/har/actions/workflows/ci.yml/badge.svg)](https://github.com/NeuraLegion/har/actions/workflows/ci.yml) [![Releases](https://img.shields.io/github/release/NeuraLegion/har.svg)](https://github.com/NeuraLegion/har/releases) [![License](https://img.shields.io/github/license/NeuraLegion/har.svg)](https://github.com/NeuraLegion/har/blob/master/LICENSE)

HAR parser for version 1.2

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  har:
    github: NeuraLegion/har
```

## Usage

```crystal
json = HAR.from_file(file)
# or from string using HAR.from_string(String)
pp json
json.version
# => 1.2
json.entries
# etc..
```

## Development

Pretty much done.
If there is a needed feature please open an issue.

## Contributing

1. Fork it ( https://github.com/NeuraLegion/har/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [bararchy](https://github.com/bararchy) Bar Hofesh - creator, maintainer
- [Sija](https://github.com/Sija) Sijawusz Pur Rahnama - contributor, maintainer
