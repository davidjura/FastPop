--DATASAVER
--Save score data in JSON format
module(..., package.seeall)

require "json"

function saveValue(key, value)
	--temp variable
	local app

	local filename = "app.data"
	local base = system.ResourceDirectory

	local path = system.pathForFile( filename, base )
	local file = io.open( path, "r" )
	if file then
		-- read all contents of file into a string
		local contents = file:read( "*a" )
		app = json.decode(contents)
		io.close( file )

		if(not app.data) then
			app.data = {}
		end

		app.data[key] = value

		contents = json.encode(app)

		local file = io.open( path, "w" )

		file:write( contents )

		io.close( file )
	else
		--if file doesn't exist
		--create default structure
		app = {data = {}}
		app.data[key] = value

		local contents = json.encode(app)
		local file = io.open( path, "w" )

		file:write( contents )
		io.close( file )
	end
end
function loadValue(key)
	--temp variable
	local app

	local filename = "app.data"
	local base = system.ResourceDirectory
	-- create a file path for corona i/o
	local path = system.pathForFile( filename, base )
	local file = io.open( path, "r" )
	if file then
		--read contents
		local contents = file:read( "*a" )
		app = json.decode(contents)
		if(not app.data) then app.data = {}; end

		return app.data[key]
	end

	return nil
end
function save( filename, dataTable )
	filename = filename..".json"
	--encode table into json string
	local jsonString = json.encode( dataTable )
	-- create a file path for corona i/o
	local path = system.pathForFile( filename, system.ResourceDirectory )
	local file = io.open( path, "w" )
	if file then
	   file:write( jsonString )

	   io.close( file )
	end
end

function load( filename )
	filename = filename..".json"
	local base = system.ResourceDirectory
	local path = system.pathForFile( filename, base )
	local contents
	local file = io.open( path, "r" )
	if file then
		contents = file:read( "*a" )
		io.close( file )
		return json.decode( contents )
	else
		return nil
	end
end

