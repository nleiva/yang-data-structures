go install github.com/openconfig/ygot/generator@latest
generator -path=. \
  -output_file=../cisco/iosxe.go \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -package_name=cisco -generate_fakeroot -fakeroot_name=iosxe \
  -generate_ordered_maps=false \
  -generate_simple_unions \
  -generate_getters \
  -structs_split_files_count=4 \
  -compress_paths=false \
  -yangpresence \
  -skip_deprecated \
  -skip_obsolete \
  -shorten_enum_leaf_names=true \
  -trim_enum_openconfig_prefix=false \
  cisco/1791/Cisco-IOS-XE-native.yang \
  cisco/1791/Cisco-IOS-XE-nat.yang \
  cisco/1791/Cisco-IOS-XE-acl.yang \
  cisco/1791/Cisco-IOS-XE-route-map.yang \
  cisco/1791/Cisco-IOS-XE-bgp.yang \
  cisco/1791/Cisco-IOS-XE-snmp.yang \
  cisco/1791/Cisco-IOS-XE-interfaces.yang \
  cisco/1791/Cisco-IOS-XE-ntp.yang \
  cisco/1791/Cisco-IOS-XE-multicast.yang \
  cisco/1791/Cisco-IOS-XE-igmp.yang \
  cisco/1791/not-supported.yang 
