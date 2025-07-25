# YANG Data Structures

This repository provides Go data structures generated from YANG models for various network device vendors and OpenConfig models. These structures can be imported and used in Go applications for configuration management, telemetry, and network automation.

## Prerequisites

Before generating Go bindings, install the required tools:

### YGOT

Install YGOT code generator for Go structs.

```bash
go install github.com/openconfig/ygot/generator@latest
```

### YGNMI (optional)

Install YGNMI code generator for gNMI bindings (optional).

```bash
go install github.com/openconfig/ygnmi/app/ygnmi@latest
```

## Quick Start

Each vendor has pre-configured generation scripts in the `yang/` directory. Navigate to the yang folder and run the appropriate script:

```bash
cd yang
```

Generate vendor-specific Go data structures:

```bash
./generate_iosxe.sh    # Cisco IOS XE
./generate_eos.sh      # Arista EOS
./generate_junos.sh    # Juniper JunOS
```

Generate gNMI bindings (example for Arista):

```bash
./generate_gnmi_eos.sh
```

## Detailed Instructions

### 1. OpenConfig Models

OpenConfig provides vendor-neutral YANG models for network configuration and telemetry.

**Setup:**
1. Download OpenConfig models:
   ```bash
   ./clone.sh
   ```
   This clones the OpenConfig public repository and organizes models in `yang/openconfig/` and `yang/ietf/`.

**Generate Go structs:**
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

### 2. Cisco IOS XE

**Setup:**
1. Download Cisco YANG models from https://github.com/YangModels/yang/tree/main/vendor/cisco/xe
2. Place models in `yang/cisco/1791/` directory

**Generate Go structs:**
```bash
cd yang
./generate_iosxe.sh
```

The script generates structs for common IOS XE modules including:
- Native configuration (`Cisco-IOS-XE-native.yang`)
- Interfaces, BGP, ACL, NAT, SNMP, NTP, and more

**Output:** `cisco/iosxe.go` with package name `cisco`

### 3. Arista EOS

**Setup:**
1. Download Arista YANG models from https://github.com/aristanetworks/yang
2. Place EOS models in `yang/arista/EOS-4.30.2F/` directory

**Generate Go structs:**
```bash
cd yang
./generate_eos.sh
```

The script automatically discovers all YANG files in the release directory and generates Go structs.

**Output:** `arista/eos.go` with package name `arista`

**Generate gNMI bindings:**
```bash
cd yang
./generate_gnmi_eos.sh
```

**Output:** gNMI client code in `gnmi/arista/` directory

### 4. Juniper JunOS

**Setup:**
1. Download Juniper YANG models from https://github.com/Juniper/yang
2. Place JunOS 23.4R2 models in `yang/juniper/23.4R2/` directory

**Generate Go structs:**
```bash
cd yang
./generate_junos.sh
```

The script generates structs for key JunOS configuration modules:
- Policy options, interfaces, routing instances
- Routing options, firewall rules
- Common types and metadata

**Output:** `juniper/junos.go` with package name `juniper`

## Generator Options Explained

The YGOT generator supports many options to customize the generated Go code:

### Common Options
- `-path=<dir>`: Base path for resolving YANG imports
- `-output_file=<file>`: Output Go file path
- `-package_name=<name>`: Go package name for generated structs
- `-generate_fakeroot -fakeroot_name=<name>`: Creates a root struct containing all modules

### Code Generation Options
- `-generate_getters`: Generate getter methods for all fields
- `-generate_leaf_getters`: Generate getters specifically for leaf nodes
- `-generate_simple_unions`: Generate simplified union types
- `-generate_ordered_maps=false`: Use regular maps instead of ordered maps

### Naming and Formatting
- `-shorten_enum_leaf_names`: Use shorter names for enum values
- `-trim_enum_openconfig_prefix`: Remove "openconfig" prefix from enums
- `-compress_paths=true`: Use shorter path names in generated code
- `-typedef_enum_with_defmod`: Include defining module in enum names

### File Organization
- `-structs_split_files_count=4`: Split large output into multiple files
- `-exclude_modules=<list>`: Exclude specific YANG modules from generation

### YANG Features
- `-yangpresence`: Support YANG presence containers
- `-annotations`: Include YANG annotations in generated code
- `-skip_deprecated`: Skip deprecated YANG nodes
- `-skip_obsolete`: Skip obsolete YANG nodes

## Using Generated Structures

### Import in Your Go Code

```go
import (
    "github.com/your-org/yang-data-structures/cisco"
    "github.com/your-org/yang-data-structures/arista"
    "github.com/your-org/yang-data-structures/juniper"
    "github.com/your-org/yang-data-structures/features/vlan"
)

// Example: Create Cisco IOS XE configuration
iosxe := &cisco.Iosxe{}
iosxe.Native = &cisco.Iosxe_Native{}

// Example: Create Arista EOS configuration  
eos := &arista.Eos{}

// Example: Create JunOS configuration
junos := &juniper.Junos{}
```

### Validation

Generated structs include validation methods:

```go
// Validate configuration against YANG constraints
if err := ygot.ValidateStruct(iosxe); err != nil {
    log.Fatalf("Configuration validation failed: %v", err)
}
```

### JSON Marshaling

```go
// Convert to JSON
jsonData, err := ygot.EmitJSON(iosxe, &ygot.EmitJSONConfig{
    Format: ygot.RFC7951,
    Indent: "  ",
})
if err != nil {
    log.Fatalf("JSON marshaling failed: %v", err)
}
```

## gNMI Client Generation

You can also generate gNMI client code using YGNMI for more streamlined gNMI operations.

### Prerequisites

```bash
go install github.com/openconfig/ygnmi/app/ygnmi@latest
```

### Generate gNMI Client Code

Example for Arista EOS (using the provided script):

```bash
cd yang
./generate_gnmi_eos.sh
```

This generates:
- gNMI client interfaces in `gnmi/arista/`
- Type-safe path builders
- Query and update helpers
- Automatic code formatting

### Using gNMI Generated Code

```go
import (
    "context"
    "github.com/openconfig/ygnmi/ygnmi"
    "github.com/your-org/yang-data-structures/gnmi/arista"
)

// Example: Query interface state
client := ygnmi.NewClient(conn) // conn is your gNMI connection
state, err := ygnmi.Get(context.Background(), client, 
    arista.Interface("Ethernet1").State())
```

## Resources and References

### YANG Model Browsers
- [YANG Explorer (Nokia)](https://yang.srlinux.dev) - Interactive YANG model browser
- [YANG Data Model Explorer (Juniper)](https://apps.juniper.net/ydm-explorer/) - Juniper's YANG explorer
- [YANG Catalog (IETF/Cisco)](https://www.yangcatalog.org/yang-search) - Comprehensive YANG model catalog

### OpenConfig Resources
- [OpenConfig Paths](https://openconfig.net/projects/models/paths/) - Path reference documentation
- [OpenConfig Tree View](https://openconfig.net/projects/models/schemadocs/) - Schema documentation browser
- [OpenConfig GitHub](https://github.com/openconfig/public) - Official OpenConfig models

### Tools and Libraries
- **[ygot](https://github.com/openconfig/ygot)**: YANG Go Tools - Generate Go structures and utilities from YANG models. Includes validation, JSON marshaling, and gNMI notification support.
- **[ygnmi](https://github.com/openconfig/ygnmi)**: Type-safe gNMI client library for Go with generated path helpers.
- **[pyang](https://github.com/mbj4668/pyang)**: YANG validator, transformer and code generator written in Python. Useful for YANG model validation and conversion.

### Vendor YANG Model Repositories
- **Cisco**: https://github.com/YangModels/yang/tree/main/vendor/cisco
- **Arista**: https://github.com/aristanetworks/yang  
- **Juniper**: https://github.com/Juniper/yang
- **Nokia**: https://github.com/nokia/7x50_YangModels

### Standards and Specifications
- [RFC 7950](https://tools.ietf.org/html/rfc7950) - The YANG 1.1 Data Modeling Language
- [RFC 7951](https://tools.ietf.org/html/rfc7951) - JSON Encoding of Data Modeled with YANG
- [gNMI Specification](https://github.com/openconfig/reference/blob/master/rpc/gnmi/gnmi-specification.md)

