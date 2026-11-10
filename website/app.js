"use strict";

const searchInput = document.querySelector("#search");
const courseSelect = document.querySelector("#course");
const results = document.querySelector("#results");
const status = document.querySelector("#status");
const updated = document.querySelector("#updated");

let documents = [];

function element(tag, className, value) {
  const e = document.createElement(tag);
  if (className) e.className = className;
  if (value !== undefined) e.textContent = value;
  return e;
}

function showEmpty(title, description) {
  const card = element("div", "empty");
  card.append(element("strong", "", title), element("div", "", description));
  results.append(card);
}

function render() {
  const query = searchInput.value.trim().toLowerCase();
  const course = courseSelect.value;
  const matches = documents.filter(doc =>
    (!course || doc.course === course) &&
    (!query || doc.search.toLowerCase().includes(query))
  );

  results.replaceChildren();
  status.textContent = matches.length + " note" + (matches.length === 1 ? "" : "s") + " found";

  if (matches.length === 0) {
    showEmpty(
      documents.length === 0 ? "Your library is ready" : "No matching notes",
      documents.length === 0
        ? "Add your corrected .typ files under notes/ and push to main. Compiled PDFs will appear here automatically."
        : "Try another search term or choose a different course."
    );
    return;
  }

  const grouped = new Map();
  for (const doc of matches) {
    if (!grouped.has(doc.course)) grouped.set(doc.course, []);
    grouped.get(doc.course).push(doc);
  }

  for (const courseName of [...grouped.keys()].sort((a, b) => a.localeCompare(b))) {
    const group = element("section", "course-group");
    const heading = element("div", "course-header");
    const title = element("h2", "", courseName);
    const subset = grouped.get(courseName).sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
    heading.append(title, element("span", "count", subset.length + " PDFs"));

    const cards = element("div", "cards");
    for (const doc of subset) {
      const link = element("a", "note");
      link.href = doc.url;
      link.target = "_blank";
      link.rel = "noopener noreferrer";
      link.append(
        element("span", "note-title", doc.title),
        element("span", "note-path", doc.path),
        element("span", "note-type", "VIEW PDF")
      );
      cards.append(link);
    }
    group.append(heading, cards);
    results.append(group);
  }
}

async function init() {
  try {
    const response = await fetch("./notes.json", { cache: "no-store" });
    if (!response.ok) throw new Error("HTTP " + response.status);
    const data = await response.json();
    documents = data.documents || [];

    const courses = [...new Set(documents.map(d => d.course))].sort((a, b) => a.localeCompare(b));
    for (const course of courses) {
      const option = document.createElement("option");
      option.value = course;
      option.textContent = course;
      courseSelect.append(option);
    }

    if (data.updated) {
      const date = new Date(data.updated);
      updated.textContent = "Last built " + date.toLocaleDateString();
    }
    render();
  } catch (error) {
    status.textContent = "Unable to load the notes index";
    showEmpty("Index unavailable", "Check the GitHub Actions build logs and try refreshing.");
    console.error(error);
  }
}

searchInput.addEventListener("input", render);
courseSelect.addEventListener("change", render);
init();
