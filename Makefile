SKILL := own-voice
DIST  := dist

.PHONY: zip clean help

help:
	@echo "make zip    — build $(DIST)/$(SKILL).zip for claude.ai (Settings > Features)"
	@echo "make clean  — remove $(DIST)/"

# claude.ai wants a zip whose root is the skill folder, with SKILL.md inside it.
# Your own voice/profile.md is excluded — on claude.ai the profile belongs in a
# Project, not in the skill. See voice/README.md.
zip: clean
	@mkdir -p $(DIST)/$(SKILL)
	@cp SKILL.md $(DIST)/$(SKILL)/
	@cp -R references $(DIST)/$(SKILL)/
	@cp -R agents $(DIST)/$(SKILL)/
	@mkdir -p $(DIST)/$(SKILL)/voice
	@cp voice/README.md voice/profile.example.md $(DIST)/$(SKILL)/voice/
	@cd $(DIST) && zip -qr $(SKILL).zip $(SKILL) -x '*.DS_Store'
	@rm -rf $(DIST)/$(SKILL)
	@echo "✅ $(DIST)/$(SKILL).zip"
	@echo "   Upload: claude.ai → Settings → Features → Skills"
	@echo "   Needs Pro/Max/Team/Enterprise with code execution enabled."

clean:
	@rm -rf $(DIST)
