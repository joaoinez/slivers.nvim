local M = {}

M.template = [[@page "/%s"
@using Microsoft.AspNetCore.Components.QuickGrid
@inject %s.Data.ApplicationDbContext DbContext
@using %s.Models

<PageTitle>Index</PageTitle>

<h1>Index</h1>

<h4>%s</h4>
<hr />

<p>
  <a href="%s/create">Create New</a>
</p>

<QuickGrid Items="DbContext.%s">
%s
  <TemplateColumn Context="%s">
    <a href="@($"/%s/edit/{%s.Id}")">Edit</a>
    <a href="@($"/%s/details/{%s.Id}")">Details</a>
    <a href="@($"/%s/delete/{%s.Id}")">Delete</a>
  </TemplateColumn>
</QuickGrid>
]]

function M.gen_file_content(app_name, entity_name, entity_plural, property_columns)
  local entity_lower = entity_name:lower()
  local entity_plural_lower = entity_plural:lower()

  return string.format(
    M.template,
    entity_plural_lower, -- 1: route path
    app_name, -- 2: app name for DbContext inject
    entity_plural, -- 3: entity plural for Models using
    entity_plural, -- 4: page title (plural)
    entity_plural_lower, -- 5: href for create link
    entity_plural, -- 6: DbContext collection
    table.concat(property_columns, '\n'), -- 7: PropertyColumn elements
    entity_lower, -- 8: TemplateColumn Context name
    entity_plural_lower, -- 9: href for edit
    entity_lower, -- 10: variable for edit Id
    entity_plural_lower, -- 11: href for details
    entity_lower, -- 12: variable for details Id
    entity_plural_lower, -- 13: href for delete
    entity_lower -- 14: variable for delete Id
  )
end

return M
