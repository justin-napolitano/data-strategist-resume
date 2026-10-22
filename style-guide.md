# Approved Index / Simplified print adaptation

Reference: littlelink commit ae3e9062d8e06a1158af74a29cbd8b549d82b3e2, docs/branding/2026-10-22/brand-contract.md; PDF issue #3 and creative-resume issue #32.

White print paper; ink #25251F, thin stone/neutral rules, occasional dark slate #4F6073 (AA-safe adaptation of reference slate). Text-only section headings; 20pt mixed-case serif name. TeX Gyre Heros body and Pagella name use the approved system-font fallback approach: the Inter/Source Serif family is unavailable locally. Font files bundled with TeX Live are addressed directly for reproducible builds. No new font download, package dependency or remote font service.

This change targets deployed origin/pit. Career bullets, contact channels, section order, skill ratings and URLs remain exactly as on pit; merge-with-website is a separate unpublished draft with different facts. creative-resume's newer explicit manifest makes its JSON the canonical career-suite store. The older draft PDF guidance conflicts with that manifest. Do not overwrite canonical facts or claim the PDF and web facts are synchronized; a reviewed content reconciliation is a separate change.

Build: make resume. Existing variants in other branches are unchanged. Inspect selectable text, links, clipping and page count before publishing resume.pdf. The web download currently fetches raw data-strategist-resume/pit/resume.pdf; deployment must refresh the web artifact after the PDF has been reviewed and released.
