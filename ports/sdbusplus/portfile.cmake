if(VCPKG_TARGET_IS_LINUX)
  message("Warning: `sdbusplus` requires GCC 13+")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO openbmc/sdbusplus
    REF a4df19a74a398f3fb806a9c245f6bda42cfff117
    SHA512 03cf561b116d94e4c631aeadc9ac778c4383de31f6f5c13afd99e971a75bcb3c37f5a95a4e2a16a98810d277c1aaef839acb6cb971b11dae79da19ab60605b58 
    PATCHES
      # disabling boost definitions that cannot be defined because if privately linked to this library in one place
      # and use different definitions for boost asio in other places will produce sigsev fault
      disable-boost-definitions.patch
      async-option.patch
      add-getter-for-connection.patch
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

x_vcpkg_get_python_packages(
    PYTHON_VERSION "3"
    PACKAGES mako pyyaml inflection
)

if ("asio-only" IN_LIST FEATURES)
  set(USE_ASYNC disabled)
else()
  set(USE_ASYNC enabled)
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -Dtests=disabled
      -Dexamples=disabled
      -Dasync=${USE_ASYNC}
      -Dcpp_std=c++20 # todo revert to c++23 when meson tool has been upgraded
)

vcpkg_install_meson()

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
