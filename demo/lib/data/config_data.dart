import 'package:demo/model/config_corp_bean.dart';
import 'package:flutter/material.dart';

class ConfigData {
  factory ConfigData() => shared;

  static final ConfigData shared = ConfigData._internal();

  ConfigData._internal();

  ConfigCorpBean configCorpBean;
}