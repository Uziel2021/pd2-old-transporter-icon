-- I copy pasted this from p3d ¯\_(ツ)_/¯
SkillTextureAssetClass = SkillTextureAssetClass or class()
rawset(_G, "SkillIconDB", {})

function SkillTextureAssetClass:init()
	self.AssetsDirectory = ModPath .. "assets/"
	self.SoftAssetsDirectory = "guis/textures/pd2/skills/"
	self.Data = {}
	self.CAN_ADD_FILES = false
	self.CAN_USE_SYSTEMFS = false

	self:_check_special_variables()
	self:_init_icons()

	self._initialized = true
end

function SkillTextureAssetClass:_check_special_variables()
	if DB.create_entry then
		self.CAN_ADD_FILES = true
	end

	if SystemFS and SystemFS.list then
		self.CAN_USE_SYSTEMFS = true
	end
end

function SkillTextureAssetClass:create_texture_entry(texture_path_ingame, texture_path_inmod)
	if not self.CAN_ADD_FILES then
		return
	end

	DB:create_entry(Idstring("texture"), Idstring(texture_path_ingame), texture_path_inmod)
end

function SkillTextureAssetClass:_init_icons()
	if not self.CAN_USE_SYSTEMFS then
		return
	end

	for i, v in ipairs(SystemFS:list(self.AssetsDirectory)) do
		local wo_extension = string.gsub(v, ".texture", "")

		SkillIconDB[wo_extension] = self.SoftAssetsDirectory .. wo_extension

		self:create_texture_entry(self.SoftAssetsDirectory .. wo_extension, self.AssetsDirectory .. v)
	end
end
