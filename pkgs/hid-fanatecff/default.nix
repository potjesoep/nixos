{ lib, stdenv, fetchFromGitHub, kernel, kmod, linuxConsoleTools }:

let moduleDir = "lib/modules/${kernel.modDirVersion}/kernel/drivers/hid";
in
stdenv.mkDerivation rec {
  pname = "hid-fanatecff";
  version = "0.0.3";
  name = "hid-fanatecff-${version}-${kernel.modDirVersion}";

  src = fetchFromGitHub {
    owner = "gotzl";
    repo = "hid-fanatecff";
    rev = "next";
    sha256 = "yKgmiriRtGCCi5dfwelO95VDq0mmgzt/dI5YBYFR0uw=";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  patchPhase = ''
    mkdir -p $out/lib/udev/rules.d
    mkdir -p $out/${moduleDir}
    substituteInPlace Makefile --replace "/etc/udev/rules.d" "$out/lib/udev/rules.d"
    substituteInPlace fanatec.rules --replace "/usr/bin/evdev-joystick" "${linuxConsoleTools}/bin/evdev-joystick" --replace "/bin/sh" "${stdenv.shell}"
    sed -i '/depmod/d' Makefile
  '';

  makeFlags = [
    "KVERSION=${kernel.modDirVersion}"
    "KERNEL_SRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "MODULEDIR=$(out)/${moduleDir}"
  ];

  meta = with lib; {
    description = "A kernel module that provides support for fanatec wheels and pedals";
    homepage = "https://github.com/gotzl/hid-fanatecff";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
