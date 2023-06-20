vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO skaginn3x/framework
    REF "3b038a891adfa42b79192fe8a686375bf828449c"
    SHA512 a8f06a5ced4fdf578c7675e20bf2b2617f3f827629f8070db5561eda2292ea07f91dc174d4034007c65f6c6059ce87a2fe3df1db51a64eb2f755572fffd9a984
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
