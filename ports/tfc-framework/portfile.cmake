vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO skaginn3x/framework
    REF "a26f2b7cfbf39e64cb0529ad8d4101fa21ff5674"
    SHA512 77e3de3a5905e383be428595438f0bb4538da4bc42c44c00dc83f2e4de2c32bb4599a8e67e530e04992920177c5f99887e95b4ccfe5248fa1b403064e844e75c
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
