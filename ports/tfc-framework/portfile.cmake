vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO skaginn3x/framework
    REF "8bba47034ed9da9c76d7ac6d00e585b44751d3f2"
    SHA512 6549922272699f9179fe597d80968aabd5c0d8bc146a7b80908af6eb01b39c2e372cc1079c3331f50524fec81e49e231c924d1fe3b70dbe62e908c0e1fa35e04
)

if ("build-exes" IN_LIST FEATURES)
  set(BUILD_EXES ON)
else()
  set(BUILD_EXES OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    -DBUILD_EXES=${BUILD_EXES}
    -DBUILD_TESTING=OFF
    -DBUILD_DOCS=OFF
)

if (${BUILD_EXES})
  vcpkg_cmake_install(ADD_BIN_TO_PATH)
else ()
  vcpkg_cmake_install()
endif ()

vcpkg_cmake_config_fixup(PACKAGE_NAME tfc)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
