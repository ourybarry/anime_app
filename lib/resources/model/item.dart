import 'package:deep_pick/deep_pick.dart';

abstract class Item {
  dynamic fromPick(RequiredPick pick);
}
