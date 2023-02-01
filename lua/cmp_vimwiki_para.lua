local source = {}

-- Directory at { user home }/notes/vault
local rootDir = vim.fn.expand("~/notes/vault")

source.new = function()
    local self = setmetatable({}, {__index = source})
    self.cache = {}
    return self
end

function source.is_available()
  --check if rootDir exists
  return vim.fn.isdirectory(rootDir) == 1
end

function source.get_debug_name()
    return "wiki-para"
end

-- make a array of the trigger characters strings: "[["
function source.get_trigger_characters()
    return { "[", "[" }
end

function source.get_keyword_pattern()
   -- A pattern that accepts any characters inside the [[ ]]
    return [[\[\[\k*]]
end

-- This function reads names of all markdown files in the rootDir
-- and returns a list of filenames stripped of the markdown extension .md
-- as a table that could be used as a completion item.
local function get_vimwiki_para()
    local it = {}
    local used = {}

    for file in io.popen("find " .. rootDir .. " -type f -name '*.md'"):lines() do
        local filename = vim.fn.fnamemodify(file, ":t:r")
        if (not used[filename]) then
            table.insert(it, {label = "[[" .. filename .. "]]"})
            used[filename] = true
        end
    end

    return it
end

function source.complete(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    local items = {}

    if not self.cache[bufnr] then
        items = get_vimwiki_para()
        if type(items) ~= "table" then
            return callback()
        end
        self.cache[bufnr] = items
    else
        items = self.cache[bufnr]
    end

    callback({items = items or {}, isIncomplete = false})
end

function source.resolve(_, completion_item, callback)
    callback(completion_item)
end

function source.execute(_, completion_item, callback)
    callback(completion_item)
end

return source
