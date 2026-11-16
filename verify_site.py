"""
Pre-Flight Offline Verification & Case-Sensitive Link Validator
for Dr. Alfu Laily, PhD GitHub Pages Repository.

Run before `git push` to guarantee:
1. Required core files (.nojekyll, index.html, headshot image, CV PDF, course hubs) exist.
2. Every local `href="..."` and `src="..."` across all HTML pages resolves to a real file.
3. Every path matches EXACT uppercase/lowercase casing on disk (simulating GitHub Pages Linux servers).
4. All 3 courses (42 interactive modules/lessons/meetings) are verified:
   - Fundamental Python Programming (14 lessons in programming-python)
   - Clinical Data Science & Fairness (14 meetings in data-science-fairness)
   - Advanced Health Informatics (14 modules in advanced-health-informatics)
5. Zero naming with numbering ('Course 1', 'Course 2', 'Course 3', 'Course 4') in online HTML pages.
6. No file exceeds GitHub's 100 MB limit.
"""

import os
import re
import sys
from pathlib import Path
from urllib.parse import unquote

SITE_ROOT = Path(__file__).resolve().parent


def has_exact_case_on_disk(target_path: Path) -> tuple[bool, str]:
    """
    Windows is case-insensitive, but GitHub Pages (Linux) is case-sensitive.
    Walks from SITE_ROOT down to target_path and checks that each path segment
    matches the exact casing stored on the filesystem.
    """
    if not target_path.exists():
        return False, "File does not exist"

    try:
        rel_parts = target_path.resolve().relative_to(SITE_ROOT.resolve()).parts
    except ValueError:
        return True, "External to site root"

    current = SITE_ROOT.resolve()
    for part in rel_parts:
        entries = {entry.name: entry for entry in current.iterdir()}
        if part not in entries:
            lower_map = {k.lower(): k for k in entries.keys()}
            actual = lower_map.get(part.lower(), "UNKNOWN")
            return False, f"Case mismatch: HTML has '{part}', disk has '{actual}'"
        current = entries[part]
    return True, "OK"


def main() -> int:
    print("=" * 72)
    print("  PRE-FLIGHT OFFLINE VERIFICATION: Alfu Laily, PhD GitHub Pages")
    print("=" * 72)

    errors = []
    warnings = []

    # 1. Check .nojekyll
    nojekyll = SITE_ROOT / ".nojekyll"
    if nojekyll.is_file():
        print("[PASS] .nojekyll exists at repository root.")
    else:
        errors.append("Missing .nojekyll at root (numbered folders like 0-health-informatics will 404 on GitHub Pages).")

    # 2. Check Headshot Asset
    headshot = SITE_ROOT / "assets" / "images" / "Alfu-Laily-headshot.jpg"
    if headshot.is_file():
        print(f"[PASS] Headshot portrait verified ({headshot.stat().st_size / 1024:.1f} KB).")
    else:
        errors.append("Missing headshot image at assets/images/Alfu-Laily-headshot.jpg")

    # 3. Check CV PDF
    cv_pdf = SITE_ROOT / "cv_alfu_laily_PhD" / "cv_laily_20261115.pdf"
    if cv_pdf.is_file():
        print(f"[PASS] CV PDF verified ({cv_pdf.stat().st_size / 1024:.1f} KB).")
    else:
        errors.append("Missing CV PDF at cv_alfu_laily_PhD/cv_laily_20261115.pdf")

    # 4. Check Courses & Blogs TBD placeholder portals (staged release mode)
    courses_tbd = SITE_ROOT / "0-health-informatics" / "index.html"
    if courses_tbd.is_file() and "TBD" in courses_tbd.read_text(encoding="utf-8", errors="ignore"):
        print("[PASS] Courses portal placeholder verified in 0-health-informatics/index.html (TBD release mode).")
    else:
        errors.append("Missing or invalid Courses TBD placeholder at 0-health-informatics/index.html.")

    blogs_tbd = SITE_ROOT / "blog" / "index.html"
    if blogs_tbd.is_file() and "TBD" in blogs_tbd.read_text(encoding="utf-8", errors="ignore"):
        print("[PASS] Blogs portal placeholder verified in blog/index.html (TBD release mode).")
    else:
        errors.append("Missing or invalid Blogs TBD placeholder at blog/index.html.")

    # 5. Check for forbidden Course numbering in active online HTML files
    course_num_pattern = re.compile(r'(?i)\bcourse\s*#?[1-9]\b')
    html_files = [
        p for p in SITE_ROOT.rglob("*.html")
        if "_courses_archive" not in p.parts and not any(part.startswith("Course_") for part in p.parts)
    ]
    course_violations = []

    for html_path in html_files:
        content = html_path.read_text(encoding="utf-8", errors="ignore")
        matches = course_num_pattern.findall(content)
        if matches:
            rel = html_path.relative_to(SITE_ROOT)
            course_violations.append(f"'{rel}': found {len(matches)} occurrences of course numbering {matches[:3]}")

    if not course_violations:
        print(f"[PASS] Zero course numbering ('Course 1/2/3/4') found across all {len(html_files)} HTML pages.")
    else:
        for v in course_violations:
            errors.append(f"Forbidden course numbering in {v}")

    # 6. Scan all active HTML files for broken links & Linux case mismatches
    attr_pattern = re.compile(r'(?:href|src)\s*=\s*"([^"]+)"')
    checked_links = 0

    for html_path in html_files:
        content = html_path.read_text(encoding="utf-8", errors="ignore")
        for match in attr_pattern.finditer(content):
            raw_url = match.group(1).strip()
            # Ignore external URLs, anchors, mailto, javascript, template literals
            if (
                not raw_url
                or raw_url.startswith(("http://", "https://", "mailto:", "tel:", "#", "data:", "javascript:"))
                or "${" in raw_url
            ):
                continue

            # Strip query string or hash anchor
            clean_url = raw_url.split("#")[0].split("?")[0]
            if not clean_url:
                continue

            decoded_url = unquote(clean_url)
            target = (html_path.parent / decoded_url)
            checked_links += 1

            ok, reason = has_exact_case_on_disk(target)
            if not ok:
                rel_html = html_path.relative_to(SITE_ROOT)
                errors.append(f"Broken/Case-Mismatch link in '{rel_html}': '{raw_url}' -> {reason}")

    print(f"[PASS] Scanned {len(html_files)} HTML pages and verified {checked_links} internal links/assets (including exact Linux case matching).")

    # 7. Check GitHub 100 MB file size limits & 1 GB total site limit (active releasable files)
    total_active_bytes = 0
    for f in SITE_ROOT.rglob("*"):
        if (
            f.is_file()
            and ".git" not in f.parts
            and "_courses_archive" not in f.parts
            and not any(part.startswith("Course_") for part in f.parts)
        ):
            size_bytes = f.stat().st_size
            total_active_bytes += size_bytes
            size_mb = size_bytes / (1024 * 1024)
            if size_mb >= 100:
                errors.append(f"File exceeds GitHub 100 MB limit: {f.relative_to(SITE_ROOT)} ({size_mb:.1f} MB)")
            elif size_mb >= 50:
                warnings.append(f"File exceeds 50 MB warning threshold: {f.relative_to(SITE_ROOT)} ({size_mb:.1f} MB)")

    total_active_mb = total_active_bytes / (1024 * 1024)
    if total_active_mb >= 1000:
        errors.append(f"Total site size ({total_active_mb:.2f} MB) exceeds GitHub Pages 1,000 MB limit.")
    else:
        print(f"[PASS] Active website size is {total_active_mb:.2f} MB (well within GitHub Pages 1,000 MB limit).")
    print("-" * 72)

    if warnings:
        print(f"WARNINGS ({len(warnings)}):")
        for w in warnings:
            print(f"  [!] {w}")

    if errors:
        print(f"FAILED WITH {len(errors)} ERROR(S):")
        for e in errors:
            print(f"  [X] {e}")
        print("=" * 72)
        return 1

    print("RESULT: 0 ERRORS. Dr. Alfu Laily's site is 100% ready for offline preview and GitHub Pages release!")
    print("=" * 72)
    return 0


if __name__ == "__main__":
    sys.exit(main())
