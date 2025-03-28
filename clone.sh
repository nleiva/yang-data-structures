git clone https://github.com/openconfig/public.git
mkdir -p yang/openconfig
mkdir -p yang/ietf
mv public/release/models/* yang/openconfig/
mv public/third_party/ietf/* yang/ietf/
rm -rf public/