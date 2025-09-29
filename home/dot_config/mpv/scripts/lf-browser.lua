-- LF File Browser Integration for MPV
-- Ultra-Zen Philosophy: "The familiar path opens in the familiar way"
-- Launches lf terminal file manager when 'b' is pressed in mpv
-- Context-sensitive 'l' key: enters directories OR plays video files

local utils = require 'mp.utils'
local mp = require 'mp'

-- Function to launch lf file browser
function open_lf_browser()
    -- Determine starting directory
    local start_dir = ""
    local current_path = mp.get_property("path")

    if current_path ~= nil and current_path ~= "" then
        -- Playing a file - use its directory
        local directory, _ = utils.split_path(current_path)
        if directory ~= "" then
            start_dir = directory
        else
            start_dir = os.getenv("HOME") .. "/Videos"
        end
    else
        -- Nothing playing - default to ~/Videos
        start_dir = os.getenv("HOME") .. "/Videos"
        -- Fall back to ~/Downloads if Videos doesn't exist
        local videos_check = io.popen('test -d "' .. start_dir .. '" && echo "exists"')
        if videos_check:read("*a"):match("exists") == nil then
            start_dir = os.getenv("HOME") .. "/Downloads"
        end
        videos_check:close()
    end

    -- Save current fullscreen state and exit fullscreen temporarily
    -- This ensures the lf terminal window appears above mpv
    local was_fullscreen = mp.get_property_bool("fullscreen")
    if was_fullscreen then
        mp.set_property_bool("fullscreen", false)
        mp.osd_message("Browsing files...", 1)
    end

    -- Create temporary file for selection
    local selection_file = "/tmp/mpv-lf-selection-" .. tostring(mp.get_time())

    -- Create lf config for mpv mode with Kanagawa theme
    -- Note: Using literal string to avoid template issues
    local lf_config = [[
# LF MPV Browser Mode - Helix-Native Navigation
# "l" is context-sensitive like in regular lf

# Basic Settings
set shell bash
set shellopts '-eu'
set ifs "\n"
set icons true
set preview true
set hidden false
set info size:time
set sortby natural
set reverse false
set drawbox true
set borderfmt "\033[38;2;45;79;103m"  # Kanagawa selection color (blue)
set promptfmt "\033[38;2;138;154;123m[MPV Browser]\033[0m %f"  # Kanagawa green prompt

# Basic navigation
map h updir
map j down
map k up
map gg top
map ge bottom
map G bottom
map q quit

# Context-sensitive 'l' - enters directories OR selects video files
cmd open-or-select &{{
    if [ -d "$f" ]; then
        # Directory - enter it
        lf -remote "send $id open"
    else
        # File - check if it's a video
        case "$f" in
            *.mp4|*.mkv|*.avi|*.webm|*.mp3|*.flac|*.opus|*.m4a|*.mov|*.wmv|*.flv|*.mpg|*.mpeg|*.m4v|*.mp4v|*.vob|*.ogv|*.3gp|*.m2ts|*.ts|*.ogg|*.wav|*.aac|*.wma|*.m3u|*.m3u8|*.pls)
                # Video/audio file - select and quit
                echo "$f" > SELECTION_FILE_PLACEHOLDER
                lf -remote "send $id quit"
                ;;
            *)
                # Non-media file - just open for preview
                lf -remote "send $id open"
                ;;
        esac
    fi
}}

map l open-or-select

# Enter key also selects video files
cmd select-video &{{
    if [ -f "$f" ]; then
        case "$f" in
            *.mp4|*.mkv|*.avi|*.webm|*.mp3|*.flac|*.opus|*.m4a|*.mov|*.wmv|*.flv|*.mpg|*.mpeg|*.m4v|*.mp4v|*.vob|*.ogv|*.3gp|*.m2ts|*.ts|*.ogg|*.wav|*.aac|*.wma|*.m3u|*.m3u8|*.pls)
                echo "$f" > SELECTION_FILE_PLACEHOLDER
                lf -remote "send $id quit"
                ;;
            *)
                lf -remote "send $id echo 'Not a media file'"
                ;;
        esac
    else
        # Directory - enter it
        lf -remote "send $id open"
    fi
}}

map <enter> select-video

# Quick navigation shortcuts for common media directories
map gv cd ~/Videos
map gd cd ~/Downloads
map gm cd ~/Music

# Filter to show only media files visually (optional)
map f push :filter<space>
]]

    -- Replace the selection file placeholder
    lf_config = lf_config:gsub("SELECTION_FILE_PLACEHOLDER", selection_file)

    -- Write lf config to temp file
    local config_file = "/tmp/mpv-lf-config-" .. tostring(mp.get_time())
    local file = io.open(config_file, "w")
    file:write(lf_config)
    file:close()

    -- Create shell script to run lf
    local lf_script = string.format([=[#!/bin/bash
# LF launcher for MPV
cd "%s"
lf -config %s

# Clean up config file
rm -f %s
]=], start_dir, config_file, config_file)

    local script_file = "/tmp/mpv-lf-runner-" .. tostring(mp.get_time())
    file = io.open(script_file, "w")
    file:write(lf_script)
    file:close()

    -- Make script executable
    os.execute("chmod +x " .. script_file)

    -- Determine terminal to use
    local terminal_cmd
    if os.execute("command -v alacritty >/dev/null 2>&1") == 0 then
        terminal_cmd = {"alacritty", "-T", "MPV File Browser - LF", "-e", script_file}
    else
        -- Try to use $TERMINAL environment variable
        local term = os.getenv("TERMINAL")
        if term then
            terminal_cmd = {term, "-e", script_file}
        else
            -- Fallback to xterm
            terminal_cmd = {"xterm", "-e", script_file}
        end
    end

    -- Launch terminal with lf
    local result = utils.subprocess({
        args = terminal_cmd,
        cancellable = false,
    })

    -- Restore fullscreen state after lf closes
    if was_fullscreen then
        mp.set_property_bool("fullscreen", true)
    end

    -- Check if a file was selected
    local selected = io.open(selection_file, "r")
    if selected then
        local filepath = selected:read("*l")
        selected:close()

        if filepath and filepath ~= "" then
            -- Determine whether to replace or append
            local is_idle = mp.get_property("idle-active") == "yes"
            local mode = is_idle and "replace" or "append-play"

            -- Load the selected file
            mp.commandv("loadfile", filepath, mode)
            mp.osd_message("Added: " .. utils.split_path(filepath), 2)
        end

        -- Clean up selection file
        os.remove(selection_file)
    end

    -- Clean up script file
    os.remove(script_file)
end

-- Register the keybinding
mp.add_key_binding("b", "open-lf", open_lf_browser)