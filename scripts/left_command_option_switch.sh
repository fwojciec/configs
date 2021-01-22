#!/bin/sh

# see https://developer.apple.com/library/archive/technotes/tn2450/_index.html

hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x7000000e3,
      "HIDKeyboardModifierMappingDst":0x7000000e2},
     {"HIDKeyboardModifierMappingSrc":0x7000000e2,
      "HIDKeyboardModifierMappingDst":0x7000000e3}]
}'
