vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO skaginn3x/framework
        REF 09328ebe573bfd083db09c7f6fc61ff0f1b569f9
        SHA512 83e160657300aab2208b99989565c630425f0669c8338a0080737eda3c734b51e93d45b8aa6ab84535895402894421011c04831d4339215203e3fd1ff8bd5a3b
        HEAD_REF main
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
