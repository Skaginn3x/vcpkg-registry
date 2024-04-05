set(GIT_REPO "skaginn3x/framework")
set(GIT_HASH "bb6d322cf4a429692721c97d1e1eca87641c1207") # tag or hash
set(GIT_URL "https://github.com/${GIT_REPO}.git")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_HASH}.clean)

find_program(GIT git REQUIRED)

if(NOT EXISTS "${SOURCE_PATH}/.git")
  message(STATUS "Running command: ${GIT} clone ${GIT_URL} ${SOURCE_PATH}")
  vcpkg_execute_required_process(
      COMMAND ${GIT} clone ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
      LOGNAME clone
  )

  message(STATUS "Running command: ${GIT} checkout ${GIT_HASH}")
  vcpkg_execute_required_process(
      COMMAND ${GIT} checkout ${GIT_HASH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME checkout
  )

  message(STATUS "${GIT} submodule update --init --recursive")
  vcpkg_execute_required_process(
      COMMAND ${GIT} submodule update --init --recursive
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME submodule-update
  )
endif()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DBUILD_EXES=OFF
    -DBUILD_TESTING=OFF
    -DBUILD_DOCS=OFF
    -DBUILD_EXAMPLES=OFF
    -DBUILD_FRONTEND=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME tfc)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
