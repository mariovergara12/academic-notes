/** The original notes.json fields still work; subjects and courses follow folders. */
const SUBJECT_LABELS = new Map([['cs', 'Computer Science'], ['math', 'Mathematics'], ['general', 'General']]);
const LEGACY_COURSES = new Map([['dsa', 'cs'], ['diffeq', 'math'], ['differential-equations', 'math']]);
const SUBJECT_ALIASES = new Map([['computer-science', 'cs'], ['mathematics', 'math']]);
export const compareTitles = (a, b) => a.title.localeCompare(b.title, undefined, { numeric: true });
const pretty = value => value.replace(/^\d+[.\s_-]+/, '').replace(/[-_]/g, ' ').trim().replace(/\b\p{L}/gu, c => c.toUpperCase());
function subjectKey(value) {
  const key = String(value).trim().toLowerCase().replace(/[^\p{L}\p{N}]+/gu, '-').replace(/^-|-$/g, '');
  return SUBJECT_ALIASES.get(key) || key || 'general';
}
export function subjectOf(doc) {
  if (doc.subject) return subjectKey(doc.subject);
  const parts = (doc.path || '').split('/');
  const root = parts.length > 1 ? parts[0] : '';
  if (root) return LEGACY_COURSES.get(root.toLowerCase()) || subjectKey(root);
  // Older indexes may omit paths entirely.
  if (/algorithm|computer|programming|data structure|software|computing/i.test(doc.course || '')) return 'cs';
  if (/math|equation|algebra|calculus|geometry|analysis|statistics/i.test(doc.course || '')) return 'math';
  return 'general';
}
export function subjectTitle(doc) {
  const key = subjectOf(doc);
  return SUBJECT_LABELS.get(key) || (doc.subject ? String(doc.subject).trim() : pretty(key));
}
export function courseOf(doc) {
  if (typeof doc.course === 'string' && doc.course.trim()) return doc.course.trim();
  const parts = (doc.path || '').split('/');
  const root = parts[0].toLowerCase();
  if (LEGACY_COURSES.has(root)) return root === 'dsa' ? 'Data Structures & Algorithms' : 'Differential Equations';
  return parts.length > 2 ? pretty(parts[1]) : subjectTitle(doc);
}
export function courseKeyOf(doc) {
  const parts = (doc.path || '').split('/');
  const legacySubject = LEGACY_COURSES.get(parts[0].toLowerCase());
  if (legacySubject) return legacySubject + '/' + (legacySubject === 'cs' ? 'dsa' : 'diffeq');
  if (parts.length > 2) return parts.slice(0, 2).join('/');
  if (parts.length === 2) return parts[0];
  return 'course:' + JSON.stringify([subjectOf(doc), courseOf(doc)]);
}
export function topicOf(doc) {
  if (doc.topic || doc.category) return String(doc.topic || doc.category);
  const parts = (doc.path || '').split('/');
  const start = LEGACY_COURSES.has(parts[0].toLowerCase()) ? 1 : 2;
  return parts.length > start + 1 ? parts.slice(start, -1).map(pretty).join(' / ') : '';
}
export function pdfURL(value, base) {
  try {
    const url = new URL(value, base);
    return url.origin === new URL(base).origin && /\.pdf$/i.test(url.pathname) ? url.href : null;
  } catch { return null; }
}
export function normalizeDocuments(data, base) {
  if (!Array.isArray(data.documents)) throw new Error('Invalid notes index');
  const documents = data.documents.filter(d => d && typeof d.title === 'string' && typeof d.url === 'string')
    .map(d => ({ ...d, path: String(d.path || ''), url: pdfURL(d.url, base) }))
    .filter(d => d.url).map(d => ({ ...d, course: courseOf(d), sourceCourse: courseOf(d), courseKey: courseKeyOf(d), subject: subjectOf(d), subjectTitle: subjectTitle(d), topic: topicOf(d),
      addedTime: Number.isFinite(Date.parse(d.added)) ? Date.parse(d.added) : 0,
      searchText: [d.title, courseOf(d), subjectTitle(d), d.semester, d.path, d.search, d.topic, d.category, topicOf(d)].filter(Boolean).join(' ').toLocaleLowerCase() }));
  for (const group of courseGroups(documents)) {
    // Notes nearest the course root name the collection. A worksheet's own
    // course label cannot split a nested folder into another course.
    const depth = Math.min(...group.notes.map(doc => doc.path.split('/').length));
    const labels = new Map();
    for (const doc of group.notes) {
      if (doc.path.split('/').length === depth) labels.set(doc.sourceCourse, (labels.get(doc.sourceCourse) || 0) + 1);
    }
    const name = [...labels].sort(([a, countA], [b, countB]) => countB - countA || a.localeCompare(b))[0][0];
    const aliases = [...new Set(group.notes.map(doc => doc.sourceCourse))];
    for (const doc of group.notes) {
      doc.course = name;
      doc.courseAliases = aliases;
      doc.searchText += ' ' + name.toLocaleLowerCase();
    }
  }
  return documents;
}
export function courseGroups(documents) {
  const groups = new Map();
  for (const doc of documents) {
    const key = JSON.stringify([doc.subject, doc.courseKey]);
    if (!groups.has(key)) groups.set(key, { key: doc.courseKey, subject: doc.subject, name: doc.course, notes: [] });
    groups.get(key).notes.push(doc);
  }
  return [...groups.values()].sort((a, b) => a.name.localeCompare(b.name));
}
export function matchesCourse(doc, course) {
  // Accept the old label-based links as well as stable folder-based links.
  return !course || doc.courseKey === course || doc.course === course || doc.courseAliases?.includes(course);
}
export function subjectGroups(documents) {
  const groups = new Map();
  for (const doc of documents) {
    if (!groups.has(doc.subject)) groups.set(doc.subject, { key: doc.subject, title: doc.subjectTitle, notes: [] });
    groups.get(doc.subject).notes.push(doc);
  }
  return [...groups.values()].sort((a, b) => a.title.localeCompare(b.title));
}
export function filterDocuments(documents, { view = 'all', subject = '', course = '', topic = '', query = '', sort = 'title' } = {}) {
  const terms = query.trim().toLocaleLowerCase().split(/\s+/).filter(Boolean);
  const scope = ['subject', 'course'].includes(view) ? subject : (['all', 'dashboard'].includes(view) ? '' : view);
  return documents.filter(d => (!scope || d.subject === scope)
    && matchesCourse(d, course) && (!topic || d.topic === topic)
    && terms.every(term => d.searchText.includes(term)))
    .sort(sort === 'newest' ? (a, b) => b.addedTime - a.addedTime || compareTitles(a, b) : compareTitles);
}
export function readRoute(hash) {
  const [view, params = ''] = hash.replace(/^#/, '').split('?');
  const values = new URLSearchParams(params);
  const legacySubject = ['cs', 'math', 'research'].includes(view);
  return { view: legacySubject ? 'subject' : (['dashboard', 'all', 'subject', 'course'].includes(view) ? view : 'dashboard'),
    subject: legacySubject ? view : values.get('subject') || '',
    course: values.get('course') || '', topic: values.get('topic') || '', query: values.get('q') || '',
    sort: values.get('sort') === 'newest' ? 'newest' : 'title' };
}
export function routeHash(state) {
  const params = new URLSearchParams();
  for (const [key, value] of [['subject', state.subject], ['course', state.course], ['topic', state.topic], ['q', state.query], ['sort', state.sort === 'newest' ? 'newest' : '']]) {
    if (value) params.set(key, value);
  }
  return '#' + state.view + (params.size ? '?' + params : '');
}
