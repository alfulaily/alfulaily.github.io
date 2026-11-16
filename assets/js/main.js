/**
 * Alfu Laily, PhD | Postdoc | Health Informatics | Preventive Health
 * Global Persistent Header, Multi-Level Sub-Menu Controller, Theme Manager & CV Tabs
 */

(function () {
  // 1. Apply saved or system theme immediately
  const savedTheme = localStorage.getItem('laily-theme') ||
    (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  document.documentElement.setAttribute('data-theme', savedTheme);

  /**
   * Compute relative path prefix (`./`, `../`, `../../`) back to site root
   */
  function getRootPrefix() {
    const scripts = document.querySelectorAll('script[src*="assets/js/main.js"]');
    if (scripts.length > 0) {
      const src = scripts[0].getAttribute('src');
      return src.replace('assets/js/main.js', '');
    }
    const links = document.querySelectorAll('link[href*="assets/css/main.css"]');
    if (links.length > 0) {
      const href = links[0].getAttribute('href');
      return href.replace('assets/css/main.css', '');
    }
    return './';
  }

  function buildGlobalHeaderHTML(prefix) {
    const p = prefix || './';
    const path = window.location.pathname.toLowerCase();
    const isBlog = path.includes('/blog') || path.endsWith('blog.html');
    const isCourses = path.includes('0-health-informatics') || path.includes('programming') || path.includes('data-science') || path.includes('advanced-health');
    const isHome = !isBlog && !isCourses;

    return `
      <div class="container nav-container">
        <a href="${p}index.html" class="brand-logo">
          <img src="${p}assets/images/Alfu-Laily-headshot.jpg" alt="Dr. Alfu Laily, PhD" class="brand-avatar-img">
          <span>
            Alfu Laily, PhD
            <span class="brand-sub">Public Health Scientist | Postdoctoral Researcher</span>
          </span>
        </a>

        <nav aria-label="Primary Navigation">
          <ul class="nav-links" id="nav-links">
            <!-- 1. Home-CV -->
            <li class="nav-item-dropdown">
              <button type="button" class="nav-link ${isHome ? 'active' : ''}" data-dropdown-toggle aria-expanded="false">
                <span>Home-CV</span> <span class="caret-icon">▾</span>
              </button>
              <ul class="dropdown-menu">
                <li><a href="${p}index.html" class="dropdown-item">🏠 Academic Profile &amp; Bio</a></li>
                <li><a href="${p}index.html#peer-reviewed" class="dropdown-item">📚 Peer-Reviewed Journal Articles</a></li>
                <li class="dropdown-divider"></li>
                <li class="dropdown-submenu">
                  <button type="button" class="dropdown-sub-trigger" data-submenu-toggle aria-expanded="false">
                    <span>📜 Curriculum Vitae (CV)</span> <span class="caret-icon">▸</span>
                  </button>
                  <ul class="dropdown-submenu-list">
                    <li><a href="${p}index.html#cv-section" class="dropdown-item" data-activate-cv-tab="html-preview">📋 Interactive HTML CV</a></li>
                    <li><a href="${p}index.html#cv-section" class="dropdown-item" data-activate-cv-tab="pdf-viewer">📑 Embedded PDF Viewer</a></li>
                    <li><a href="${p}cv_alfu_laily_PhD/cv_laily_20261115.pdf" class="dropdown-item" download>📥 Download CV (PDF)</a></li>
                    <li><a href="${p}cv_alfu_laily_PhD/cv_laily.typ" class="dropdown-item" download>📄 Typst Source (.typ)</a></li>
                  </ul>
                </li>
              </ul>
            </li>

            <!-- 2. Courses -->
            <li class="nav-item-dropdown">
              <button type="button" class="nav-link ${isCourses ? 'active' : ''}" data-dropdown-toggle aria-expanded="false">
                <span>Courses</span> <span class="caret-icon">▾</span>
              </button>
              <ul class="dropdown-menu">
                <li><a href="${p}0-health-informatics/index.html" class="dropdown-item">⏳ Courses — TBD</a></li>
              </ul>
            </li>

            <!-- 3. Blog -->
            <li>
              <a href="${p}blog/index.html" class="nav-link ${isBlog ? 'active' : ''}">
                <span>Blog</span>
              </a>
            </li>

            <!-- 4. Contact -->
            <li class="nav-item-dropdown">
              <button type="button" class="nav-link" data-dropdown-toggle aria-expanded="false">
                <span>Contact</span> <span class="caret-icon">▾</span>
              </button>
              <ul class="dropdown-menu">
                <li><a href="mailto:alfu.n.laily@gmail.com" class="dropdown-item">✉️ Email: alfu.n.laily@gmail.com</a></li>
                <li><a href="https://linkedin.com/in/alfu-laily/" target="_blank" rel="noopener" class="dropdown-item">💼 LinkedIn Profile</a></li>
              </ul>
            </li>
          </ul>
        </nav>

        <div class="nav-actions">
          <button class="theme-toggle" id="theme-toggle-btn" type="button" aria-label="Toggle color theme">
            🌙 Dark
          </button>
          <button class="mobile-menu-toggle" id="mobile-menu-btn" type="button" aria-label="Toggle mobile navigation" aria-expanded="false">
            ☰
          </button>
        </div>
      </div>
    `;
  }

  document.addEventListener('DOMContentLoaded', () => {
    const prefix = getRootPrefix();

    // 2. Inject or upgrade persistent `.site-header` at the very top of <body>
    let headerEl = document.querySelector('.site-header');
    if (!headerEl) {
      headerEl = document.createElement('header');
      headerEl.className = 'site-header';
      document.body.insertBefore(headerEl, document.body.firstChild);
    }
    headerEl.innerHTML = buildGlobalHeaderHTML(prefix);

    // 3. Theme Toggle Binding
    const themeBtn = document.getElementById('theme-toggle-btn');
    const sidebarThemeBtn = document.getElementById('theme-toggle');

    function updateThemeLabels(theme) {
      if (themeBtn) {
        themeBtn.innerHTML = theme === 'dark'
          ? '<span aria-hidden="true">☀️</span> <span>Light</span>'
          : '<span aria-hidden="true">🌙</span> <span>Dark</span>';
      }
      if (sidebarThemeBtn) {
        sidebarThemeBtn.innerHTML = theme === 'dark' ? '☀️ Light' : '🌙 Dark';
      }
    }
    updateThemeLabels(document.documentElement.getAttribute('data-theme') || 'light');

    if (themeBtn) {
      themeBtn.addEventListener('click', () => {
        const current = document.documentElement.getAttribute('data-theme') || 'light';
        const next = current === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem('laily-theme', next);
        updateThemeLabels(next);
      });
    }

    // 4. Multi-Level Dropdown & Sub-Sub-Menu Click + Keyboard Logic
    const dropdownToggles = headerEl.querySelectorAll('[data-dropdown-toggle]');
    const submenuToggles = headerEl.querySelectorAll('[data-submenu-toggle]');

    function closeAllDropdowns() {
      headerEl.querySelectorAll('.nav-item-dropdown.open').forEach(el => {
        el.classList.remove('open');
        const btn = el.querySelector('[data-dropdown-toggle]');
        if (btn) btn.setAttribute('aria-expanded', 'false');
      });
      headerEl.querySelectorAll('.dropdown-submenu.open').forEach(el => {
        el.classList.remove('open');
        const btn = el.querySelector('[data-submenu-toggle]');
        if (btn) btn.setAttribute('aria-expanded', 'false');
      });
    }

    dropdownToggles.forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const parentLi = btn.closest('.nav-item-dropdown');
        const wasOpen = parentLi.classList.contains('open');
        closeAllDropdowns();
        if (!wasOpen) {
          parentLi.classList.add('open');
          btn.setAttribute('aria-expanded', 'true');
        }
      });
    });

    submenuToggles.forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const parentSub = btn.closest('.dropdown-submenu');
        const wasOpen = parentSub.classList.contains('open');
        parentSub.parentElement.querySelectorAll('.dropdown-submenu.open').forEach(sib => {
          sib.classList.remove('open');
          const sibBtn = sib.querySelector('[data-submenu-toggle]');
          if (sibBtn) sibBtn.setAttribute('aria-expanded', 'false');
        });
        if (!wasOpen) {
          parentSub.classList.add('open');
          btn.setAttribute('aria-expanded', 'true');
        }
      });
    });

    document.addEventListener('click', (e) => {
      if (!headerEl.contains(e.target)) {
        closeAllDropdowns();
      }
    });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        closeAllDropdowns();
      }
    });

    // 5. Mobile Hamburger Menu Toggle
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const navLinks = document.getElementById('nav-links');
    if (mobileMenuBtn && navLinks) {
      mobileMenuBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        const isOpen = navLinks.classList.toggle('open');
        mobileMenuBtn.setAttribute('aria-expanded', String(isOpen));
        mobileMenuBtn.innerHTML = isOpen ? '✕' : '☰';
        if (!isOpen) closeAllDropdowns();
      });

      document.addEventListener('click', (e) => {
        if (navLinks.classList.contains('open') && !navLinks.contains(e.target) && e.target !== mobileMenuBtn) {
          navLinks.classList.remove('open');
          mobileMenuBtn.setAttribute('aria-expanded', 'false');
          mobileMenuBtn.innerHTML = '☰';
          closeAllDropdowns();
        }
      });
    }

    // 6. Interactive CV Tabs (HTML Preview vs Embedded PDF Viewer)
    const tabBtns = document.querySelectorAll('[data-cv-tab]');
    const tabPanes = document.querySelectorAll('[data-cv-pane]');
    function activateCvTab(targetName) {
      if (tabBtns.length === 0) return;
      tabBtns.forEach(b => b.classList.toggle('active', b.getAttribute('data-cv-tab') === targetName));
      tabPanes.forEach(p => p.classList.toggle('active', p.getAttribute('data-cv-pane') === targetName));
    }
    if (tabBtns.length > 0) {
      tabBtns.forEach(btn => {
        btn.addEventListener('click', () => activateCvTab(btn.getAttribute('data-cv-tab')));
      });
    }

    headerEl.querySelectorAll('[data-activate-cv-tab]').forEach(link => {
      link.addEventListener('click', () => {
        const targetTab = link.getAttribute('data-activate-cv-tab');
        activateCvTab(targetTab);
        closeAllDropdowns();
      });
    });

    // 7. Global Code & Prompt Copy Button Injection
    const allPreBlocks = document.querySelectorAll('pre');
    allPreBlocks.forEach(pre => {
      if (pre.closest('div.sourceCode')?.querySelector('.code-copy-btn')) return;
      if (pre.closest('div.sourceCode')?.querySelector('.global-copy-btn')) return;
      if (pre.querySelector('.code-copy-btn') || pre.querySelector('.global-copy-btn')) return;

      const targetContainer = pre.closest('div.sourceCode') || pre;
      const codeEl = pre.querySelector('code') || pre;
      const isPrompt = pre.classList.contains('text') || pre.classList.contains('prompt-box');

      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'global-copy-btn';
      btn.setAttribute('aria-label', isPrompt ? 'Copy prompt to clipboard' : 'Copy code to clipboard');
      btn.innerHTML = isPrompt ? '📋 Copy Prompt' : '📋 Copy';

      btn.addEventListener('click', async () => {
        const rawText = (codeEl.innerText || codeEl.textContent || '').trim();
        try {
          await navigator.clipboard.writeText(rawText);
        } catch (err) {
          const ta = document.createElement('textarea');
          ta.value = rawText;
          ta.style.position = 'fixed';
          ta.style.opacity = '0';
          document.body.appendChild(ta);
          ta.select();
          document.execCommand('copy');
          document.body.removeChild(ta);
        }
        btn.classList.add('copied');
        btn.innerHTML = isPrompt ? '✓ Prompt Copied!' : '✓ Copied!';
        setTimeout(() => {
          btn.classList.remove('copied');
          btn.innerHTML = isPrompt ? '📋 Copy Prompt' : '📋 Copy';
        }, 2000);
      });

      targetContainer.appendChild(btn);
    });
  });
})();
