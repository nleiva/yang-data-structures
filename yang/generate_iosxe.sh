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
  -yangpresence \
  -shorten_enum_leaf_names=true \
  -trim_enum_openconfig_prefix=false \
  iosxe/1791/Cisco-IOS-XE-native.yang \
  iosxe/1791/Cisco-IOS-XE-nat.yang \
  iosxe/1791/Cisco-IOS-XE-acl.yang \
  iosxe/1791/Cisco-IOS-XE-route-map.yang \
  iosxe/1791/Cisco-IOS-XE-bgp.yang \
  iosxe/1791/Cisco-IOS-XE-snmp.yang \
  iosxe/1791/Cisco-IOS-XE-interfaces.yang \
  iosxe/1791/Cisco-IOS-XE-ntp.yang \
  iosxe/1791/Cisco-IOS-XE-multicast.yang \
  iosxe/1791/Cisco-IOS-XE-igmp.yang \
  iosxe/1791/not-supported.yang 
