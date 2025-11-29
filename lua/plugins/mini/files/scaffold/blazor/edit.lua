local M = {}

M.template = [[page "/%s/edit/{Id:int}"
@using Microsoft.EntityFrameworkCore
@using %s.Models
@inject %s.Data.ApplicationDbContext DbContext
@inject NavigationManager Navigation
@rendermode InteractiveServer

<PageTitle>Edit</PageTitle>

<h1>Edit</h1>

<div>
  <h4>%s</h4>
  <hr />
  @if (%s is null)
  {
    <p><em>Loading...</em></p>
  }
  else
  {
    <div>
      <EditForm Model="%s" OnValidSubmit="Update%s" FormName="edit" Enhance>
        <DataAnnotationsValidator />
        <ValidationSummary />

        <input type="hidden" name="%s.Id" value="@%s.Id" />

%s

        <div>
          <a href="/%s">Back to List</a>
          <button type="submit">Save</button>
        </div>
      </EditForm>
    </div>
  }
</div>

@code {
  [Parameter]
  public int Id { get; set; }

  [SupplyParameterFromForm]
  public %s? %s { get; set; }

  protected override async Task OnInitializedAsync()
  {
    %s ??= await DbContext.%s.FirstOrDefaultAsync(m => m.Id == Id);

    if (%s is null)
    {
      Navigation.NavigateTo("notfound");
    }
  }

  // To protect from overposting attacks, enable the specific properties you want to bind to.
  // For more details, see https://aka.ms/RazorPagesCRUD
  private async Task Update%s()
  {
    DbContext.Attach(%s!).State = EntityState.Modified;

    try {
      await DbContext.SaveChangesAsync();
    }
    catch (DbUpdateConcurrencyException)
    {
      if (!%sExists(%s!.Id))
      {
        Navigation.NavigateTo("notfound");
      }
      else
      {
        throw;
      }
    }

    Navigation.NavigateTo("/%s");
  }

  private bool %sExists(int id)
  {
    return DbContext.%s.Any(m => m.Id == id);
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
    entity_name, -- 4: h4 entity name
    entity_name, -- 5: variable for null check
    entity_name, -- 6: EditForm Model
    entity_name, -- 7: OnValidSubmit method name (Update{Entity})
    entity_name, -- 8: hidden input name
    entity_name, -- 9: hidden input value
    table.concat(form_fields, '\n'), -- 10: form field inputs
    entity_plural_lower, -- 11: Back to List href
    entity_name, -- 12: property type declaration (public)
    entity_name, -- 13: property name
    entity_name, -- 14: property initialization
    entity_plural, -- 15: DbContext collection
    entity_name, -- 16: null check after load
    entity_name, -- 17: Update{Entity} method name
    entity_name, -- 18: entity to attach (with !)
    entity_name, -- 19: {Entity}Exists check
    entity_name, -- 20: entity Id for exists check (with !)
    entity_plural_lower, -- 21: NavigateTo path
    entity_name, -- 22: {Entity}Exists method name
    entity_plural -- 23: DbContext collection (Any)
  )
end

return M
