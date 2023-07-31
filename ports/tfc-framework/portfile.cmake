vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO skaginn3x/framework
        REF 0f11c347c86ec0b3a548b339f0748bcccf5367b2
        SHA512 0
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
