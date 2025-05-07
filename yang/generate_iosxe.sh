go install github.com/openconfig/ygot/generator@latest
generator -path=. \
  -output_file=../iosxe/iosxe.go \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -package_name=iosxe -generate_fakeroot -fakeroot_name=iosxe \
  -generate_ordered_maps=false \
  -generate_simple_unions \
  -generate_getters \
  -structs_split_files_count=4 \
  -compress_paths=false \
  iosxe/1791/Cisco-IOS-XE-nat.yang