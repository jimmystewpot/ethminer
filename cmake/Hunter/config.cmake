hunter_config(
    CURL
    VERSION ${HUNTER_CURL_VERSION} 
    CMAKE_ARGS HTTP_ONLY=ON CMAKE_USE_OPENSSL=OFF CMAKE_USE_LIBSSH2=OFF CURL_CA_PATH=none
)

hunter_config(
    Boost
    VERSION 1.75.0
)

hunter_config(
    ethash
    VERSION 0.6.0
    SHA1 4bfa26b389d1f89a60053de04b2a29feab20f67b
    URL https://github.com/chfast/ethash/archive/refs/tags/v0.6.0.tar.gz
)
