#!/usr/bin/env bash
# =============================================================================
# INFO
# =============================================================================
# [/ael-bin/uninstall.sh]
#
# Author      : Pascal Malouin (https://github.com/alterEGO-Linux)
# Created     : 2026-09-28 19:38:06 UTC
# Updated     : 2026-09-28 19:38:11 UTC
# Description : AEL//Bin uninstall.
# -----------------------------------------------------------------------------

set -euo pipefail

bin_home="${AEL_BIN:-${HOME}/.local/bin}"

dev_mode=false

# ---( Usage )----------------------------------------------------------------|

usage() {
    cat <<EOF
Usage: ./uninstall.sh [OPTIONS]

Uninstall AEL//Bin components.

Components:
  --all             Uninstall all components
  --arch-pkg        Uninstall arch-pkg
  --busy            Uninstall busy
  --cheat           Uninstall cheat
  --deep-nmap       Uninstall deep-nmap
  --deep-scan       Uninstall deep-scan
  --delete          Uninstall delete
  --dicom-tag       Uninstall dicom-tag
  --directory-size  Uninstall directory-size
  --docker-info     Uninstall docker-info
  --elevate         Uninstall elevate
  --emojis          Uninstall emojis
  --network-switch  Uninstall network-switch
  --pacman-reset    Uninstall pacman-reset
  --ports           Uninstall ports
  --processes       Uninstall processes
  --ps-grep         Uninstall ps-grep
  --py-cleaner      Uninstall py-cleaner
  --shell-info      Uninstall shell-info
  --show-utc        Uninstall show-utc
  --virtual-boxes   Uninstall virtual-boxes
  --whoisweb        Uninstall whoisweb
  --word-frequency  Uninstall word-frequency

Options:
  --dev             Development mode
  -h, --help        Show this help

Multiple components may be specified.

Examples:
  ./uninstall.sh --all
  ./uninstall.sh --virtual-boxes
  ./uninstall.sh --delete --pacman-reset

Development installation:
  ./uninstall.sh --dev --all
  ./uninstall.sh --dev --virtual-boxes
EOF
}


# ---( Common uninstallation functions )--------------------------------------|

remove_script() {
    local name="$1"
    local target="${bin_home}/${name}"

    if [[ -L "$target" ]]; then
        rm -- "$target"
        printf 'Removed link: %s\n' "$target"

    elif [[ -f "$target" ]]; then
        rm -- "$target"
        printf 'Removed:      %s\n' "$target"

    elif [[ -e "$target" ]]; then
        printf 'Warning: %s exists but is not a regular file or link; skipping.\n' \
            "$target" >&2

    else
        printf 'Not installed: %s\n' "$target"
    fi
}


remove_file() {
    local target="$1"

    if [[ -L "$target" || -f "$target" ]]; then
        rm -- "$target"
        printf 'Removed: %s\n' "$target"

    elif [[ -e "$target" ]]; then
        printf 'Warning: %s exists but is not a regular file or link; skipping.\n' \
            "$target" >&2

    else
        printf 'Not installed: %s\n' "$target"
    fi
}


remove_directory_if_empty() {
    local directory="$1"

    if [[ -d "$directory" ]]; then
        rmdir --ignore-fail-on-non-empty "$directory"
    fi
}


# ---( Component uninstallers )-----------------------------------------------|

uninstall_arch_pkg() {
    printf '\nUninstalling arch-pkg...\n'

    remove_script "arch-pkg"
}


uninstall_busy() {
    printf '\nUninstalling busy...\n'

    remove_script "busy"
}


uninstall_cheat() {
    printf '\nUninstalling cheat...\n'

    remove_script "cheat"
}


uninstall_deep_nmap() {
    printf '\nUninstalling deep-nmap...\n'

    remove_script "deep-nmap"
}


uninstall_deep_scan() {
    printf '\nUninstalling deep-scan...\n'

    remove_script "deep-scan"
}


uninstall_delete() {
    printf '\nUninstalling delete...\n'

    remove_script "delete"
}


uninstall_dicom_tag() {
    printf '\nUninstalling dicom-tag...\n'

    remove_script "dicom-tag"
}


uninstall_directory_size() {
    printf '\nUninstalling directory-size...\n'

    remove_script "directory-size"
}


uninstall_docker_info() {
    printf '\nUninstalling docker-info...\n'

    remove_script "docker-info"
}


uninstall_elevate() {
    printf '\nUninstalling elevate...\n'

    remove_script "elevate"
}


uninstall_emojis() {
    printf '\nUninstalling emojis...\n'

    remove_script "emojis"
}


uninstall_network_switch() {
    printf '\nUninstalling network-switch...\n'

    remove_script "network-switch"
}


uninstall_pacman_reset() {
    printf '\nUninstalling pacman-reset...\n'

    remove_script "pacman-reset"
}


uninstall_ports() {
    printf '\nUninstalling ports...\n'

    remove_script "ports"
}


uninstall_processes() {
    printf '\nUninstalling processes...\n'

    remove_script "processes"
}


uninstall_ps_grep() {
    printf '\nUninstalling ps-grep...\n'

    remove_script "ps-grep"
}


uninstall_py_cleaner() {
    printf '\nUninstalling py-cleaner...\n'

    remove_script "py-cleaner"
}


uninstall_shell_info() {
    printf '\nUninstalling shell-info...\n'

    remove_script "shell-info"
}


uninstall_show_utc() {
    printf '\nUninstalling show-utc...\n'

    remove_script "show-utc"
}


uninstall_virtual_boxes() {
    printf '\nUninstalling virtual-boxes...\n'

    remove_script "virtual-boxes"
}


uninstall_whoisweb() {
    printf '\nUninstalling whoisweb...\n'

    remove_script "whoisweb"
}


uninstall_word_frequency() {
    printf '\nUninstalling word-frequency...\n'

    remove_script "word-frequency"
}


uninstall_all() {
    uninstall_arch_pkg
    uninstall_busy
    uninstall_cheat
    uninstall_deep_nmap
    uninstall_deep_scan
    uninstall_delete
    uninstall_dicom_tag
    uninstall_directory_size
    uninstall_docker_info
    uninstall_elevate
    uninstall_emojis
    uninstall_network_switch
    uninstall_pacman_reset
    uninstall_ports
    uninstall_processes
    uninstall_ps_grep
    uninstall_py_cleaner
    uninstall_shell_info
    uninstall_show_utc
    uninstall_virtual_boxes
    uninstall_whoisweb
    uninstall_word_frequency
}


# ---( Arguments )------------------------------------------------------------|

if [[ $# -eq 0 ]]; then
    usage
    exit 1
fi

declare -a components=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --all)
            components=(all)
            ;;

        --arch-pkg)
            components+=(arch-pkg)
            ;;

        --busy)
            components+=(busy)
            ;;

        --cheat)
            components+=(cheat)
            ;;

        --deep-nmap)
            components+=(deep-nmap)
            ;;

        --deep-scan)
            components+=(deep-scan)
            ;;

        --delete)
            components+=(delete)
            ;;

        --dicom-tag)
            components+=(dicom-tag)
            ;;

        --directory-size)
            components+=(directory-size)
            ;;

        --docker-info)
            components+=(docker-info)
            ;;

        --elevate)
            components+=(elevate)
            ;;

        --emojis)
            components+=(emojis)
            ;;

        --network-switch)
            components+=(network-switch)
            ;;

        --pacman-reset)
            components+=(pacman-reset)
            ;;

        --ports)
            components+=(ports)
            ;;

        --processes)
            components+=(processes)
            ;;

        --ps-grep)
            components+=(ps-grep)
            ;;

        --py-cleaner)
            components+=(py-cleaner)
            ;;

        --shell-info)
            components+=(shell-info)
            ;;

        --show-utc)
            components+=(show-utc)
            ;;

        --virtual-boxes)
            components+=(virtual-boxes)
            ;;

        --whoisweb)
            components+=(whoisweb)
            ;;

        --word-frequency)
            components+=(word-frequency)
            ;;

        --dev)
            dev_mode=true
            ;;

        -h|--help)
            usage
            exit 0
            ;;

        *)
            printf 'Error: unknown option: %s\n\n' "$1" >&2
            usage >&2
            exit 1
            ;;
    esac

    shift
done


# ---( Validation )-----------------------------------------------------------|

if [[ ${#components[@]} -eq 0 ]]; then
    printf 'Error: no component specified.\n\n' >&2
    usage >&2
    exit 1
fi


# ---( Uninstallation )-------------------------------------------------------|

printf '%s\n' 'Uninstalling AEL//Bin...'

if "$dev_mode"; then
    printf '%s\n' 'Development mode.'
fi

for component in "${components[@]}"; do
    case "$component" in
        all)
            uninstall_all
            break
            ;;

        arch-pkg)
            uninstall_arch_pkg
            ;;

        busy)
            uninstall_busy
            ;;

        cheat)
            uninstall_cheat
            ;;

        deep-nmap)
            uninstall_deep_nmap
            ;;

        deep-scan)
            uninstall_deep_scan
            ;;

        delete)
            uninstall_delete
            ;;

        dicom-tag)
            uninstall_dicom_tag
            ;;

        directory-size)
            uninstall_directory_size
            ;;

        docker-info)
            uninstall_docker_info
            ;;

        elevate)
            uninstall_elevate
            ;;

        emojis)
            uninstall_emojis
            ;;

        network-switch)
            uninstall_network_switch
            ;;

        pacman-reset)
            uninstall_pacman_reset
            ;;

        ports)
            uninstall_ports
            ;;

        processes)
            uninstall_processes
            ;;

        ps-grep)
            uninstall_ps_grep
            ;;

        py-cleaner)
            uninstall_py_cleaner
            ;;

        shell-info)
            uninstall_shell_info
            ;;

        show-utc)
            uninstall_show_utc
            ;;

        virtual-boxes)
            uninstall_virtual_boxes
            ;;

        whoisweb)
            uninstall_whoisweb
            ;;

        word-frequency)
            uninstall_word_frequency
            ;;
    esac
done

printf '\n%s\n' 'AEL//Bin uninstallation completed.'
