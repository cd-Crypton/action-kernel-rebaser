#!/bin/bash

# Github Workspace
cd workspace

# Find Directories of the OEM Kernel
cd oem
OEM_DIR_LIST=$(find -type d -printf "%P\n" | grep -v / | grep -v .git)
cd ..

# Remove Existing Directory in OEM Kernel
cd caf
for i in ${OEM_DIR_LIST}; do
	rm -rf ${i}
done
cd ..

# Copy all changes from OEM to CAF/CLO
cp -r oem/* caf/

# Commit all changes per directory
cd caf
for i in ${OEM_DIR_LIST}; do
	git add ${i}
	git commit -s -m "${i}: import OEM changes"
done

# Commit remaining changes
git add .
git commit -s -m "others: import remaining OEM changes"
