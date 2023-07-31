vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO skaginn3x/framework
        REF 0f11c347c86ec0b3a548b339f0748bcccf5367b2
        SHA512 b96c1058d38727e81819369c4a75e0f0abe9b3d942d157ed4b3949f50173bda037118e6be603faf56161ae040131c150dcde13f83bb634b0af0e5369b223f4b8
        HEAD_REF protobuf_fix
)

if ("build-exes" IN_LIST FEATURES)
    set(BUILD_EXES ON)
else ()
    set(BUILD_EXES OFF)
endif ()

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
