// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// INCLUDE-FILE: toolchain/testing/testdata/min_prelude/none.carbon
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/interop/cpp/class/export/generic.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/interop/cpp/class/export/generic.carbon

// --- generic.carbon
library "[[@TEST_NAME]]";
import Cpp;

class C(T:! type) {
  var t: T;
}

inline Cpp '''
void F() {
  // CHECK:STDERR: generic.carbon:[[@LINE+12]]:11: error: no member named 'C' in namespace 'Carbon' [CppInteropParseError]
  // CHECK:STDERR:    10 |   Carbon::C<int> c;
  // CHECK:STDERR:       |           ^
  // CHECK:STDERR:
  // CHECK:STDERR: generic.carbon:[[@LINE+8]]:16: error: expected '(' for function-style cast or type construction [CppInteropParseError]
  // CHECK:STDERR:    10 |   Carbon::C<int> c;
  // CHECK:STDERR:       |             ~~~^
  // CHECK:STDERR:
  // CHECK:STDERR: generic.carbon:[[@LINE+4]]:18: error: use of undeclared identifier 'c' [CppInteropParseError]
  // CHECK:STDERR:    10 |   Carbon::C<int> c;
  // CHECK:STDERR:       |                  ^
  // CHECK:STDERR:
  Carbon::C<int> c;
  // CHECK:STDERR: generic.carbon:[[@LINE+4]]:3: error: use of undeclared identifier 'c' [CppInteropParseError]
  // CHECK:STDERR:    11 |   c.t = 123;
  // CHECK:STDERR:       |   ^
  // CHECK:STDERR:
  c.t = 123;
}
''';
