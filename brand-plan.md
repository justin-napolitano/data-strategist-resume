# Issue #3 implementation scope

Adapt deployed pit presentation to approved Index / Simplified (no title marks), preserving all career facts. Files: resume.tex, testing-class.cls, Makefile, style-guide.md, resume.pdf. Build with make resume and inspect the actual PDF. Publication remains blocked pending paired web/PDF visual and content-drift review. Roll back the focused presentation commit; no data or infrastructure migration.

## Validation evidence

make resume passes with XeLaTeX/latexmk from installed TeX Live 2025. Output after pagebreak repair: 1 page, 29,121 bytes, 3,635 extracted characters. Pre-existing Carlito font lookup failed; switched to bundled file-addressed TeX Gyre fonts. At 10pt body, no overfull box warning remains. FontAwesome decorative icon ToUnicode warnings remain; body text uses embedded standard text fonts. PDFKit rendered and inspected the full single page, verifying the complete two-column body fits below the modest serif name. Selectable body text, contact links and publication are preserved. Decorative FontAwesome glyphs do not extract as words; body reading order remains two-column and needs ATS-specific review before application submission. No PDF/web copy synchronization claim.
