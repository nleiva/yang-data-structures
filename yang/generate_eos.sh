go install github.com/openconfig/ygot/generator@latest
find arista/EOS-4.30.2F/release/ -name *.yang | generator -path=. \
  -output_file=../arista/eos.go \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -package_name=arista -generate_fakeroot -fakeroot_name=eos \
  -generate_ordered_maps=false \
  -generate_simple_unions \
  -generate_getters \
  -structs_split_files_count=4 \
  -compress_paths=true \
  -yangpresence \
  -exclude_modules=ietf-interfaces \
  -shorten_enum_leaf_names=true \
  -trim_enum_openconfig_prefix=false \
  arista/EOS-4.30.2F/not-supported.yang \