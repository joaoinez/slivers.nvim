local M = {}

M.template = [[@page "/%s/create"
@using Microsoft.EntityFrameworkCore
@using %s.Models
@inject %s.Data.ApplicationDbContext DbContext
@inject NavigationManager Navigation
@rendermode InteractiveServer

<PageTitle>Create</PageTitle>

<h1>Create</h1>

<h4>%s</h4>
<hr />
<div>
  <EditForm method="post" Model="%s" OnValidSubmit="Add%s" FormName="create" Enhance>
    <DataAnnotationsValidator />
    <ValidationSummary />

%s

    <div>
      <a href="/%s">Back to List</a>
      <button type="submit">Create</button>
    </div>
  </EditForm>
</div>

@code {
  [SupplyParameterFromForm]
  private %s? %s { get; set; }

  protected override void OnInitialized() => %s ??= new();

  // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
  private async Task Add%s()
  {
    DbContext.%s.Add(%s!);
    await DbContext.SaveChangesAsync();
    Navigation.NavigateTo("/%s");
  }
}
]]

function M.gen_file_content(app_name, entity_name, entity_plural, form_fields)
  local entity_plural_lower = entity_plural:lower()

  return string.format(
    M.template,
    entity_plural_lower, -- 1: route path
    entity_plural, -- 2: entity plural for Models using
    app_name, -- 3: app name for DbContext inject
    entity_name, -- 4: page h4 title
    entity_name, -- 5: EditForm Model
    entity_name, -- 6: OnValidSubmit method name (Add{Entity})
    table.concat(form_fields, '\n'), -- 7: form field inputs
    entity_plural_lower, -- 8: Back to List href
    entity_name, -- 9: property type in @code
    entity_name, -- 10: property name in @code
    entity_name, -- 11: property initialization
    entity_name, -- 12: Add{Entity} method name
    entity_plural, -- 13: DbContext collection
    entity_name, -- 14: entity to add (with !)
    entity_plural_lower -- 15: NavigateTo path
  )
end

return M
