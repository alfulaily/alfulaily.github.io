# Complete Operations, Offline Testing, Editing & Deployment Manual (`Alfu Laily, PhD`)

This document is the technical handbook for **testing offline before release**, editing course notebooks, updating CV assets, and deploying Dr. Alfu Laily's GitHub Pages website.

---

## 0. Directory Architecture Overview

This website is a **zero-runtime-bloat, pure static HTML5/CSS3/ES6+ website** with **no Jekyll build step** (`.nojekyll` at root).
All course naming with numbering ('Course 1', 'Course 2', 'Course 3', 'Course 4') has been removed across all online HTML files and URLs.

```text
Alfu_Laily_PhD_github.io-project/
├── .nojekyll                                  # Prevents GitHub Pages from ignoring numbered folders
├── .gitignore                                 # Excludes caches and temporary system files
├── index.html                                 # Root Landing Page + Interactive HTML/PDF CV Portal + 3 Course Cards
├── blog.html                                  # HTML redirect -> blog/index.html
├── blog/
│   └── index.html                             # Academic Insights & Preventative Health Informatics Blog
├── HOW_TO.md                                  # Complete human manual for offline testing, editing & deployment
├── LLM_HANDOFF_AND_PROGRESS_STATE.md          # Fast AI context transfer & architecture map
├── verify_site.py                             # Pre-flight link, asset, Linux case-sensitivity & size checker
├── test_offline.ps1                           # One-click offline validator + localhost:8080 launcher
├── build_interactive_books.py                 # Automated converter from .ipynb into HTML web books (3 courses)
├── python_curriculum_prompts_and_lab_codebook.md # Master pedagogical codebook & curricular prompts
├── assets/
│   ├── css/main.css                           # Global maroon-ish & rose design system (Light/Dark themes)
│   ├── js/main.js                             # Sticky top nav injector, multi-level dropdowns, CV tabs, copy buttons
│   └── images/
│       ├── Alfu-Laily-headshot.jpg            # Official headshot portrait (circular logo & profile avatar)
│       └── profile.svg                        # Monogram crest asset
├── cv_alfu_laily_PhD/
│   ├── Alfu-Laily-headshot.jpg                # Source headshot photograph
│   ├── cv_laily_20261115.pdf                  # Compiled Purdue CV PDF (embedded in viewer & download)
│   └── cv_laily.typ                           # Typst CV source code
├── 0-health-informatics/
│   ├── index.html                             # Health Informatics Portal Overview (Showcases all 3 tracks)
│   ├── codebook.html                          # Web-rendered Pedagogical Codebook & Curricular Specs
│   ├── programming-python.html                # Course Hub: Fundamental Python Programming (14 Weeks)
│   ├── data-science-fairness.html             # Course Hub: Fundamental Clinical Data Science & Fairness (14 Meetings)
│   ├── advanced-health-informatics.html       # Course Hub: Advanced Health Informatics for Graduate Students (14 Weeks)
│   ├── course-1-programming.html              # HTML meta-refresh redirect -> programming-python.html
│   ├── course-2-data-science.html             # HTML meta-refresh redirect -> data-science-fairness.html
│   ├── programming-python/                    # 14-lesson Interactive Web Book + Exam Solutions + notebooks/*.ipynb
│   ├── data-science-fairness/                 # 14-meeting Interactive Web Book + Capstone Solutions + notebooks/*.ipynb
│   └── advanced-health-informatics/           # 14-module Interactive Web Book + Graduate Solutions + notebooks/*.ipynb
├── Course_Fundamental Programming for Public Health and Health Informatics Undergraduate Students using Python/
│   ├── Course3_Week01_...ipynb                # Source teaching notebooks (Week 01 - Week 14)
│   └── Course3_Homework_and_Exam_Solutions.ipynb # Source solutions notebook
├── Course_Fundamental Data Science for Public Health & Health Informatics Undergraduate Students using Python/
│   ├── C4_M01.ipynb ... C4_M14.ipynb          # Source teaching notebooks (Meeting 01 - Meeting 14)
│   ├── C4_HW_Solutions.ipynb                  # Source homework solutions
│   └── C4_Exam_Solutions.ipynb                # Source exam solutions
└── Course_Advanced Health Informatics for Graduate Students/
    ├── Course2_Week01_...ipynb ... Week14...  # Source teaching notebooks (Week 01 - Week 14)
    └── Course2_Homework_and_Exam_Solutions.ipynb # Source solutions notebook
```

---

## 1. How to Test Offline Before Releasing

Never double-click `index.html` in File Explorer, because `file:///` restricts embedded PDF viewers and ignores Linux case-sensitivity. Always use the built-in offline test suite:

### Quick Method: One-Click Offline Verification & Server
1. Open **PowerShell** in this directory.
2. Run:
   ```powershell
   .\test_offline.ps1
   ```
3. It automatically:
   - Runs `verify_site.py` checking all links and case sensitivity.
   - Starts a local web server at `http://localhost:8080` and opens it in your browser.
4. Press `Ctrl + C` in PowerShell to stop the server when done.

### Manual Verification
```powershell
python verify_site.py
```
Expected result: `RESULT: 0 ERRORS. Dr. Alfu Laily's site is 100% ready for offline preview and GitHub Pages release!`

---

## 2. Color Theme & Styling Design System

The site features a **maroon-ish, rose, and feminine academic theme**:
- **Primary Maroon:** `#881337` (rich burgundy maroon)
- **Berry & Rose Accents:** `#9f1239`, `#be123c`, `#e11d48`, `#f43f5e`, `#fda4af`
- **Soft Blush Backgrounds:** `#fdf8f9` (light mode) / `#120409` (dark mode velvety plum)
- **Typography:** Serif display headings (`Playfair Display`, `Outfit`, `serif`) paired with clean modern sans-serif (`Inter`) and monospace (`Fira Code`).
- **Brand Imagery:** Official high-resolution portrait photograph of Dr. Alfu Laily, PhD displayed as a circular avatar in both the top sticky navbar and the homepage profile card.

---

## 3. How to Update Content & Rebuild

### A. Updating Course Notebooks (`.ipynb`)
1. Edit any `.ipynb` file in any of the three source course folders.
2. Run the rebuild script:
   ```powershell
   python build_interactive_books.py
   ```
   This rebuilds all interactive HTML lessons (46 chapters total) and syncs the downloadable `.ipynb` notebooks.
3. Verify:
   ```powershell
   python verify_site.py
   ```

### B. Updating Dr. Laily's Curriculum Vitae (`cv_alfu_laily_PhD/`)
1. Edit `cv_alfu_laily_PhD/cv_laily.typ`.
2. Compile to PDF:
   ```powershell
   cd cv_alfu_laily_PhD
   typst compile cv_laily.typ cv_laily_20261115.pdf
   cd ..
   ```
3. Verify that `verify_site.py` passes with 0 errors.

---

## 4. Git Deployment to GitHub Pages

1. Stage all files:
   ```powershell
   git status
   git add .
   ```
2. Commit with a descriptive message:
   ```powershell
   git commit -m "Add Advanced Health Informatics course, integrate headshot avatar, remove course numbering"
   ```
3. Push to GitHub:
   ```powershell
   git push origin main
   ```
4. Verify online on GitHub Pages at your repository's public URL!
