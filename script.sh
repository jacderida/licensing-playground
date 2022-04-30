#!/usr/bin/env bash

exit_code=0
attribution="Copyright (c) 2022, MaidSafe"
matched_licenses=("BSD-3-Clause" "BSD-3-Clause")

readarray -t files_missing_copyright_notice < <(rg --type rust --files-without-match "$attribution" .)
if [[ ${#files_missing_copyright_notice[@]} -gt 0 ]]; then
  echo "The following files were found to be missing a copyright notice:"
  for file in ${files_missing_copyright_notice[@]}; do
    echo "$file"
  done
  ((exit_code++))
else
  echo "All source files were found to contain a copyright notice."
fi

readarray -t files_missing_license_ref < <( \
  rg --type rust --files-without-match "${matched_licenses[0]}" .)
if [[ ${#files_missing_license_ref[@]} -gt 0 ]]; then
  echo "The following files were missing a license reference:"
  for file in ${files_missing_license_ref[@]}; do
    echo "$file"
  done
  ((exit_code++))
else
  echo "All source files were found to contain a license reference."
fi

exit $exit
