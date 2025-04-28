#!/bin/bash
#
#   This file is part of Adguard for iOS (https://github.com/AdguardTeam/AdguardForiOS).
#   Copyright © Adguard Software Limited. All rights reserved.
#
#   Adguard for iOS is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Adguard for iOS is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Adguard for iOS. If not, see <http://www.gnu.org/licenses/>.
#

echo "Running with ACTION=${ACTION}"

case $ACTION in
# NOTE: for some reason, it gets set to "" rather than "build" when
# doing a build.
"")
;;

"clean")
echo "Run Clean Script..."
/bin/bash "${SRCROOT}/../Builder/Builder/clean-script.sh"
exit 0
;;

esac

# Let's update 'Block YouTube Ads' userscript
# See https://github.com/AdguardTeam/BlockYouTubeAdsShortcut
# See https://jira.adguard.com/browse/AG-11561
echo "================ DOWNLOADING BLOCK ADS ON YOUTUBE USERSCRIPT ==================="
wget -O "${SRCROOT}/../YouTubeAdsActionExtension/userscript.js" https://raw.githubusercontent.com/AdguardTeam/BlockYouTubeAdsShortcut/master/dist/index.js


echo "============================== BUILD BUILDER ==================================="

# Build the Builder target using xcodebuild
xcodebuild \
  -workspace "${SRCROOT}/../AdguardSafariExtension-iOS.xcworkspace" \
  -scheme "Builder" \
  -configuration "${CONFIGURATION}" \
  -derivedDataPath "${SYMROOT}"

echo "================================ RUN BUILDER ==================================="

# Print the Builder Resources directory for reference
echo "resource folder:"
echo "${BUILDER_RESOURCES_DIR}"

# Set the path to the Builder executable (inside Debug, not Debug-iphonesimulator)
#BUILDER_EXECUTABLE="${SYMROOT}/Debug/Builder"

# Check if Builder binary exists
#if [ ! -f "$BUILDER_EXECUTABLE" ]; then
#  echo "❌ Builder executable not found at: $BUILDER_EXECUTABLE"
#  exit 1
#fi

# Run the Builder executable with configuration and resource path
#"$BUILDER_EXECUTABLE" --${CONFIGURATION} "${BUILDER_RESOURCES_DIR}" || exit 1
"${BUILDER_DIR}"/Builder --${CONFIGURATION} "${BUILDER_RESOURCES_DIR}" || exit 1

echo "============================ RUN BUILDER DONE =================================="
