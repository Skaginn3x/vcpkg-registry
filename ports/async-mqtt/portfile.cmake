set(VCPKG_BUILD_TYPE release) #header-only

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO redboltz/async_mqtt
    REF ad5910358e0bd3c897a9c056d3c3be52c2a078be
    SHA512 880b0123236f7c1254013b8f58a2ca316a5fa68637ebff06a027c9c5b70c6279030b551c71177dc8e55dd5b48b0f5cd9060cf8c44a547039168585cbf3bb8e0e
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DASYNC_MQTT_BUILD_TOOLS=OFF
        -DASYNC_MQTT_BUILD_EXAMPLES=OFF
        -DASYNC_MQTT_BUILD_UNIT_TESTS=OFF
        -DASYNC_MQTT_BUILD_SYSTEM_TESTS=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME async_mqtt_iface CONFIG_PATH "lib/cmake/async_mqtt_iface")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
