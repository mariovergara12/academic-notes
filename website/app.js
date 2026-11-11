import { subjectGroups, normalizeDocuments, filterDocuments, readRoute, routeHash } from './library.mjs';

const $ = selector => document.querySelector(selector);
const icons = {
  search: '<circle cx="10.5" cy="10.5" r="6.5"/><path d="m16 16 4 4"/>',
  dashboard: '<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
  code: '<path d="m8 6-6 6 6 6m8-12 6 6-6 6m-3-15-2 18"/>',
  math: '<path d="M19 4H5l8 8-8 8h14"/>',
  files: '<path d="M14 3H6a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9Zm0 0v6h6M8 13h8m-8 4h5"/>',
  arrow: '<path d="M4 12h16m-6-6 6 6-6 6"/>',
  external: '<path d="M14 3h7v7m0-7L10 14m0-10H5a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2h13a2 2 0 0 0 2-2v-5"/>',
  github: '<path d="M9 19c-4 1-4-2-6-2m12 5v-4a3.5 3.5 0 0 0-1-2.7c3.3-.4 6.8-1.6 6.8-7.3A5.6 5.6 0 0 0 19.3 4a5 5 0 0 0-.1-4S17.9-.4 15 1.5a14 14 0 0 0-7 0C5.1-.4 3.8 0 3.8 0a5 5 0 0 0-.1 4A5.6 5.6 0 0 0 2.2 8c0 5.7 3.5 6.9 6.8 7.3A3.5 3.5 0 0 0 8 18v4" transform="translate(1 1) scale(.9)"/>',
  moon: '<path d="M21 13a9 9 0 0 1-10-10 9 9 0 1 0 10 10Z"/>',
  sun: '<circle cx="12" cy="12" r="4"/><path d="M12 2v2m0 16v2M2 12h2m16 0h2M5 5l1.5 1.5m11 11L19 19M5 19l1.5-1.5m11-11L19 5"/>',
  panel: '<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M9 4v16"/>',
  close: '<path d="m6 6 12 12M6 18 18 6"/>',
  chevron: '<path d="m8 10 4 4 4-4"/>',
  download: '<path d="M12 3v12m-5-5 5 5 5-5M4 16v4h16v-4"/>',
  book: '<path d="M12 5C8 2 4 3 2 4v15c3-1 7-1 10 2 3-3 7-3 10-2V4c-2-1-6-2-10 1Zm0 0v16"/>',
  layers: '<path d="m12 3 10 6-10 6L2 9Zm-10 12 10 6 10-6M2 12l10 6 10-6"/>',
};
function icon(name) {
  const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
  svg.setAttribute('viewBox', '0 0 24 24');
  svg.setAttribute('fill', 'none');
  svg.setAttribute('stroke', 'currentColor');
  svg.setAttribute('stroke-width', '1.6');
  svg.setAttribute('stroke-linecap', 'round');
  svg.setAttribute('stroke-linejoin', 'round');
  svg.setAttribute('aria-hidden', 'true');
  svg.innerHTML = icons[name] || icons.files;
  return svg;
}
document.querySelectorAll('[data-icon]').forEach(node => node.replaceChildren(icon(node.dataset.icon)));
document.querySelectorAll('#primary-nav a').forEach(node => {
  node.setAttribute('aria-label', node.querySelector('.sidebar-copy').textContent);
  node.title = node.getAttribute('aria-label');
});
$('.profile').setAttribute('aria-label', 'Mario Vergara on GitHub');
$('.skip-link').addEventListener('click', event => { event.preventDefault(); $('#main').focus(); });
function el(tag, className, value) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (value !== undefined) node.textContent = value;
  return node;
}
function link(label, href, className = '') {
  const node = el('a', className, label);
  node.href = href;
  return node;
}
const plural = (n, word) => `${n} ${word}${n === 1 ? '' : 's'}`;
const formatDate = value => new Date(value).toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' });
const mobile = matchMedia('(max-width: 760px)');
let documents = [], state = readRoute(location.hash), loaded = false;

function updateThemeButton() {
  const dark = document.documentElement.dataset.theme === 'dark';
  $('#theme-toggle').setAttribute('aria-label', `Switch to ${dark ? 'light' : 'dark'} theme`);
  $('#theme-toggle').replaceChildren(icon(dark ? 'sun' : 'moon'));
  $('meta[name="theme-color"]').content = dark ? '#171c19' : '#f8f9f6';
}
$('#theme-toggle').addEventListener('click', () => {
  document.documentElement.dataset.theme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
  try { localStorage.setItem('academic-notes-theme', document.documentElement.dataset.theme); } catch { /* Optional preference. */ }
  updateThemeButton();
});
matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
  let saved;
  try { saved = localStorage.getItem('academic-notes-theme'); } catch { /* Optional preference. */ }
  if (!saved) { document.documentElement.dataset.theme = event.matches ? 'dark' : 'light'; updateThemeButton(); }
});
updateThemeButton();

function syncSidebar() {
  const open = mobile.matches ? document.body.classList.contains('nav-open') : !document.body.classList.contains('nav-collapsed');
  $('#sidebar-toggle').setAttribute('aria-expanded', String(open));
  $('#sidebar-toggle').setAttribute('aria-label', `${open ? 'Collapse' : 'Expand'} navigation`);
  $('#backdrop').hidden = !mobile.matches || !open;
  $('#sidebar').inert = mobile.matches && !open;
  $('.workspace').inert = mobile.matches && open;
  if (mobile.matches && open) $('#sidebar').querySelector('a').focus();
}
try { document.body.classList.toggle('nav-collapsed', localStorage.getItem('academic-notes-sidebar') === 'collapsed'); } catch { /* Optional preference. */ }
$('#sidebar-toggle').addEventListener('click', () => {
  if (mobile.matches) document.body.classList.toggle('nav-open');
  else {
    document.body.classList.toggle('nav-collapsed');
    try { localStorage.setItem('academic-notes-sidebar', document.body.classList.contains('nav-collapsed') ? 'collapsed' : 'expanded'); } catch { /* Optional preference. */ }
  }
  syncSidebar();
});
function closeSidebar(restoreFocus = false) {
  document.body.classList.remove('nav-open'); syncSidebar();
  if (restoreFocus) $('#sidebar-toggle').focus();
}
$('#backdrop').addEventListener('click', () => closeSidebar(true));
$('#close-navigation').addEventListener('click', () => closeSidebar(true));
mobile.addEventListener('change', () => closeSidebar());
syncSidebar();
// Keep keyboard focus within the mobile navigation while it is open.
document.addEventListener('keydown', event => {
  if (event.key === 'Escape' && document.body.classList.contains('nav-open')) closeSidebar(true);
  if (event.key === 'Tab' && mobile.matches && document.body.classList.contains('nav-open')) {
    const nodes = [...$('#sidebar').querySelectorAll('a, button, summary')].filter(node => node.getClientRects().length);
    const first = nodes[0], last = nodes.at(-1);
    if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last.focus(); }
    if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first.focus(); }
  }
  if ((event.key === '/' || ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === 'k'))
    && !['INPUT', 'TEXTAREA', 'SELECT'].includes(document.activeElement.tagName) && !document.activeElement.isContentEditable && !$('#document-dialog').open) {
    event.preventDefault(); closeSidebar(); $('#search').focus();
  }
});
$('#sidebar-search').addEventListener('click', () => { closeSidebar(); $('#search').focus(); });

function courseHref(course, subject) { return routeHash({ view: 'course', course, subject }); }
function subjectIcon(subject) { return subject === 'cs' ? 'code' : subject === 'math' ? 'math' : 'book'; }
function courseGroups() {
  const groups = new Map();
  for (const doc of documents) {
    const key = `${doc.subject}:${doc.course}`;
    if (!groups.has(key)) groups.set(key, { subject: doc.subject, name: doc.course, notes: [] });
    groups.get(key).notes.push(doc);
  }
  return [...groups.values()].sort((a, b) => a.name.localeCompare(b.name));
}
function empty(title, description, reset = false) {
  const node = el('div', 'empty-state');
  node.append(icon('book'), el('h3', '', title), el('p', '', description));
  if (reset) {
    const button = el('button', 'secondary-button', 'Clear filters');
    button.addEventListener('click', clearFilters); node.append(button);
  }
  return node;
}
function renderDashboard() {
  const groups = courseGroups();
  $('#nav-count').textContent = documents.length;
  const topics = new Set(documents.map(d => d.topic).filter(Boolean));
  $('#stats').replaceChildren(...[
    [documents.length, 'notes in the library', 'files'], [groups.length, 'course collections', 'book'],
    [topics.size, 'topics', 'layers'],
  ].map(([count, label, glyph]) => {
    const stat = el('div', 'stat'); stat.append(icon(glyph), el('strong', '', String(count)), el('span', '', label)); return stat;
  }));
  $('#collections').replaceChildren(); $('#course-nav').replaceChildren();
  document.querySelectorAll('#primary-nav [data-subject]').forEach(node => node.remove());
  for (const { key: subject, title } of subjectGroups(documents)) {
    const subset = groups.filter(g => g.subject === subject);
    const subjectLink = link('', routeHash({ view: 'subject', subject }));
    subjectLink.dataset.subject = subject;
    subjectLink.title = title; subjectLink.setAttribute('aria-label', title);
    subjectLink.append(icon(subjectIcon(subject)), el('span', 'sidebar-copy', title));
    $('#primary-nav').insertBefore(subjectLink, $('#all-notes-link'));
    const courseList = el('details', 'subject-course-nav'); courseList.open = true;
    const summary = el('summary', 'subject-course-label', title); summary.append(icon('chevron'));
    courseList.append(summary); $('#course-nav').append(courseList);
    const section = el('section', 'subject-collection');
    const label = el('h3', 'subject-label'); label.append(icon(subjectIcon(subject)), el('span', '', title));
    const grid = el('div', 'course-grid');
    for (const group of subset) {
      const card = link('', courseHref(group.name, subject), `course-card ${subject}`);
      const top = el('div', 'course-card-top');
      top.append(el('span', 'course-initial', subject === 'cs' ? '{ }' : subject === 'math' ? '∑' : '↗'), icon('arrow'));
      const semesters = [...new Set(group.notes.map(d => d.semester).filter(Boolean))];
      const meta = el('div', 'course-card-meta');
      meta.append(el('span', '', plural(group.notes.length, 'note')), el('span', '', semesters.join(' · ')));
      const tags = el('div', 'course-topics');
      [...new Set(group.notes.map(d => d.topic).filter(Boolean))].slice(0, 3).forEach(topic => tags.append(el('span', '', topic)));
      if (!tags.childElementCount) tags.append(el('span', '', 'Course notes'));
      card.append(top, el('h4', '', group.name), meta, tags); grid.append(card);
      const nav = link('', courseHref(group.name, subject)); nav.title = group.name;
      nav.setAttribute('aria-label', group.name);
      nav.append(el('span', 'course-dot'), el('span', 'sidebar-copy course-nav-name', group.name));
      courseList.append(nav);
    }
    section.append(label, grid); $('#collections').append(section);
  }
  if (!groups.length) $('#collections').append(empty('No course notes yet', 'Compiled course notes will appear here when they’re added to the library.'));
  const dated = documents.filter(d => d.addedTime);
  $('#recent-title').textContent = dated.length ? 'Recently added' : 'From the library';
  $('#recent-description').textContent = dated.length ? 'The latest additions to the notebook.' : 'Browse a selection of notes. Addition dates aren’t available in this index.';
  const recent = filterDocuments(dated.length ? dated : documents, { sort: dated.length ? 'newest' : 'title' }).slice(0, 4);
  $('#recent-notes').replaceChildren(...recent.map(doc => noteCard(doc, true)));
  if (!recent.length) $('#recent-notes').append(empty('No notes yet', 'Your first compiled notes will appear here.'));
}
function noteCard(doc, compact = false) {
  const article = el('article', compact ? 'note-row' : 'note-card');
  const glyph = el('span', `document-glyph ${doc.subject}`); glyph.append(icon('files'));
  const text = el('div', 'note-info');
  const heading = el('h3');
  const button = el('button', 'note-title', doc.title);
  button.addEventListener('click', () => openDocument(doc)); heading.append(button);
  text.append(heading, el('p', 'note-metadata', [doc.course, compact ? '' : doc.semester, doc.topic].filter(Boolean).join(' · ')));
  article.append(glyph, text);
  if (!compact) {
    const actions = el('div', 'note-links');
    const open = link('PDF', doc.url); open.target = '_blank'; open.rel = 'noopener noreferrer'; open.setAttribute('aria-label', `Open ${doc.title} PDF in a new tab`); open.append(icon('external'));
    const download = link('', doc.url, 'icon-button'); download.download = ''; download.setAttribute('aria-label', `Download ${doc.title}`); download.append(icon('download'));
    actions.append(open, download); article.append(actions);
  } else {
    const date = el('span', 'note-date', doc.addedTime ? formatDate(doc.addedTime) : 'PDF'); article.append(date, icon('arrow'));
  }
  return article;
}
function fillSelect(select, values, selected, allLabel) {
  select.replaceChildren(new Option(allLabel, ''), ...values.map(value => new Option(value, value)));
  select.value = selected;
}
function renderLibrary() {
  const scoped = filterDocuments(documents, { view: state.view, subject: state.subject });
  fillSelect($('#course'), [...new Set(scoped.map(d => d.course))].sort(), state.course, 'All courses');
  const topicScope = scoped.filter(d => !state.course || d.course === state.course);
  fillSelect($('#topic'), [...new Set(topicScope.map(d => d.topic).filter(Boolean))].sort(), state.topic, 'All topics');
  $('#topic').disabled = !topicScope.some(d => d.topic);
  $('#sort').value = state.sort;
  const matches = filterDocuments(documents, state);
  $('#result-status').textContent = plural(matches.length, 'note') + (state.query ? ` matching “${state.query}”` : ' in this collection');
  $('#results').replaceChildren();
  if (!matches.length) {
    $('#results').append(empty('No notes found', documents.length ? 'Try another search term, course, or topic.' : 'There are no compiled notes in the library yet.', Boolean(state.query || state.course || state.topic)));
    return;
  }
  const groups = new Map();
  for (const doc of matches) {
    const key = JSON.stringify([doc.subject, doc.course]);
    if (!groups.has(key)) groups.set(key, []);
    groups.get(key).push(doc);
  }
  for (const notes of groups.values()) {
    const course = notes[0].course;
    const section = el('section', 'result-group');
    const heading = el('div', 'result-group-heading'); heading.append(el('h2', '', course), el('span', 'count', String(notes.length)));
    if (!state.subject) heading.append(el('span', 'result-subject', notes[0].subjectTitle));
    section.append(heading, ...notes.map(doc => noteCard(doc))); $('#results').append(section);
  }
}
function render() {
  if (!loaded) return;
  const subject = subjectGroups(documents).find(group => group.key === state.subject);
  const subjectName = subject?.title || state.subject || 'Subject';
  let eyebrow = 'PERSONAL NOTES', title = 'Library', description = '';
  if (state.view === 'all') {
    eyebrow = 'LIBRARY'; title = 'All notes'; description = 'Search across all subjects and courses.';
  } else if (state.view === 'subject') {
    eyebrow = 'SUBJECT'; title = subjectName;
  } else if (state.view === 'course') {
    eyebrow = 'COURSE'; title = state.course || 'Course notes'; description = subject ? subjectName : '';
  }
  $('#eyebrow').textContent = eyebrow; $('#page-title').replaceChildren(document.createTextNode(title), el('span', '', '.'));
  $('#page-description').textContent = description;
  $('#page-description').hidden = !description;
  $('#breadcrumb').textContent = state.view === 'dashboard' ? 'Dashboard' : title;
  document.title = `${state.view === 'dashboard' ? 'notes' : title} · Mario Vergara`;
  $('#search').value = state.query;
  const dashboard = state.view === 'dashboard' && !state.query;
  $('#dashboard').hidden = !dashboard;
  $('#library').hidden = dashboard;
  if (!dashboard) renderLibrary();
  document.querySelectorAll('#primary-nav a, #course-nav a').forEach(node => {
    const route = readRoute(node.hash);
    const active = route.view === state.view && route.subject === state.subject && (route.view !== 'course' || route.course === state.course);
    if (active) node.setAttribute('aria-current', 'page'); else node.removeAttribute('aria-current');
  });
}
function navigate(next, replace = false) {
  state = next;
  const hash = routeHash(state);
  if (replace) history.replaceState(null, '', hash); else history.pushState(null, '', hash);
  render();
}
function restoreRoute() {
  const next = readRoute(location.hash);
  const collectionChanged = next.view !== state.view || next.subject !== state.subject || next.course !== state.course;
  state = next; closeSidebar(); render();
  if (collectionChanged) window.scrollTo(0, 0);
}
window.addEventListener('hashchange', restoreRoute);
window.addEventListener('popstate', restoreRoute);
// Native links preserve shareable URLs and browser history.
$('#sidebar').addEventListener('click', event => {
  if (event.target.closest('a[href^="#"]')) {
    closeSidebar();
    requestAnimationFrame(() => $('#main').focus({ preventScroll: true }));
  }
});
$('#search-form').addEventListener('submit', event => event.preventDefault());
$('#search').addEventListener('input', event => navigate({ ...state, view: state.view === 'dashboard' ? 'all' : state.view, query: event.target.value }, true));
$('#course').addEventListener('change', event => navigate({ ...state, course: event.target.value, topic: '', view: state.view === 'course' ? (state.subject ? 'subject' : 'all') : state.view }));
$('#topic').addEventListener('change', event => navigate({ ...state, topic: event.target.value }));
$('#sort').addEventListener('change', event => navigate({ ...state, sort: event.target.value }));
function clearFilters() { navigate({ ...state, view: state.view === 'course' ? (state.subject ? 'subject' : 'all') : state.view, course: '', topic: '', query: '', sort: 'title' }); $('#search').focus(); }
$('#clear-filters').addEventListener('click', clearFilters);

function openDocument(doc) {
  $('#document-title').textContent = doc.title;
  $('#document-meta').textContent = [...new Set([doc.subjectTitle, doc.course, doc.semester, doc.topic, doc.category].filter(Boolean))].join(' · ');
  $('#open-pdf').href = doc.url; $('#download-pdf').href = doc.url;
  const frame = el('iframe'); frame.title = `${doc.title} PDF preview`; frame.src = doc.url;
  $('#pdf-preview').replaceChildren(frame);
  $('#document-dialog').showModal();
  document.body.classList.add('preview-open');
}
$('#close-document').addEventListener('click', () => $('#document-dialog').close());
$('#document-dialog').addEventListener('click', event => { if (event.target === event.currentTarget && (event.clientX < event.currentTarget.getBoundingClientRect().left || event.clientX > event.currentTarget.getBoundingClientRect().right || event.clientY < event.currentTarget.getBoundingClientRect().top || event.clientY > event.currentTarget.getBoundingClientRect().bottom)) event.currentTarget.close(); });
$('#document-dialog').addEventListener('close', () => { $('#pdf-preview').replaceChildren(); document.body.classList.remove('preview-open'); });

async function init() {
  try {
    const response = await fetch('./notes.json', { cache: 'no-store' });
    if (!response.ok) throw new Error(`Index request returned ${response.status}`);
    const data = await response.json();
    documents = normalizeDocuments(data, location.href);
    loaded = true;
    $('#load-status').hidden = true;
    if (data.updated && Number.isFinite(Date.parse(data.updated))) $('#updated').textContent = `Library built ${formatDate(data.updated)}`;
    renderDashboard(); render();
  } catch (error) {
    $('#load-status').replaceChildren(empty('The library couldn’t be loaded', 'Please refresh to try again. If the problem continues, check the publishing workflow on GitHub.'));
    const retry = el('button', 'secondary-button', 'Try again');
    retry.addEventListener('click', () => { $('#load-status').textContent = 'Loading your library…'; init(); });
    $('#load-status').append(retry);
    console.error(error);
  }
}
init();
