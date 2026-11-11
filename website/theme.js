// Apply before styles load to avoid flashing the wrong theme.
(() => {
  let preference;
  try { preference = localStorage.getItem('academic-notes-theme'); } catch { /* Storage may be unavailable. */ }
  document.documentElement.dataset.theme = ['light', 'dark'].includes(preference)
    ? preference : (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
})();
