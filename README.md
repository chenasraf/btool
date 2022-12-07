# btool

A build helper for Dart/Flutter projects.

Contains utility for getting/setting various configs such as package version/name, min/target sdk
version, etc. through a command-line or Dart import which you can utilize for your build steps.

## Getting started

### Install globally

```shell
dart pub global activate btools
# or
flutter pub global activate btools
```

And then to use:

```shell
btools -h
```

### Install locally

```shell
dart pub add [--dev] btools
# or
flutter pub add [--dev] btools
```

And then to use:

```shell
dart run btools -h
```

## Usage

```txt
Usage: btool <command> [...args]

Commands:

get <key>            Get config value
set <key> <value>    Set config value

Available keys:

- minSdkVersion
- targetSdkVersion
- packageVersion
- packageName
- applicationId

Optional flags:

-h, --help           Show help
-v, --version        Show version
-d, --working-dir    Change working directory of script
-V, --verbose        Display debug output
```

## Contributing

I am developing this package on my free time, so any support, whether code, issues, or just stars is
very helpful to sustaining its life. If you are feeling incredibly generous and would like to donate
just a small amount to help sustain this project, I would be very very thankful!

<a href='https://ko-fi.com/casraf' target='_blank'>
  <img height='36' style='border:0px;height:36px;'
    src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3'
    alt='Buy Me a Coffee at ko-fi.com' />
</a>

I welcome any issues or pull requests on GitHub. If you find a bug, or would like a new feature,
don't hesitate to open an appropriate issue and I will do my best to reply promptly.

If you are a developer and want to contribute code, here are some starting tips:

1. Fork this repository
2. Run `dart pub get`
3. Make any changes you would like
4. Create tests for your changes
5. Update the relevant documentation (readme, code comments)
6. Create a PR on upstream
