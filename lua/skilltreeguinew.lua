Hooks:PostHook(NewSkillTreeSkillItem, "init", "replaceSkillIcon", function(self, skill_id, ...)
	local custom_icon = SkillIconDB[skill_id]
	if custom_icon then
		self._icon:set_image(custom_icon, 0, 0, 80, 80)
	end
end)
