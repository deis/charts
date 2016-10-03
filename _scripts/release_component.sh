#!/bin/bash

set -euo pipefail

NEW_RELEASE="${NEW_RELEASE:-unknown}"
DRY_RUN_CMD='echo'
DRY_RUN=YES
UPDATE_MASTER=YES

# flags are --help --no-dry-run --no-update-master
for i in "$@"; do
    case $i in
        -h|--help)
            echo "Usage: release_component.sh [--no-dry-run] [--no-update-master]"
            exit 0
            ;;
        --no-dry-run)
            DRY_RUN_CMD=''
            DRY_RUN=NO
            ;;
        --no-update-master)
            UPDATE_MASTER=NO
            ;;
        *)
            ;;
    esac
done

if [[ $DRY_RUN == "YES" ]]; then
    echo -e "Doing a dry run of the component release...\n"
fi

# double-check that git remotes "origin" and "upstream" exist
git ls-remote --exit-code --quiet origin > /dev/null
git ls-remote --exit-code --quiet upstream > /dev/null

# update local master branch if needed
if [[ $UPDATE_MASTER == "YES" ]]; then
    $DRY_RUN_CMD git checkout master
    $DRY_RUN_CMD git fetch --tags upstream master
    $DRY_RUN_CMD git merge upstream/master
fi

# figure out the component name and the most recent release tag
export COMPONENT=${PWD##*/}
# redirect stderr so the "creating changelog" message is ignored
CHANGELOG=$(deisrel changelog individual "$COMPONENT" "$NEW_RELEASE" 2> /dev/null)
echo -e "CHANGELOG is:\n\n$CHANGELOG\n"

# if NEW_RELEASE was set, push a tag upstream
if [[ $NEW_RELEASE != "unknown" ]] && [[ ${NEW_RELEASE} =~ v[0-9].[0-9].[0-9] ]]; then
    $DRY_RUN_CMD git tag -a "$NEW_RELEASE" --file=- <<< "$CHANGELOG"
    $DRY_RUN_CMD git push upstream "$NEW_RELEASE"
    # test that we are on macOS
    if [[ $(uname) == "Darwin" ]]; then
        # copy the CHANGELOG to the clipboard
        echo "$CHANGELOG" | pbcopy
        # open the GitHub release notes form to make pasting the CHANGELOG easy
        $DRY_RUN_CMD open https://github.com/deis/"$COMPONENT"/releases/new?tag="$NEW_RELEASE"
    else
        echo -e "\nPaste the changelog contents at this URL:"
        echo https://github.com/deis/"$COMPONENT"/releases/new?tag="$NEW_RELEASE"
    fi
else
    echo -e "\nRe-run this script with NEW_RELEASE set to a semantic version tag."
    exit 0
fi

if [[ $DRY_RUN == "YES" ]]; then
    echo -e "\nRe-run this script with \"--no-dry-run\" to make these changes."
else
    # remind user to double-check that the artifact is available
    echo "Please ensure that you can download $COMPONENT:$NEW_RELEASE"
fi
