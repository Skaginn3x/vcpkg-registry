vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO skaginn3x/framework
  REF ${VERSION}
  SHA512 fd2374614a670c084647c397577ab94cf2cca28aed8bad3b52f3eea5061f1b2274ea2155564d2ed4a01f36c9a112837cfa761ec7bd5e32981528a4f3b21069d9
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
