interval=0

black=#1E1D2D
green=#ABE9B3
white=#D9E0EE
grey=#282737
blue=#96CDFB
red=#F28FAD
mauve=#8839EF
darkblue=#83bae8

pkg_updates() {
    updates=$({ timeout 20 xbps-install -un 2>/dev/null || true; } | wc -l) # void

    printf "^c$black^ ^b$green^  "

    if [ -z "$updates" ]; then
        printf "F^c$green^ ^b$black^ Fully Updated"
    else
        printf "^c$green^ ^b$black^ $updates Updates"
    fi
}

cpu() {
    cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

    printf "^c$black^ ^b$red^ CPU"
    printf "^c$red^ ^b$black^ $cpu_val"
}

memory() {
    printf "^c$black^ ^b$blue^  "
    printf "^c$blue^ ^b$black^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

clock() {
    printf "^c$black^ ^b$mauve^ 󱑆 "
    printf "^c$mauve^^b$black^ $(date '+%I:%M')     "
}

while true; do
    [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
    interval=$((interval + 1))

    sleep 1 && xsetroot -name "$updates $(cpu) $(memory) $(clock)"
done
