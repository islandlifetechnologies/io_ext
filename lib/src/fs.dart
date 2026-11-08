import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';

/// The key for the [Zone] value that controls the current implementation of
/// [fs].
final _fsKey = Object();

/// The default implementation of [clock] for the current [Zone].
///
/// This defaults to the system clock. It can be set within a zone using
/// [withFileSystem].
FileSystem get fs =>
    Zone.current[_fsKey] as FileSystem? ?? const LocalFileSystem();

/// Runs [callback] with the given value for the top-level [fs] field.
///
/// This is [Zone]-scoped, so asynchronous callbacks spawned within [callback]
/// will also use the new value for [fs].
T withFileSystem<T>(FileSystem fs, T Function() callback) =>
    runZoned(callback, zoneValues: {_fsKey: fs});
