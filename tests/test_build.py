"""Protect optional Git metadata without invoking Typst or changing the checkout."""
import importlib.util
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('notes_build', Path(__file__).resolve().parents[1] / 'scripts/build.py')
build = importlib.util.module_from_spec(spec)
spec.loader.exec_module(build)


def result(stdout):
    return subprocess.CompletedProcess([], 0, stdout=stdout, stderr='')


class AdditionDatesTest(unittest.TestCase):
    @patch.object(build.subprocess, 'run')
    def test_first_addition_is_preserved(self, run):
        run.side_effect = [result('false\n'), result(
            'added:2026-10-01T12:00:00Z\n\nnotes/cs/a.typ\nnotes/math/b.typ\n'
            'added:2026-11-01T12:00:00Z\n\nnotes/cs/a.typ\nnotes/cs/new note.typ\n')]
        dates = build.addition_dates()
        self.assertEqual(dates['cs/a.typ'], '2026-10-01T12:00:00Z')
        self.assertEqual(dates['cs/new note.typ'], '2026-11-01T12:00:00Z')
        self.assertEqual(len(dates), 3)

    @patch.object(build.subprocess, 'run', return_value=result('true\n'))
    def test_shallow_history_does_not_invent_dates(self, run):
        self.assertEqual(build.addition_dates(), {})
        self.assertEqual(run.call_count, 1)

    @patch.object(build.subprocess, 'run', side_effect=FileNotFoundError('git unavailable'))
    def test_source_only_builds_still_work(self, run):
        self.assertEqual(build.addition_dates(), {})

    @patch.object(build.subprocess, 'run', side_effect=subprocess.TimeoutExpired('git', 10))
    def test_optional_history_timeout_is_nonfatal(self, run):
        self.assertEqual(build.addition_dates(), {})


class CourseFoldersTest(unittest.TestCase):
    def test_new_folders_provide_course_names(self):
        for source, expected in [
            ('physics/mechanics/waves/note.typ', 'Mechanics'),
            ('cs/automata/note.typ', 'Automata'),
            ('math/real analysis/note.typ', 'Real Analysis'),
            ('physics/note.typ', 'Physics'),
            ('note.typ', 'General'),
            ('dsa/02-trees/note.typ', 'Data Structures & Algorithms'),
        ]:
            with self.subTest(source=source):
                self.assertEqual(build.default_course(Path(source)), expected)


class AssetVersionsTest(unittest.TestCase):
    def make_assets(self, output):
        for source in build.WEBSITE.iterdir():
            if source.is_file():
                (output / source.name).write_bytes(source.read_bytes())

    def test_html_and_module_imports_use_existing_versioned_files(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            self.make_assets(output)
            versions = build.version_assets(output)
            html = (output / 'index.html').read_text()
            for name in ('app.js', 'theme.js', 'styles.css', 'favicon.svg'):
                self.assertIn('"' + versions[name] + '"', html)
                self.assertNotIn('"' + name + '"', html)
                self.assertTrue((output / versions[name]).is_file())
            app = (output / versions['app.js']).read_text()
            self.assertIn("'./" + versions['library.mjs'] + "'", app)
            self.assertNotIn("'./library.mjs'", app)
            # Keep the ordinary files available to older HTML during rollout.
            self.assertTrue((output / 'app.js').is_file())

    def test_dependency_changes_invalidate_app_but_not_unrelated_assets(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            self.make_assets(output)
            before = build.version_assets(output)
            with (output / 'library.mjs').open('a') as library:
                library.write('\n// Changed dependency\n')
            self.make_index(output)
            after = build.version_assets(output)
            self.assertNotEqual(before['library.mjs'], after['library.mjs'])
            self.assertNotEqual(before['app.js'], after['app.js'])
            self.assertEqual(before['styles.css'], after['styles.css'])
            self.assertIn(after['app.js'], (output / 'index.html').read_text())

    def test_identical_builds_produce_identical_urls(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            self.make_assets(output)
            before = build.version_assets(output)
            self.make_assets(output)
            self.assertEqual(before, build.version_assets(output))

    def make_index(self, output):
        (output / 'index.html').write_bytes((build.WEBSITE / 'index.html').read_bytes())


if __name__ == '__main__':
    unittest.main()
