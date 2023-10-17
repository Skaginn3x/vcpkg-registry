vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO skaginn3x/framework
  REF ${VERSION}
  SHA512 b453c4ee40c8b381c8e03df512ba2549dd379b3fc226cae51b58b9f19300c0470f92620a35467097e83cf01922df3e30851634ad444db84b30cb6d9c3d5cb56b
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
