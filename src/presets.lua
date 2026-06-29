-- This Script is Part of the Prometheus Obfuscator by levno-710
--
-- presets.lua
--
-- This Script provides the predefined obfuscation presets for Prometheus

return {
	-- Minifies your code. Does not obfuscate it. No performance loss.
	["Minify"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {},
	},

	-- Weak obfuscation. Very readable, low performance loss.
	["Weak"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			{ Name = "Vmify", Settings = {} },
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 1,
					StringsOnly = true
				},
			},
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- This is here for the tests.lua file.
	-- It helps isolate any problems with the Vmify step.
	-- It is not recommended to use this preset for obfuscation.
	-- Use the Weak, Medium, or Strong for obfuscation instead.
	["Vmify"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			{ Name = "Vmify", Settings = {} },
		},
	},

	-- Medium obfuscation. Moderate obfuscation, moderate performance loss.
	["Medium"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			{ Name = "EncryptStrings", Settings = {} },
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = false,
				},
			},
			{ Name = "Vmify", Settings = {} },
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 1,
					StringsOnly = true,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
				},
			},
			{ Name = "NumbersToExpressions", Settings = {} },
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- Strong obfuscation, high performance loss.
	["Strong"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			{ Name = "Vmify", Settings = {} },
			{ Name = "EncryptStrings", Settings = {} },
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = false,
				},
			},
			{ Name = "Vmify", Settings = {} },
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 1,
					StringsOnly = true,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0
				},
			},
			{
				Name = "NumbersToExpressions",
				Settings = {
					NumberRepresentationMutation = true
				},
			},
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- ULTIMATE OBFUSCATION - Extremely difficult to reverse engineer
	-- Multiple layers of obfuscation with maximum security
	-- WARNING: This preset has very high performance impact
	["Ultimate"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "_",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			-- Layer 1: Initial String Encryption
			{ Name = "EncryptStrings", Settings = {} },
			
			-- Layer 2: Variable Proxification for obfuscation
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.5,
				},
			},

			-- Layer 3: Split Strings to make them harder to find
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.8,
				},
			},

			-- Layer 4: First Vmify pass - Virtual Machine obfuscation
			{ Name = "Vmify", Settings = {} },

			-- Layer 5: Anti-Tamper with debug functions
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = true,
				},
			},

			-- Layer 6: Add Varargs to confuse analysis
			{ Name = "AddVararg", Settings = {} },

			-- Layer 7: Constant Array with maximum shuffling
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.1,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 8: Second Vmify pass for extra obfuscation
			{ Name = "Vmify", Settings = {} },

			-- Layer 9: Numbers to complex expressions
			{
				Name = "NumbersToExpressions",
				Settings = {
					NumberRepresentationMutation = true,
				},
			},

			-- Layer 10: String encryption again after transformations
			{ Name = "EncryptStrings", Settings = {} },

			-- Layer 11: Third Vmify pass - Maximum control flow flattening
			{ Name = "Vmify", Settings = {} },

			-- Layer 12: Final constant array pass
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.05,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 13: Watermark check for integrity verification
			{
				Name = "WatermarkCheck",
				Settings = {
					Threshold = 0.5,
				},
			},

			-- Layer 14: Final wrapping in function
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- EXTREME OBFUSCATION - LuaU Compatible version
	-- Same security as Ultimate but guaranteed LuaU compatibility
	["UltimateU"] = {
		LuaVersion = "LuaU",
		VarNamePrefix = "_",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			-- Layer 1: Initial String Encryption
			{ Name = "EncryptStrings", Settings = {} },
			
			-- Layer 2: Variable Proxification for obfuscation
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.5,
				},
			},

			-- Layer 3: Split Strings to make them harder to find
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.8,
				},
			},

			-- Layer 4: First Vmify pass - Virtual Machine obfuscation
			{ Name = "Vmify", Settings = {} },

			-- Layer 5: Anti-Tamper without debug (LuaU compatible)
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = false,
				},
			},

			-- Layer 6: Add Varargs to confuse analysis
			{ Name = "AddVararg", Settings = {} },

			-- Layer 7: Constant Array with maximum shuffling
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.1,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 8: Second Vmify pass for extra obfuscation
			{ Name = "Vmify", Settings = {} },

			-- Layer 9: Numbers to complex expressions
			{
				Name = "NumbersToExpressions",
				Settings = {
					NumberRepresentationMutation = true,
				},
			},

			-- Layer 10: String encryption again after transformations
			{ Name = "EncryptStrings", Settings = {} },

			-- Layer 11: Third Vmify pass - Maximum control flow flattening
			{ Name = "Vmify", Settings = {} },

			-- Layer 12: Final constant array pass
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.05,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 13: Final wrapping in function
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- PARANOID OBFUSCATION - For maximum security requirement
	-- Use this only if you need extreme obfuscation
	["Paranoid"] = {
		LuaVersion = "Lua51",
		VarNamePrefix = "__",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			-- Layer 1: Initial String Encryption
			{ Name = "EncryptStrings", Settings = {} },
			
			-- Layer 2: Variable Proxification
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.7,
				},
			},

			-- Layer 3: Split Strings aggressively
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.9,
				},
			},

			-- Layer 4: First Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 5: Anti-Tamper with debug enabled
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = true,
				},
			},

			-- Layer 6: Add Varargs
			{ Name = "AddVararg", Settings = {} },

			-- Layer 7: First Constant Array pass
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.05,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 8: Second Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 9: Proxify again
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.6,
				},
			},

			-- Layer 10: Numbers to expressions (aggressive)
			{
				Name = "NumbersToExpressions",
				Settings = {
					NumberRepresentationMutation = true,
				},
			},

			-- Layer 11: String encryption pass 2
			{ Name = "EncryptStrings", Settings = {} },

			-- Layer 12: Third Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 13: Second Constant Array (more aggressive)
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.02,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 14: Split strings again
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.9,
				},
			},

			-- Layer 15: Fourth Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 16: Watermark check
			{
				Name = "WatermarkCheck",
				Settings = {
					Threshold = 0.7,
				},
			},

			-- Layer 17: Final wrapping
			{ Name = "WrapInFunction", Settings = {} },
		},
	},

	-- PARANOID OBFUSCATION - LuaU Compatible
	["ParanoidU"] = {
		LuaVersion = "LuaU",
		VarNamePrefix = "__",
		NameGenerator = "MangledShuffled",
		PrettyPrint = false,
		Seed = 0,
		Steps = {
			-- Layer 1: Initial String Encryption
			{ Name = "EncryptStrings", Settings = {} },
			
			-- Layer 2: Variable Proxification
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.7,
				},
			},

			-- Layer 3: Split Strings aggressively
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.9,
				},
			},

			-- Layer 4: First Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 5: Anti-Tamper without debug (LuaU compatible)
			{
				Name = "AntiTamper",
				Settings = {
					UseDebug = false,
				},
			},

			-- Layer 6: Add Varargs
			{ Name = "AddVararg", Settings = {} },

			-- Layer 7: First Constant Array pass
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.05,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 8: Second Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 9: Proxify again
			{
				Name = "ProxifyLocals",
				Settings = {
					Threshold = 0.6,
				},
			},

			-- Layer 10: Numbers to expressions (aggressive)
			{
				Name = "NumbersToExpressions",
				Settings = {
					NumberRepresentationMutation = true,
				},
			},

			-- Layer 11: String encryption pass 2
			{ Name = "EncryptStrings", Settings = {} },

			-- Layer 12: Third Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 13: Second Constant Array (more aggressive)
			{
				Name = "ConstantArray",
				Settings = {
					Threshold = 0.02,
					StringsOnly = false,
					Shuffle = true,
					Rotate = true,
					LocalWrapperThreshold = 0,
					EncryptStrings = true,
				},
			},

			-- Layer 14: Split strings again
			{
				Name = "SplitStrings",
				Settings = {
					Threshold = 0.9,
				},
			},

			-- Layer 15: Fourth Vmify
			{ Name = "Vmify", Settings = {} },

			-- Layer 16: Final wrapping
			{ Name = "WrapInFunction", Settings = {} },
		},
	},
}
