local M = {
  crud = {
    key = 'bc',
    desc = 'CRUD Component Pages',
    map = function()
      -- Get app name with default from git root folder
      local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
      local default_app_name = ''
      if git_root and git_root ~= '' and not git_root:match '^fatal:' then
        default_app_name = vim.fn.fnamemodify(git_root, ':t')
      end
      local app_name = vim.fn.input('App name: ', default_app_name)
      if not app_name or app_name == '' then return end

      -- Get entity name
      local entity_name = vim.fn.input 'Entity name (e.g., Product): '
      if not entity_name or entity_name == '' then return end

      -- Get plural form
      local default_plural = entity_name .. 's'
      local entity_plural = vim.fn.input('Entity plural: ', default_plural)
      if not entity_plural or entity_plural == '' then entity_plural = default_plural end

      -- Get properties (comma-separated) - OPTIONAL
      local props_input = vim.fn.input 'Properties (e.g., Name:string) [Optional]: '

      -- Parse properties
      local properties = {}
      if props_input and props_input ~= '' then
        for prop in string.gmatch(props_input, '([^,]+)') do
          local name, type = prop:match '(%w+):(%w+)'
          if name and type then table.insert(properties, { name = name, type = type }) end
        end
      end

      -- Generate property declarations for model
      local property_declarations = {}
      for _, prop in ipairs(properties) do
        local csharp_type = prop.type:sub(1, 1) .. prop.type:sub(2)
        table.insert(property_declarations, string.format('  public %s %s { get; set; }', csharp_type, prop.name))
      end

      -- Generate form fields for Create page (with null-forgiving operator)
      local create_form_fields = {}
      for _, prop in ipairs(properties) do
        local input_type = 'InputText'
        if prop.type == 'int' or prop.type == 'decimal' or prop.type == 'double' or prop.type == 'float' then
          input_type = 'InputNumber'
        elseif prop.type == 'bool' or prop.type == 'boolean' then
          input_type = 'InputCheckbox'
        elseif prop.type == 'DateTime' or prop.type == 'date' then
          input_type = 'InputDate'
        end

        table.insert(
          create_form_fields,
          string.format(
            [[      <div>
        <label for="%s">%s</label>
        <%s id="%s" @bind-Value="%s!.%s" />
        <ValidationMessage For="@(() => %s.%s)" />
      </div>]],
            prop.name:lower(),
            prop.name,
            input_type,
            prop.name:lower(),
            entity_name,
            prop.name,
            entity_name,
            prop.name
          )
        )
      end

      -- Generate form fields for Edit page (without null-forgiving operator)
      local edit_form_fields = {}
      for _, prop in ipairs(properties) do
        local input_type = 'InputText'
        if prop.type == 'int' or prop.type == 'decimal' or prop.type == 'double' or prop.type == 'float' then
          input_type = 'InputNumber'
        elseif prop.type == 'bool' or prop.type == 'boolean' then
          input_type = 'InputCheckbox'
        elseif prop.type == 'DateTime' or prop.type == 'date' then
          input_type = 'InputDate'
        end

        table.insert(
          edit_form_fields,
          string.format(
            [[          <div>
            <label for="%s">%s</label>
            <%s id="%s" @bind-Value="%s.%s" />
            <ValidationMessage For="@(() => %s.%s)" />
          </div>]],
            prop.name:lower(),
            prop.name,
            input_type,
            prop.name:lower(),
            entity_name,
            prop.name,
            entity_name,
            prop.name
          )
        )
      end

      -- Generate PropertyColumn elements for QuickGrid
      local property_columns = {}
      for _, prop in ipairs(properties) do
        local format_attr = ''
        if prop.type == 'DateTime' or prop.type == 'date' then format_attr = ' Format="dd/MM/yyyy"' end

        local entity_lower = entity_name:lower()
        table.insert(
          property_columns,
          string.format(
            '  <PropertyColumn Property="%s => %s.%s"%s />',
            entity_lower,
            entity_lower,
            prop.name,
            format_attr
          )
        )
      end

      -- Generate display fields for Details page (single <dl> wrapper)
      local detail_fields = {}
      for _, prop in ipairs(properties) do
        table.insert(
          detail_fields,
          string.format(
            [[      <dt>%s</dt>
      <dd>@%s.%s</dd>]],
            prop.name,
            entity_name:lower(),
            prop.name
          )
        )
      end

      -- Generate display fields for Delete page (separate <dl> per property)
      local delete_fields = {}
      for _, prop in ipairs(properties) do
        table.insert(
          delete_fields,
          string.format(
            [[    <dl>
      <dt>%s</dt>
      <dd>@%s.%s</dd>
    </dl>]],
            prop.name,
            entity_name:lower(),
            prop.name
          )
        )
      end

      local files = {
        -- Model
        [entity_name .. '.cs'] = require('plugins.mini.files.scaffold.blazor.model').gen_file_content(
          entity_name,
          entity_plural,
          property_declarations
        ),

        -- Index Page
        ['Index.razor'] = require('plugins.mini.files.scaffold.blazor.index').gen_file_content(
          app_name,
          entity_name,
          entity_plural,
          property_columns
        ),

        -- Create Page
        ['Create.razor'] = require('plugins.mini.files.scaffold.blazor.create').gen_file_content(
          app_name,
          entity_name,
          entity_plural,
          create_form_fields
        ),

        -- Edit Page
        ['Edit.razor'] = require('plugins.mini.files.scaffold.blazor.edit').gen_file_content(
          app_name,
          entity_name,
          entity_plural,
          edit_form_fields
        ),

        -- Details Page
        ['Details.razor'] = require('plugins.mini.files.scaffold.blazor.details').gen_file_content(
          app_name,
          entity_name,
          entity_plural,
          detail_fields
        ),

        -- Delete Page
        ['Delete.razor'] = require('plugins.mini.files.scaffold.blazor.delete').gen_file_content(
          app_name,
          entity_name,
          entity_plural,
          delete_fields
        ),
      }

      require('plugins.mini.files.utils').create_scaffold(entity_plural .. 'Pages', files)
    end,
  },
}

return M
