.PHONY: resume
# Build the maintained public pit resume with the existing XeLaTeX toolchain.
resume:
	latexmk -xelatex -interaction=nonstopmode -halt-on-error resume.tex
