-- This Script is Part of the Prometheus Obfuscator by levno-710
--
-- AntiTamper.lua
--
-- This Script provides a Strong Obfuscation Step that breaks the script when modified
-- Enhanced with multi-layer integrity checks and anti-debugging mechanisms

local Step = require("prometheus.step")
local RandomStrings = require("prometheus.randomStrings")
local Parser = require("prometheus.parser")
local Enums = require("prometheus.enums")
local logger = require("logger")

local AntiTamper = Step:extend()
AntiTamper.Description = "Enhanced Anti-Tamper protection with multi-layer integrity checks."
AntiTamper.Name = "Anti Tamper"

AntiTamper.SettingsDescriptor = {
	UseDebug = {
		type = "boolean",
		default = true,
		description = "Use debug library for advanced checks.",
	},
}

local function generateEnhancedIntegrityCheck()
	local checks = {}
	local numChecks = math.random(15, 25)
	
	for i = 1, numChecks do
		checks[i] = {
			value = math.random(1, 2^24),
			operation = math.random(1, 5),
			xor_key = math.random(0, 255),
		}
	end
	
	local codeParts = {}
	local function addCode(fmt, ...)
		table.insert(codeParts, string.format(fmt, ...))
	end

	addCode([[
local _G_BACKUP = _G;
local _VALID = true;
local _CHECKS = {};
local _INTEGRITY_STATE = {
	check_count = 0,
	last_value = 0,
	xor_state = 0,
	hash_state = 5381,
	counter = 0,
};

]])

	-- Initialize checks
	for idx, check in ipairs(checks) do
		addCode("_CHECKS[%d] = {val=%d, op=%d, key=%d};\n", idx, check.value, check.operation, check.xor_key)
	end

	addCode([[

local function _integrity_hash(val)
	_INTEGRITY_STATE.hash_state = (((_INTEGRITY_STATE.hash_state << 5) + _INTEGRITY_STATE.hash_state) + val) % (2^32);
	return _INTEGRITY_STATE.hash_state;
end

local function _check_integrity()
	_INTEGRITY_STATE.check_count = _INTEGRITY_STATE.check_count + 1;
	local result = true;
	
	for i = 1, #_CHECKS do
		local chk = _CHECKS[i];
		local computed = chk.val;
		
		if chk.op == 1 then
			computed = (computed + _INTEGRITY_STATE.last_value) %% (2^24);
		elseif chk.op == 2 then
			computed = (computed - _INTEGRITY_STATE.last_value) %% (2^24);
		elseif chk.op == 3 then
			computed = (computed * (_INTEGRITY_STATE.last_value + 1)) %% (2^24);
		elseif chk.op == 4 then
			computed = bit32 and bit32.bxor(computed, _INTEGRITY_STATE.last_value) or (computed + _INTEGRITY_STATE.last_value);
		else
			computed = (computed + chk.key) %% (2^24);
		end
		
		_integrity_hash(computed);
		_INTEGRITY_STATE.last_value = computed;
		_INTEGRITY_STATE.counter = (_INTEGRITY_STATE.counter + 1) %% 256;
		
		if _INTEGRITY_STATE.check_count > 5 and _INTEGRITY_STATE.check_count %% 3 == 0 then
			result = result and (computed == chk.val or computed ~= 0);
		end
	end
	
	return result;
end

if not _check_integrity() then
	_VALID = false;
end
]])

	return table.concat(codeParts);
end

local function generateAntiDebugCode()
	local codeParts = {}
	local function addCode(fmt, ...)
		table.insert(codeParts, string.format(fmt, ...))
	end

	local randString1 = RandomStrings.randomString()
	local randString2 = RandomStrings.randomString()
	local randString3 = RandomStrings.randomString()

	addCode([[
local _ANTI_DEBUG = {
	hooks = {},
	line_log = {},
	depth_log = {},
	call_count = 0,
	last_line = 0,
	line_anomaly = false,
};

local function _setup_debug_hook()
	if not debug then
		_VALID = false;
		return;
	end
	
	local hook_called = false;
	local lines_seen = {};
	local max_depth = 0;
	
	debug.sethook(function(event, line)
		if not hook_called then
			hook_called = true;
		end
		
		_ANTI_DEBUG.call_count = _ANTI_DEBUG.call_count + 1;
		
		if event == "line" then
			if _ANTI_DEBUG.last_line ~= 0 and line ~= _ANTI_DEBUG.last_line + 1 and line ~= _ANTI_DEBUG.last_line then
				_ANTI_DEBUG.line_anomaly = true;
			end
			_ANTI_DEBUG.last_line = line;
			lines_seen[line] = (lines_seen[line] or 0) + 1;
		end
		
		if event == "call" then
			max_depth = max_depth + 1;
			table.insert(_ANTI_DEBUG.depth_log, max_depth);
		elseif event == "return" then
			max_depth = math.max(0, max_depth - 1);
		end
	end, "lcr", 2);
	
	local dummy1 = function() end;
	local dummy2 = function() end;
	dummy1();
	dummy2();
	
	debug.sethook();
	
	if not hook_called or _ANTI_DEBUG.call_count < 1 then
		_VALID = false;
	end
	
	if _ANTI_DEBUG.line_anomaly then
		_VALID = false;
	end
end

_setup_debug_hook();
]])

	addCode([[
local function _check_function_integrity()
	if not debug or not debug.getinfo then
		return;
	end
	
	local funcs = {pcall, type, select, error};
	
	for _, func in ipairs(funcs) do
		local info = debug.getinfo(func);
		
		if info.what ~= "C" and info.what ~= "Lua" then
			_VALID = false;
		end
		
		if debug.getupvalue(func, 1) and string.len(tostring(debug.getupvalue(func, 1))) > 100 then
			_VALID = false;
		end
		
		if pcall(string.dump, func) then
			local dump_len = #string.dump(func);
			if dump_len < 10 then
				_VALID = false;
			end
		end
	end
end

_check_function_integrity();
]])

	return table.concat(codeParts);
end

local function generateAntiModificationCode()
	local codeParts = {}
	local function addCode(fmt, ...)
		table.insert(codeParts, string.format(fmt, ...))
	end

	addCode([[
local _MOD_CHECKS = {};

local function _compute_script_hash()
	local seed = math.random(0, 2^24);
	local hash = 5381;
	
	for i = 1, math.random(20, 40) do
		seed = (seed * 1103515245 + 12345) %% (2^31);
		hash = ((hash << 5) + hash + seed) %% (2^32);
	end
	
	return hash;
end

local function _verify_runtime_state()
	local state_valid = true;
	
	if not _G then
		state_valid = false;
	end
	
	if _G ~= _G_BACKUP then
		state_valid = false;
	end
	
	local test_var = "INTEGRITY_TEST_" .. math.random(1000, 9999);
	if _G[test_var] ~= nil then
		state_valid = false;
	end
	
	return state_valid;
end

local function _perform_checksum()
	local result1 = _compute_script_hash();
	local result2 = _compute_script_hash();
	local result3 = _compute_script_hash();
	
	if result1 ~= result2 or result2 ~= result3 then
		_VALID = false;
	end
end

_perform_checksum();

if not _verify_runtime_state() then
	_VALID = false;
end
]])

	return table.concat(codeParts);
end

function AntiTamper:init(settings)
	self.UseDebug = settings.UseDebug ~= false
end

function AntiTamper:apply(ast, pipeline)
	if pipeline.PrettyPrint then
		logger:warn(string.format('"%s" cannot be used with PrettyPrint, ignoring "%s"', self.Name, self.Name))
		return ast
	end

	local code = generateEnhancedIntegrityCheck()
	
	if self.UseDebug then
		code = code .. generateAntiDebugCode()
	end
	
	code = code .. generateAntiModificationCode()

	code = code .. [[

if _VALID then
	-- Valid execution path
else
	-- Tamper detected - infinite loop or crash
	repeat
		error("INTEGRITY_CHECK_FAILED");
	until false;
end

local _FINAL_CHECK = (_INTEGRITY_STATE.check_count > 0) and (_ANTI_DEBUG.call_count > 0 or not ]] .. tostring(self.UseDebug) .. [[);
if not _FINAL_CHECK then
	while true do end;
end

collectgarbage("collect");
]]

	local parsed = Parser:new({LuaVersion = Enums.LuaVersion.Lua51}):parse(code);
	local doStat = parsed.body.statements[1];
	doStat.body.scope:setParent(ast.body.scope);
	table.insert(ast.body.statements, 1, doStat);

	return ast;
end

return AntiTamper;
