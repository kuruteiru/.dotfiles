#!/bin/bash

set -e

SOURCE="${BASH_SOURCE[0]}"
# -h checks if file is a symlink
while [[ -h "$SOURCE" ]]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

PROFILES_DIR="$SCRIPT_DIR/profiles"
TLP_CONF="/etc/tlp.conf"

VERBOSE=false

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${BLUE}[INFO]${NC} $1"
    fi
}

log_success() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${GREEN}[SUCCESS]${NC} $1"
    fi
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_warning() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${YELLOW}[WARNING]${NC} $1"
    fi
}

get_all_profiles() {
    local profiles=()
    # -d checks if directory exists
    if [[ -d "$PROFILES_DIR" ]]; then
        for file in "$PROFILES_DIR"/*.conf; do
            # -f checks if file exists and is a regular file
            if [[ -f "$file" ]]; then
                local filename=$(basename "$file")
                # bash string manipulation to remove prefix/suffix
                local name="${filename#*-tlp-}"
                name="${name%.conf}"
                profiles+=("$name")
            fi
        done
    fi
    echo "${profiles[@]}"
}

get_profile_filename() {
    local profile_name=$1
    local file=$(find "$PROFILES_DIR" -name "*tlp-${profile_name}.conf" -print -quit)

    # -n checks if string is non-empty
    if [[ -n "$file" ]]; then
        basename "$file"
    else
        echo ""
    fi
}

get_current_profile() {
    if [[ ! -f "$TLP_CONF" ]]; then
        echo "unknown"
        return 1
    fi

    local profiles=($(get_all_profiles))
    for profile in "${profiles[@]}"; do
        local filename=$(get_profile_filename "$profile")
        local source_file="$PROFILES_DIR/$filename"
        if cmp -s "$TLP_CONF" "$source_file"; then
            echo "$profile"
            return 0
        fi
    done
    
    echo "unknown"
}

validate_profile() {
    local target=$1
    local profiles=($(get_all_profiles))

    for p in "${profiles[@]}"; do
        if [[ "$p" == "$target" ]]; then
            return 0
        fi
    done

    return 1
}

apply_profile() {
    local target_profile=$1
    local filename=$(get_profile_filename "$target_profile")
    local source_file="$PROFILES_DIR/$filename"
    
    # -z checks if string is empty
    if [[ -z "$filename" || ! -f "$source_file" ]]; then
        log_error "Profile file not found for: $target_profile"
        exit 1
    fi
    
    log_info "Switching to $target_profile..."
    log_info "Copying $filename to $TLP_CONF..."
    cp "$source_file" "$TLP_CONF"
    
    log_info "Restarting TLP service..."
    if systemctl restart tlp.service 2>/dev/null; then
        log_success "TLP service restarted"
    else
        log_error "Failed to restart TLP service"
        exit 1
    fi
    
    tlp start >/dev/null 2>&1
    log_success "Profile switch complete: $target_profile"
}

waybar_output() {
    local current=$(get_current_profile)
    local icon=""
    local class=""
    
    case "$current" in
        performance) icon=""; class="performance" ;;
        balanced)    icon="󰙴"; class="balanced" ;;
        low-power)   icon=""; class="low-power" ;;
        *)           icon=""; class="unknown" ;;
    esac
    
    printf '{"text": "%s", "tooltip": "TLP Profile: %s", "class": "%s"}\n' \
        "$icon" "$current" "$class"
}

show_usage() {
    cat << EOF
Usage: $(basename "$0") [COMMAND] [-v]

Commands:
    performance   Switch to performance mode
    balanced      Switch to balanced mode
    low-power     Switch to low-power mode
    next          Cycle to the next profile
    current       Show current profile name
    status        Show current profile and TLP system status
    list          List available profiles
    waybar        Output JSON for waybar module

Options:
    -v, --verbose Enable detailed output
    -h, --help    Show this help

EOF
}

main() {
    # check directory existence
    if [[ ! -d "$PROFILES_DIR" ]]; then
        log_error "Profiles directory missing at: $PROFILES_DIR"
        exit 1
    fi

    local command=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                if [[ -z "$command" ]]; then
                    command="$1"
                fi
                shift
                ;;
        esac
    done

    if [[ -z "$command" ]]; then
        show_usage
        exit 0
    fi

    case "$command" in
        waybar)
            waybar_output
            exit 0
            ;;
        current)
            get_current_profile
            exit 0
            ;;
        status)
            local current=$(get_current_profile)
            if [[ "$current" != "unknown" ]]; then
                echo -e "${BLUE}[INFO]${NC} Current profile: ${GREEN}$current${NC}"
            else
                echo -e "${YELLOW}[WARNING]${NC} Current settings do not match any known profile"
            fi
            echo ""
            sudo tlp-stat -s
            exit 0
            ;;
        list)
            get_all_profiles
            exit 0
            ;;
    esac

    if [[ "$command" == "next" ]]; then
        local current=$(get_current_profile)
        local profiles=($(get_all_profiles))
        local current_index=-1
        
        for i in "${!profiles[@]}"; do
            if [[ "${profiles[$i]}" == "$current" ]]; then
                current_index=$i
                break
            fi
        done
        
        local next_index=$(( (current_index + 1) % ${#profiles[@]} ))
        command="${profiles[$next_index]}"
        log_info "Cycling to: $command"
    fi

    if [[ "$EUID" -ne 0 ]]; then
        log_error "Switching profiles requires sudo."
        exit 1
    fi

    if validate_profile "$command"; then
        apply_profile "$command"
    else
        log_error "Invalid command or profile: $command"
        show_usage
        exit 1
    fi
}

main "$@"
