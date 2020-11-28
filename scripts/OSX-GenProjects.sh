cd "$(dirname "$0")"
pushd ../
./vendor/premake/bin/premake5macos xcode4
popd
