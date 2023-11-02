vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO skaginn3x/framework
  REF ${VERSION}
  SHA512 a13e75ee9af16723822bc412aa6d887a9719e720bed8f33a01537107a63b70f920184bbce8cb779e2182d832167e45886bfcdef38b0ddae8e6b2df4532d5039b
)

if ("build-exes" IN_LIST FEATURES)
  set(BUILD_EXES ON)
else()
  set(BUILD_EXES OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
      -DCMAKE_PROJECT_VERSION=${VERSION} # todo I don't like this
      -DBUILD_EXES=${BUILD_EXES}
      -DBUILD_TESTING=OFF
      -DBUILD_DOCS=OFF
      -DBUILD_EXAMPLES=OFF
)

if (${BUILD_EXES})
  vcpkg_cmake_install(ADD_BIN_TO_PATH)
else ()
  vcpkg_cmake_install()
endif ()

vcpkg_cmake_config_fixup(PACKAGE_NAME tfc)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
