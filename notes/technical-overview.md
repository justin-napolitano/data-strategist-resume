---
slug: github-data-strategist-resume-note-technical-overview
id: github-data-strategist-resume-note-technical-overview
title: Data Strategist Resume
repo: justin-napolitano/data-strategist-resume
githubUrl: https://github.com/justin-napolitano/data-strategist-resume
generatedAt: '2025-11-24T18:34:58.554Z'
source: github-auto
summary: >-
  This repo provides LaTeX-based templates for professional resumes and cover
  letters. It uses custom document classes to ensure high-quality PDF outputs.
tags: []
seoPrimaryKeyword: ''
seoSecondaryKeywords: []
seoOptimized: false
topicFamily: null
topicFamilyConfidence: null
kind: note
entryLayout: note
showInProjects: false
showInNotes: true
showInWriting: false
showInLogs: false
---

This repo provides LaTeX-based templates for professional resumes and cover letters. It uses custom document classes to ensure high-quality PDF outputs.

## Key Features

- Custom classes: `my-resume.cls`, `bf-class.cls`, `cover-letter-class.cls`
- Supports single and double-sided layouts
- Advanced graphics with TikZ and tcolorbox
- Icons from fontawesome and academicons
- Sample documents for quick reference

## Quick Start

1. **Prerequisites:** Install a LaTeX distribution like TeX Live or MiKTeX with the required packages.
2. **Build Your Docs:**

   ```bash
   pdflatex resume.tex
   pdflatex cover-letter.tex
   pdflatex bf.tex
   ```

   Compile multiple times for references to properly resolve.

## Project Structure

- `*.cls`: Custom LaTeX classes
- `*.tex`: Source files for resumes and letters
- `*.pdf`: Compiled outputs
- Assets and auxiliary files for documentation

Look out for details on custom class usage in future updates.
