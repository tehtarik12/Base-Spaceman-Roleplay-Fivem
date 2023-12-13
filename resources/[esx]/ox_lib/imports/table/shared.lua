-- Add additional functions to the standard table library

---@class oxtable : tablelib
lib.table = table
local pairs = pairs

---@param tbl table
---@param value any
---@return boolean
---Checks if tbl contains the given values. Only intended for simple values and unnested tables.
local function contains(tbl, value)
	if type(value) ~= 'table' then
		for _, v in pairs(tbl) do
			if v == value then return true end
		end
	else
		local matched_values = 0
		local values = 0
		for _, v1 in pairs(value) do
			values += 1

			for _, v2 in pairs(tbl) do
				if v1 == v2 then matched_values += 1 end
			end
		end
		if matched_values == values then return true end
	end

	return false
end

---@param t1 any
---@param t2 any
---@return boolean
---Compares if two values are equal, iterating over tables and matching both keys and values.
local function table_matches(t1, t2)
	local type1, type2 = type(t1), type(t2)

	if type1 ~= type2 then return false end
	if type1 ~= 'table' and type2 ~= 'table' then return t1 == t2 end

	for k1,v1 in pairs(t1) do
	   local v2 = t2[k1]
	   if v2 == nil or not table_matches(v1,v2) then return false end
	end

	for k2,v2 in pairs(t2) do
	   local v1 = t1[k2]
	   if v1 == nil or not table_matches(v1,v2) then return false end
	end

	return true
end

---@generic T
---@param tbl T
---@return T
---Recursively clones a table to ensure no table references.
local function table_deepclone(tbl)
	tbl = table.clone(tbl)

	for k, v in pairs(tbl) do
		if type(v) == 'table' then
			tbl[k] = table_deepclone(v)
		end
	end

	return tbl
end

---@param t1 table
---@param t2 table
---@return table
---Merges two tables together. Duplicate keys will be added together if they are numbers, or otherwise overwritten.
local function table_merge(t1, t2)
    for k, v in pairs(t2) do
        local type1 = type(t1[k])
        local type2 = type(v)

		if type1 == 'table' and type2 == 'table' then
            table_merge(t1[k], v)
        elseif type1 == 'number' and type2 == 'number' then
            t1[k] += v
		else
			t1[k] = v
        end
    end

    return t1
end

lib.table.contains = contains
lib.table.matches = table_matches
lib.table.deepclone = table_deepclone
lib.table.merge = table_merge

table = lib.table

return lib.table