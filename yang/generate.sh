go install github.com/openconfig/ygot/generator@latest
generator -path=. \
  -output_file=../junos/junos.go \
  -shorten_enum_leaf_names \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -package_name=junos -generate_fakeroot -fakeroot_name=junos \
  -generate_getters \
  -generate_ordered_maps=false \
  -generate_simple_unions \
  -yangpresence \
  -annotations \
  junos/23.4R2/junos-conf-policy-options@2023-01-01.yang \
  junos/23.4R2/junos-common-types@2023-01-01.yang \
  junos/23.4R2/junos-conf-interfaces@2023-01-01.yang \
  junos/23.4R2/junos-conf-root@2023-01-01.yang \
  junos/23.4R2/junos-conf-routing-instances@2023-01-01.yang \
  junos/23.4R2/junos-conf-routing-options@2023-01-01.yang \
  junos/23.4R2/junos-configuration-metadata.yang