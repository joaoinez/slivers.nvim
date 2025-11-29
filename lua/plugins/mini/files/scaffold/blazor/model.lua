local M = {}

M.template = [[namespace %s.Models;

public class %s
{
  public int Id { get; set; }
%s
}
]]

function M.gen_file_content(entity_name, entity_plural, property_declarations)
  return string.format(M.template, entity_plural, entity_name, table.concat(property_declarations, '\n'))
end

return M
