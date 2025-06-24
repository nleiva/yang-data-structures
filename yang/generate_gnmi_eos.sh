go install github.com/openconfig/ygnmi/app/ygnmi@latest
find arista/EOS-4.30.2F/release/ -name *.yang | ygnmi generator \
  --output_dir=../gnmi/arista \
  --trim_module_prefix=openconfig \
  --split_top_level_packages=false \
  --fakeroot_name=eos \
  --compress_paths=true \
  --exclude_modules=ietf-interfaces \
  --shorten_enum_leaf_names=true \
  --prefer_operational_state=false \
  --paths=ietf,$(find arista/EOS-4.30.2F/openconfig/public/release/models -maxdepth 1 -type d | paste -d, -s) \
  --base_package_path=github.com/nleiva/yang-data-structures/gnmi/arista \
  arista/EOS-4.30.2F/not-supported.yang \

go install golang.org/x/tools/cmd/goimports@latest
goimports -w ../gnmi/arista