#!/bin/bash

# Иконки
BAT_ICON="battery:"
RAM_ICON="ram:"
CLOCK_ICON="time:"
BRIGHT_ICON="bright:"
VOL_ICON="volume:"
MUTE_ICON="mute:"
LAYOUT_EN="EN"
LAYOUT_RU="RU"


# Функция для корректного завершения
cleanup() {
    echo "Завершение скрипта статусбара..."
    exit 0
}

# Ловим сигналы завершения
trap cleanup SIGTERM SIGINT SIGHUP

# Проверяем, что мы в сессии dwm
check_dwm_session() {
    # Ищем процесс dwm, принадлежащий текущему пользователю
    ! pgrep -u $UID dwm >/dev/null
}

# Надёжная функция определения раскладки
get_keyboard_layout() {
    # Используем xkb-switch как основной метод
    local current_layout=$(xkb-switch -p 2>/dev/null)
    
    # Если xkb-switch не сработал, используем fallback
    if [ -z "$current_layout" ]; then
        current_layout=$(setxkbmap -query | grep layout | awk '{print $2}' | cut -d, -f1)
    fi
    
    # Определяем язык на основе полученного значения
    case "$current_layout" in
        ru|Ru|RU|rus|1049)
            echo "$LAYOUT_RU"
            ;;
        *)
            echo "$LAYOUT_EN"
            ;;
    esac
}

# Функция для получения уровня громкости через PipeWire
get_volume_pipewire() {
    # Получаем информацию о текущем sink (устройстве вывода)
    local default_sink=$(pactl get-default-sink)
    [ -z "$default_sink" ] && return
    
    local volume_info=$(pactl get-sink-volume "$default_sink")
    local volume=$(echo "$volume_info" | awk '/Volume:/ {print $5}' | tr -d '%')
    local mute_status=$(pactl get-sink-mute "$default_sink" | awk '{print $2}')
    
    if [ "$mute_status" = "yes" ]; then
        echo "${MUTE_ICON} ${volume}%"
    else
        echo "${VOL_ICON} ${volume}%"
    fi
}

# Функция для получения уровня яркости
get_brightness() {
    if [ -d /sys/class/backlight/ ]; then
        local brightness_path=$(find /sys/class/backlight/ -maxdepth 1 -mindepth 1 | head -1)
        [ -z "$brightness_path" ] && return
        
        local brightness=$(cat "$brightness_path/brightness" 2>/dev/null)
        local max_brightness=$(cat "$brightness_path/max_brightness" 2>/dev/null)
        
        [ -z "$brightness" ] || [ -z "$max_brightness" ] && return
        
        local brightness_pct=$((brightness * 100 / max_brightness))
        echo "${BRIGHT_ICON} ${brightness_pct}%"
    else
        echo ""
    fi
}

# Функция для получения информации о батарее
get_battery() {
    local bat_path=$(find /sys/class/power_supply/ -maxdepth 1 -name 'BAT*' | head -1)
    [ -n "$bat_path" ] || return
    
    local bat_capacity=$(cat "$bat_path/capacity" 2>/dev/null)
    [ -z "$bat_capacity" ] && return
    
    echo "${BAT_ICON} ${bat_capacity}%"
}

# Функция для получения информации о памяти
get_memory() {
    local ram_used=$(free -m | awk '/Mem:/ {printf "%.1fG", $3/1024}')
    echo "${RAM_ICON} ${ram_used}"
}

# Основной цикл
while true; do

    if check_dwm_session; then
        cleanup
    fi

    # Получаем данные
    LAYOUT=$(get_keyboard_layout)
    VOLUME=$(get_volume_pipewire)
    BRIGHT=$(get_brightness)
    BAT=$(get_battery)
    RAM=$(get_memory)
    TIME="${CLOCK_ICON} $(date '+%H:%M')"

    # Формируем строку статуса
    STATUS_STR=""
    [ -n "$BAT" ] && STATUS_STR+="${BAT} | "
    [ -n "$BRIGHT" ] && STATUS_STR+="${BRIGHT} | "
    STATUS_STR+="${VOLUME} | ${LAYOUT} | ${RAM} | ${TIME}"
    
    # Обновляем статус dwm
    xsetroot -name "$STATUS_STR"
    
    sleep 0.1
done
