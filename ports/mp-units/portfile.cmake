vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mpusz/units
    REF v0.8.0
    REF 59a1269174da961fd21fa2bea6c1b964e80ce2e3
    SHA512 6369c886629955c6457911b98a702c29bacce58e9049e1da700055a3f8b1981cce4f545c1d09550ec1c57f8805f7fc1f0198118950a14b2a7b797dd437ed72df
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/src"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/${PORT}")

# Handle copyright/readme/package files
file(INSTALL "${SOURCE_PATH}/LICENSE.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(INSTALL "${SOURCE_PATH}/README.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug"
    "${CURRENT_PACKAGES_DIR}/lib") # Header only
