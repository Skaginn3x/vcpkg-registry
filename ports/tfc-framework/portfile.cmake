vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO skaginn3x/framework
    REF 7dbbf6ac8d989105553147e1a8dba8abd231d8d9
    SHA512 2f4cbbf7988b0e5a8ff25ad1b9ad25693c821006e9ac227742602b9f2051ea058a447beb4ad733becab8338a8d867a2ee40c115b9f8f66c66e161727b23feedc
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
