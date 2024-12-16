local maps = Slivers.keymaps.get_mappings_template()

-- Disable arrow keys in normal mode
maps.n['<left>'] = { '<nop>' }
maps.n['<down>'] = { '<nop>' }
maps.n['<up>'] = { '<nop>' }
maps.n['<right>'] = { '<nop>' }

-- Disable `s` key for flash and surround plugins
maps.n['s'] = { '<nop>' }
maps.x['s'] = { '<nop>' }

Slivers.keymaps.set_mappings(maps)
