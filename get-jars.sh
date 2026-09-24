#!/usr/bin/env bash

jars=(roster50.jar teams50.jar solutions50.jar sies2csv.jar)

show_version() {
    local jar="$1"
    if [ ! -f "$jar" ]; then
        echo "$jar: jar file is missing"
        return
    fi
    printf "%s: " "$jar"
    java -jar "$jar" -V
}

show_versions() {
    for jar in "${jars[@]}"; do
        show_version "$jar"
    done
}

download_jar() {
    local jar="$1"
    local repo="${jar%.jar}"
    local url="https://github.com/raul-izquierdo/$repo/releases/latest/download/$jar"
    echo
    echo "Downloading $jar from $url"
    curl -fSL -o "$jar" "$url" || { echo "ERROR: Failed to download $jar" >&2; rm -f "$jar"; exit 1; }
}

echo "Current versions (before the updates):"
show_versions

for jar in "${jars[@]}"; do
    download_jar "$jar"
done

echo
echo "Current versions (after the updates):"
show_versions
