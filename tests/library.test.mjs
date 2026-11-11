import test from 'node:test';
import assert from 'node:assert/strict';
import { normalizeDocuments, filterDocuments, readRoute, routeHash, subjectOf, topicOf, subjectGroups } from '../website/library.mjs';
const base = 'https://mariovergara12.github.io/academic-notes/';
const original = [
  { title: 'AVL Trees', course: 'Data Structures & Algorithms', semester: 'Fall 2026', path: 'cs/dsa/02-trees/avl.typ', url: 'pdfs/cs/dsa/02-trees/avl.pdf', search: 'rotations balance height', added: '2026-11-01T12:00:00Z' },
  { title: 'Exact Equations', course: 'Differential Equations', path: 'math/diffeq/exact.typ', url: 'pdfs/math/diffeq/exact.pdf', search: 'integrating factor', added: '2026-11-03T12:00:00Z' },
  { title: 'Binary Search', course: 'Data Structures & Algorithms', path: 'dsa/00-foundations/binary.typ', url: 'pdfs/dsa/00-foundations/binary.pdf', search: 'sorted arrays' },
];
const docs = normalizeDocuments({ documents: original }, base);
test('original generated schema works under a GitHub Pages project path', () => {
  assert.equal(docs.length, 3);
  assert.equal(docs[0].url, base + original[0].url);
  assert.equal(docs[0].subject, 'cs'); assert.equal(docs[1].subject, 'math');
  assert.equal(docs[0].topic, 'Trees'); assert.equal(docs[1].topic, '');
  assert.equal(docs[2].topic, 'Foundations'); assert.equal(docs[2].addedTime, 0);
});
test('search combines source text, title, topic, and semester, with AND matching', () => {
  assert.deepEqual(filterDocuments(docs, { query: 'ROTATIONS trees' }).map(d => d.title), ['AVL Trees']);
  assert.equal(filterDocuments(docs, { query: 'Fall 2026' }).length, 1);
  assert.equal(filterDocuments(docs, { query: 'rotations equations' }).length, 0);
});
test('subject, course, topic, and query filters combine', () => {
  assert.equal(filterDocuments(docs, { view: 'math', query: 'factor' }).length, 1);
  assert.equal(filterDocuments(docs, { view: 'math', course: 'Data Structures & Algorithms' }).length, 0);
  assert.deepEqual(filterDocuments(docs, { topic: 'Trees' }).map(d => d.title), ['AVL Trees']);
});
test('recent ordering uses actual dates and keeps undated notes last', () => {
  assert.deepEqual(filterDocuments(docs, { sort: 'newest' }).map(d => d.title), ['Exact Equations', 'AVL Trees', 'Binary Search']);
});
test('explicit metadata takes priority over folder defaults', () => {
  assert.equal(subjectOf({ path: 'research/tcs/proof.typ', course: 'Algorithms' }), 'research');
  assert.equal(subjectOf({ subject: 'Mathematics', path: 'calculus/a.typ' }), 'math');
  assert.equal(subjectOf({ subject: 'Mathematics', path: 'cs/proofs/a.typ' }), 'math');
  assert.equal(subjectOf({ path: 'astronomy/one.typ' }), 'astronomy');
  assert.equal(topicOf({ topic: 'Complexity', path: 'cs/dsa/graphs/one.typ' }), 'Complexity');
  assert.equal(subjectOf({ subject: 'Physics', path: 'cs/one.typ' }), 'physics');
});
test('invalid and external PDF URLs are excluded without breaking valid documents', () => {
  const documents = [...original, { title: 'bad', url: 'javascript:alert(1)' }, { title: 'external', url: 'https://example.com/test.pdf' }, { title: 'html', url: 'index.html' }, null];
  assert.equal(normalizeDocuments({ documents }, base).length, 3);
  assert.throws(() => normalizeDocuments({}, base));
  assert.deepEqual(normalizeDocuments({ documents: [] }, base), []);
});
test('routes round-trip spaces, ampersands, Unicode and query parameters', () => {
  const route = { view: 'course', subject: 'cs', course: 'Data Structures & Algorithms', query: 'α + β?', topic: 'Trees / tries', sort: 'newest' };
  assert.deepEqual(readRoute(routeHash(route)), route);
  assert.equal(readRoute('#unknown').view, 'dashboard');
  assert.equal(readRoute('#all?sort=unknown').sort, 'title');
});

test('new subject/course/topic folders work without a frontend allowlist', () => {
  // Transient fixtures only; no subjects or notes are added to the actual library.
  const paths = ['physics/mechanics/waves/wave.typ', 'cs/automata/dfa.typ', 'math/real analysis/limits.typ', 'astronomy/stars.typ'];
  const added = normalizeDocuments({ documents: paths.map(path => ({ title: path, path, url: 'pdfs/' + path.replace('.typ', '.pdf') })) }, base);
  assert.deepEqual(added.map(d => [d.subject, d.course, d.topic]), [
    ['physics', 'Mechanics', 'Waves'], ['cs', 'Automata', ''], ['math', 'Real Analysis', ''], ['astronomy', 'Astronomy', ''],
  ]);
  assert.deepEqual(subjectGroups(added).map(g => g.title), ['Astronomy', 'Computer Science', 'Mathematics', 'Physics']);
  assert.equal(filterDocuments(added, { view: 'subject', subject: 'physics' }).length, 1);
  assert.equal(filterDocuments(added, { query: 'physics' }).length, 1);
});
test('identically named courses in different subjects stay separate', () => {
  const added = normalizeDocuments({ documents: ['physics', 'math'].map(subject => ({ title: subject, course: 'Foundations', path: subject + '/foundations/note.typ', url: 'pdfs/' + subject + '.pdf' })) }, base);
  assert.deepEqual(filterDocuments(added, { view: 'course', subject: 'physics', course: 'Foundations' }).map(d => d.title), ['physics']);
  assert.equal(filterDocuments(added, { view: 'all', course: 'Foundations' }).length, 2);
});
test('dynamic subject routes round-trip and old subject bookmarks remain valid', () => {
  const route = { view: 'subject', subject: 'physics', course: '', topic: '', query: '', sort: 'title' };
  assert.deepEqual(readRoute(routeHash(route)), route);
  assert.equal(readRoute('#cs').subject, 'cs');
  assert.equal(readRoute('#math').view, 'subject');
  assert.equal(subjectOf({ path: 'constructor/note.typ' }), 'constructor');
  assert.equal(subjectOf({ path: 'note.typ', course: 'General' }), 'general');
});
