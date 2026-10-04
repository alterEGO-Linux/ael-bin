#!/usr/bin/env bash
# =============================================================================
# INFO
# =============================================================================
# [/ael-bin/install.sh]
# 
# Author      : Pascal Malouin (https://github.com/alterEGO-Linux)
# Created     : 2026-09-28 13:14:51 UTC
# Updated     : 2026-10-04 15:38:45 UTC
# Description : AEL//bin install.
# -----------------------------------------------------------------------------

set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

bin_home="${AEL_BIN:-${HOME}/.local/bin}"

dev_mode=false

# --( AEL BashLib )------------------------------------------------------------

if [[ -z "${AEL_BASHLIB:-}" ]]; then
    printf '%s\n' \
        'Warning: $AEL_BASHLIB is not set.' \
        '' \
        'The recommended location is:' \
        '  ~/.local/share/ael/ael-bashlib' \
        '' \
        'Set it with:' \
        '  export AEL_BASHLIB="$HOME/.local/share/ael/ael-bashlib"' \
        ''
fi

bashlib_dir="${AEL_BASHLIB:-$HOME/.local/share/ael/ael-bashlib}"

if [[ ! -d "$bashlib_dir" ]]; then
    printf '%s\n' \
        'Error: AEL//BashLib is required but could not be found.' \
        '' \
        'Expected location:' \
        "  $bashlib_dir" \
        '' \
        'Installation instructions:' \
        '  https://github.com/alterEGO-Linux/ael-documentation/components/ael-bashlib/INDEX.md' \
        '' >&2

    exit 1
fi

# ---( Usage )-----------------------------------------------------------------

usage() {
    cat <<EOF
Usage: ./install.sh [OPTIONS]

Install AEL//Bin components.

Components:
  --all             Install all components
  --arch-pkg        Install arch-pkg
  --busy            Install busy
  --cheat           Install cheat
  --deep-nmap       Install deep-nmap
  --deep-scan       Install deep-scan
  --delete          Install delete
  --dicom-tag       Install dicom-tag
  --directory-size  Install directory-size
  --docker-info     Install docker-info
  --elevate         Install elevate
  --emojis          Install emojis
  --extractor       Install extractor
  --network-switch  Install network-switch
  --pacman-reset    Install pacman-reset
  --ports           Install ports
  --processes       Install processes
  --ps-grep         Install ps-grep
  --py-cleaner      Install py-cleaner
  --shell-info      Install shell-info
  --show-utc        Install show-utc
  --virtual-boxes   Install virtual-boxes
  --whoisweb        Install whoisweb
  --word-frequency  Install word-frequency

Options:
  --dev             Development mode: symlink files instead of copying them
  -h, --help        Show this help

Multiple components may be specified.

Examples:
  ./install.sh --all
  ./install.sh --virtual-boxes
  ./install.sh --delete --pacman-reset

Development installation:
  ./install.sh --dev --all
  ./install.sh --dev --virtual-boxes
EOF
}

# ---( Common installation functions )-----------------------------------------

install_script() {
    local source="$1"
    local target_name="${2:-$(basename "$source")}"

    local source_file="${project_dir}/${source}"
    local target_file="${bin_home}/${target_name}"

    if [[ ! -f "$source_file" ]]; then
        printf 'Error: source file not found: %s\n' "$source_file" >&2
        return 1
    fi

    mkdir -p "$bin_home"

    if "$dev_mode"; then
        chmod +x "$source_file"

        ln -sfn \
            "$source_file" \
            "$target_file"

        printf 'Linked:    %s -> %s\n' \
            "$target_file" \
            "$source_file"
    else
        install -Dm755 \
            "$source_file" \
            "$target_file"

        printf 'Installed: %s\n' "$target_file"
    fi
}

install_file() {
    local source="$1"
    local target="$2"
    local mode="${3:-644}"

    local source_file="${project_dir}/${source}"

    if [[ ! -f "$source_file" ]]; then
        printf 'Error: source file not found: %s\n' "$source_file" >&2
        return 1
    fi

    if "$dev_mode"; then
        mkdir -p "$(dirname "$target")"

        ln -sfn \
            "$source_file" \
            "$target"

        printf 'Linked:    %s -> %s\n' \
            "$target" \
            "$source_file"
    else
        install -Dm"$mode" \
            "$source_file" \
            "$target"

        printf 'Installed: %s\n' "$target"
    fi
}

require_command() {
    local command="$1"

    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Error: required command not found: %s\n' \
            "$command" >&2
        return 1
    fi
}

# ---( Component installers )--------------------------------------------------

install_arch_pkg() {
    printf '\nInstalling arch-pkg...\n'

    install_script "arch-pkg"
}

install_busy() {
    printf '\nInstalling busy...\n'

    install_script "busy"
}

install_cheat() {
    printf '\nInstalling cheat...\n'

    install_script "cheat"
}

install_deep_nmap() {
    printf '\nInstalling deep-nmap...\n'

    install_script "deep-nmap"
}

install_deep_scan() {
    printf '\nInstalling deep-scan...\n'

    install_script "deep-scan"
}

install_delete() {
    printf '\nInstalling delete...\n'

    install_script "delete"
}

install_dicom_tag() {
    printf '\nInstalling dicom-tag...\n'

    install_script "dicom-tag"
}

install_directory_size() {
    printf '\nInstalling directory_size...\n'

    install_script "directory-size"
}

install_docker_info() {
    printf '\nInstalling docker-info...\n'

    install_script "docker-info"
}

install_elevate() {
    printf '\nInstalling elevate...\n'

    install_script "elevate"
}

install_emojis() {
    printf '\nInstalling emojis...\n'

    install_script "emojis"
}

install_extractor() {
    printf '\nInstalling extractor...\n'

    install_script "extractor"
}

install_network_switch() {
    printf '\nInstalling network-switch...\n'

    install_script "network-switch"
}

install_pacman_reset() {
    printf '\nInstalling pacman-reset...\n'

    install_script "pacman-reset"
}

install_ports() {
    printf '\nInstalling ports...\n'

    install_script "ports"
}

install_processes() {
    printf '\nInstalling processes...\n'

    install_script "processes"
}

install_ps_grep() {
    printf '\nInstalling ps-grep...\n'

    install_script "ps-grep"
}

install_py_cleaner() {
    printf '\nInstalling py-cleaner...\n'

    install_script "py-cleaner"
}

install_shell_info() {
    printf '\nInstalling shell-info...\n'

    install_script "shell-info"
}

install_show_utc() {
    printf '\nInstalling show-utc...\n'

    install_script "show-utc"
}

install_virtual_boxes() {
    printf '\nInstalling virtual-boxes...\n'

    install_script "virtual-boxes"
}

install_whoisweb() {
    printf '\nInstalling whoisweb...\n'

    install_script "whoisweb"
}

install_word_frequency() {
    printf '\nInstalling word-frequency...\n'

    install_script "word-frequency"
}

install_all() {
    install_arch_pkg
    install_busy
    install_cheat
    install_deep_nmap
    install_deep_scan
    install_delete
    install_dicom_tag
    install_directory_size
    install_docker_info
    install_elevate
    install_emojis
    install_extractor
    install_network_switch
    install_pacman_reset
    install_ports
    install_processes
    install_ps_grep
    install_py_cleaner
    install_shell_info
    install_show_utc
    install_virtual_boxes
    install_whoisweb
    install_word_frequency
}

# ---( Arguments )-------------------------------------------------------------

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

        --extractor)
            components+=(extractor)
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

# ---( Validation )------------------------------------------------------------

if [[ ${#components[@]} -eq 0 ]]; then
    printf 'Error: no component specified.\n\n' >&2
    usage >&2
    exit 1
fi

# ---( Installation )----------------------------------------------------------

printf '%s\n' 'Installing AEL//Bin...'

if "$dev_mode"; then
    printf '%s\n' \
        'Development mode enabled.' \
        "Files will be linked from: $project_dir"
else
    printf '%s\n' \
        'Standard installation.' \
        "Files will be installed to: $bin_home"
fi

for component in "${components[@]}"; do
    case "$component" in
        all)
            install_all
            break
            ;;

        arch-pkg)
            install_arch_pkg
            ;;

        busy)
            install_busy
            ;;

        cheat)
            install_cheat
            ;;

        deep-nmap)
            install_deep_nmap
            ;;

        deep-scan)
            install_deep_scan
            ;;

        delete)
            install_delete
            ;;

        dicom-tag)
            install_dicom_tag
            ;;

        directory-size)
            install_directory_size
            ;;

        docker-info)
            install_docker_info
            ;;

        elevate)
            install_elevate
            ;;

        emojis)
            install_emojis
            ;;

        extractor)
            install_extractor
            ;;

        network-switch)
            install_network_switch
            ;;

        pacman-reset)
            install_pacman_reset
            ;;
        
        ports)
            install_ports
            ;;

        processes)
            install_processes
            ;;

        ps-grep)
            install_ps_grep
            ;;

        py-cleaner)
            install_py_cleaner
            ;;

        shell-info)
            install_shell_info
            ;;

        virtual-boxes)
            install_virtual_boxes
            ;;

        whoisweb)
            install_whoisweb
            ;;

        word-frequency)
            install_word_frequency
            ;;

    esac
done

printf '\n%s\n' 'AEL//Bin installation completed.'
