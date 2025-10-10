#!/usr/bin/env bash
set -euo pipefail

ARTIFACT_DIR="artifacts"

rm -rf "${ARTIFACT_DIR}"
mkdir -p "${ARTIFACT_DIR}"

if [ -f build/app/outputs/flutter-apk/app-release.apk ]; then
  cp build/app/outputs/flutter-apk/app-release.apk "${ARTIFACT_DIR}/tfma-android.apk"
fi

if [ -f build/ios/ipa/tfma-ios.ipa ]; then
  cp build/ios/ipa/tfma-ios.ipa "${ARTIFACT_DIR}/tfma-ios.ipa"
elif ls build/ios/ipa/*.ipa >/dev/null 2>&1; then
  SOURCE_IPA="$(ls build/ios/ipa/*.ipa | head -n1)"
  cp "${SOURCE_IPA}" "${ARTIFACT_DIR}/tfma-ios.ipa"
fi

echo "Collected artifacts in ${ARTIFACT_DIR}/"
