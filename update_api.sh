#!/usr/bin/env bash
dart run swagger_parser
dart run build_runner build -d
dart format lib/api