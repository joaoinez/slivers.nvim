local M = {}

M.template = [[page "/%s/details/{Id:int}"
@using Microsoft.EntityFrameworkCore
@using %s.Models
@inject %s.Data.ApplicationDbContext DbContext
@inject NavigationManager Navigation

<PageTitle>Details</PageTitle>

<h1>Details</h1>

<div>
  <h4>%s</h4>
  <hr />
  @if (%s is null)
  {
    <p><em>Loading...</em></p>
  }
  else
  {
    <dl>
%s
    </dl>

    <div>
      <a href="/%s">Back to List</a>
      <a href="/%s/edit/@Id">Edit</a>
      <a href="/%s/delete/@Id">Delete</a>
    </div>
  }
</div>

@code {
  %s? %s;

  [Parameter]
  public int Id { get; set; }


  protected override async Task OnInitializedAsync()
  {
    %s = await DbContext.%s.FirstOrDefaultAsync(m => m.Id == Id);

    if (%s is null)
    {
      Navigation.NavigateTo("notfound");
    }
  }
}
]]

function M.gen_file_content(app_name, entity_name, entity_plural, detail_fields)
  local entity_lower = entity_name:lower()
  local entity_plural_lower = entity_plural:lower()

  return string.format(
    M.template,
    entity_plural_lower, -- 1: route path
    entity_plural, -- 2: entity plural for Models using
    app_name, -- 3: app name for DbContext inject
    entity_name, -- 4: h4 entity name
    entity_lower, -- 5: variable for null check
    table.concat(detail_fields, '\n'), -- 6: detail display fields (dt/dd)
    entity_plural_lower, -- 7: Back to List href
    entity_plural_lower, -- 8: Edit href
    entity_plural_lower, -- 9: Delete href
    entity_name, -- 10: variable type declaration
    entity_lower, -- 11: variable name
    entity_lower, -- 12: variable assignment
    entity_plural, -- 13: DbContext collection
    entity_lower -- 14: null check after load
  )
end

return M
