
local Messages = {
  ["show_research_info"] = "Show research progress",
  ["show_side_menu"] = "Show side menu",
  ["show_minimap"] = "Show minimap",
  ["show_controller_gui"] = "Show toolbar",
  ["show_shortcut_bar"] = "Show shortcut bar",
  ["show_alert_gui"] = "Show alerts",
  ["show_rail_block_visualisation"] = "Always show rail block visualisation",
}


script.on_event("toggle_view_all", function(event)
  global.gui_hidden = global.gui_hidden or {}
  local player = game.players[event.player_index]
  if global.gui_hidden[event.player_index] then
    player.game_view_settings["show_research_info"] = true
    player.game_view_settings["show_side_menu"] = true
    player.game_view_settings["show_minimap"] = true
    player.game_view_settings["show_controller_gui"] = true
    player.game_view_settings["show_shortcut_bar"] = true
    player.game_view_settings["show_alert_gui"] = true
    player.game_view_settings["show_map_view_options"] = true
    player.game_view_settings["update_entity_selection"] = true
    global.gui_hidden[event.player_index] = nil
    player.surface.create_entity{
      name="flying-text",
      position=player.position,
      text="All GUI elements on",
      color={r=0,g=1,b=0}
    }
  else
    player.clear_cursor()
    player.clear_selected_entity()
    player.game_view_settings["show_research_info"] = false
    player.game_view_settings["show_side_menu"] = false
    player.game_view_settings["show_minimap"] = false
    player.game_view_settings["show_controller_gui"] = false
    player.game_view_settings["show_shortcut_bar"] = false
    player.game_view_settings["show_alert_gui"] = false
    player.game_view_settings["show_map_view_options"] = false
    player.game_view_settings["update_entity_selection"] = false
    player.game_view_settings["show_rail_block_visualisation"] = false
    global.gui_hidden[event.player_index] = true
    player.surface.create_entity{
      name="flying-text",
      position=player.position,
      text="All GUI elements off",
      color={r=1,g=0,b=0}
    }
  end
end)

function toggle_view_setting(player_index, view_setting, show_text)
  local player = game.players[player_index]
  if player.game_view_settings[view_setting] then
    player.game_view_settings[view_setting] = false
    if show_text then
      player.surface.create_entity{
        name="flying-text",
        position=player.position,
        text=Messages[view_setting].." off",
        color={r=1,g=0,b=0}
      }
    end
  else
    player.game_view_settings[view_setting] = true
    if show_text then
      player.surface.create_entity{
        name="flying-text",
        position=player.position,
        text=Messages[view_setting].." on",
        color={r=0,g=1,b=0}
      }
    end
  end
end

script.on_event("toggle_view_research", function(event)
  toggle_view_setting(event.player_index, "show_research_info", true)
end)
script.on_event("toggle_view_menu", function(event)
  toggle_view_setting(event.player_index, "show_side_menu", true)
end)
script.on_event("toggle_view_map", function(event)
  toggle_view_setting(event.player_index, "show_minimap", true)
end)

script.on_event("toggle_view_toolbar", function(event)
  toggle_view_setting(event.player_index, "show_controller_gui", true)
end)
script.on_event("toggle_view_shortcut_bar", function(event)
  toggle_view_setting(event.player_index, "show_shortcut_bar", true)
end)
script.on_event("toggle_view_alerts", function(event)
  toggle_view_setting(event.player_index, "show_alert_gui", true)
end)

script.on_event("toggle_view_rail_blocks", function(event)
  toggle_view_setting(event.player_index, "show_rail_block_visualisation", true)
end)


