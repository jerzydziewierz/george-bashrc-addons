# basrc-addons-reymonte.sh

#     .....................:
echo "start_notesync.......: synchronize daily-notes"
function start_notesync()
{
echo "starting notesync in SCREEN"
screen -S notesync -d -m bash -i -c "__notesync"
sl
}

function __notesync()
{
  cd $GEOREY_NOTES_LOCATION
  watch -d -n 30 bash -i -c __notesync_internal
}

function __notesync_internal()
{
  git add .
  git commit -m 'autosave'
  git fetch
  git merge -m 'automerge'
  git add .
  git commit -m 'autosave'
  # (git ls-files --modified --others --exclude-standard | grep . > /dev/null)
  # git push origin
  # git push grey-private
  git push public
}

