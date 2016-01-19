#!/bin/sh

delete_dict_keys=(
    "DTDKPortalCache:DeviceCache"
)

delete_array_keys=(
    "DVTSavediPhoneDevices"
    "DVTSourceControlAccountDefaultsKey"
    "IDESourceControlRecentsFavoritesRepositoriesUserDefaultsKey"
    "IDEDefaultPrimaryEditorFrameSizeForPaths"
    "DVTTextCompletionRecentCompletions"
    "IDERecentEditorDocuments"
    "IDESourceControlProjects"
    "IDEiPhoneOrganizerCollapsedDevices"
)

for delete_dict in ${delete_dict_keys[*]};
do
    /usr/libexec/PlistBuddy -c "delete $delete_dict" ~/Library/Preferences/com.apple.dt.Xcode.plist
    /usr/libexec/PlistBuddy -c "add $delete_dict dict" ~/Library/Preferences/com.apple.dt.Xcode.plist
done

for delete_array in ${delete_array_keys[*]};
do
    /usr/libexec/PlistBuddy -c "delete $delete_array" ~/Library/Preferences/com.apple.dt.Xcode.plist
    /usr/libexec/PlistBuddy -c "add $delete_array array" ~/Library/Preferences/com.apple.dt.Xcode.plist
done
