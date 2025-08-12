
#!/bin/bash

sudo apt install -y git build-essential flex bison libyaml-dev

# Clone Repo
git clone https://dev.pyra-handheld.com/packages/pyra-kernel --depth 1

cat <<'EOF' >>  pyra-kernel/arch/arm/boot/dts/omap5-letux-cortex15-v5.3+pyra-v5.3.dts
&mmcmux {
    status = "disabled";
};

&{/txs02612} {
    status = "disabled";
};
EOF