go install github.com/openconfig/ygot/generator@latest
generator -path=. \
  -output_file=../iosxe/iosxe.go \
  -shorten_enum_leaf_names \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -package_name=iosxe -generate_fakeroot -fakeroot_name=iosxe \
  -generate_getters \
  -generate_ordered_maps=false \
  -generate_simple_unions \
  iosxe/1791/Cisco-IOS-XE-nat.yang