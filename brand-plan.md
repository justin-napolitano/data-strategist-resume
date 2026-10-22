# Issue #3 implementation scope

Adapt deployed pit presentation to approved Index / Simplified (no title marks), preserving all career facts. Files: resume.tex, testing-class.cls, Makefile, style-guide.md, resume.pdf. Build with make resume and inspect the actual PDF. Publication remains blocked pending paired web/PDF visual and content-drift review. Roll back the focused presentation commit; no data or infrastructure migration.

## Validation evidence

make resume passes with XeLaTeX/latexmk from installed TeX Live 2025. Output: 2 pages, 29,391 bytes. Pre-existing Carlito font lookup failed; switched to bundled file-addressed TeX Gyre fonts. One 1.27pt overfull box remains in the existing publication macro. FontAwesome decorative icon ToUnicode warnings remain; body text uses embedded standard text fonts. PDFKit rendering/text inspection pending; no claim of full visual or text QA. No PDF/web copy synchronization claim.
