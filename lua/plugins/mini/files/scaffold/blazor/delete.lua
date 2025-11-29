local M = {}

M.template = [[@page "/%s/delete/{Id:int}"
@using Microsoft.EntityFrameworkCore
@using %s.Models
@inject %s.Data.ApplicationDbContext DbContext
@inject NavigationManager Navigation

<PageTitle>Delete</PageTitle>

<h1>Delete</h1>

<h3>Are you sure you want to delete this?</h3>
<div>
  <h4>%s</h4>
  <hr />
  @if (%s is null)
  {
    <p><em>Loading...</em></p>
  }
  else
  {
%s

    <EditForm method="post" Model="%s" OnValidSubmit="Delete%s" FormName="delete" Enhance>
      <a href="/%s">Back to List</a>
      <button type="submit" disabled="@(%s is null)">Delete</button>
    </EditForm>
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

  public async Task Delete%s()
  {
    DbContext.%s.Remove(%s!);
    await DbContext.SaveChangesAsync();
    Navigation.NavigateTo("/%s");
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
    table.concat(detail_fields, '\n'), -- 6: detail display fields
    entity_lower, -- 7: EditForm Model
    entity_name, -- 8: OnValidSubmit method name (Delete{Entity})
    entity_plural_lower, -- 9: Back to List href
    entity_lower, -- 10: button disabled check
    entity_name, -- 11: variable type declaration
    entity_lower, -- 12: variable name
    entity_lower, -- 13: variable assignment
    entity_plural, -- 14: DbContext collection (FirstOrDefaultAsync)
    entity_lower, -- 15: null check after load
    entity_name, -- 16: Delete{Entity} method name
    entity_plural, -- 17: DbContext collection (Remove)
    entity_lower, -- 18: variable to remove (with !)
    entity_plural_lower -- 19: NavigateTo path
  )
end

return M
