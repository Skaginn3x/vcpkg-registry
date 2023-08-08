vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO skaginn3x/framework
    REF f9f38e69714d02bbce22044d823a24de6c0e50ce
    SHA512 ab9731aa4c668fca4b6a28e2bd80b01e32f5ccf6328b38bee595efee021fb5d30d9d7f987e5b729da6672c7a083bf9030585e05c300d43dbea92a93544791d1d
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
