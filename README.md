# Go YANG data structures for public consumption

To import for demos.

## Generating Go binding from YANG models

You need to instal YGOT's code generator. 

```bash
go install github.com/openconfig/ygot/generator@latest
```

### OpenConfig

The Go generated code in the features folder is the result of the following ([PR](https://github.com/openconfig/ygot/issues/977)):

1. Clone OC YANG models

```bash
./clone.sh
```

2. Run the generator for a handful of YANG models.

```bash
generator -path=yang \
  -output_file=features/vlan/oc.go \
  -package_name=oc -generate_fakeroot -fakeroot_name=device -compress_paths=true \
  -shorten_enum_leaf_names \
  -trim_enum_openconfig_prefix \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -exclude_modules=ietf-interfaces \
  -generate_rename \
  -generate_append \
  -generate_getters \
  -generate_leaf_getters \
  -generate_populate_defaults \
  -generate_simple_unions \
  yang/openconfig/network-instance/openconfig-network-instance.yang \
  yang/openconfig/interfaces/openconfig-interfaces.yang \
  yang/openconfig/interfaces/openconfig-if-ip.yang \
  yang/openconfig/vlan/openconfig-vlan.yang
```

### JunOS

1. Get the models you need from https://github.com/Juniper/yang

2. Run the generator for a handful of YANG models.

```bash
cd yang
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
```