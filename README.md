# resume

My resume, built on Typst, based on [kiresume](https://typst.app/universe/package/kiresume)

[Download the latest resume PDF](https://github.com/rafayet-git/resume/releases/download/latest/rh-resume.pdf)

This repository includes a GitHub Actions workflow that automatically builds the resume and updates my personal website with the new resume whenever changes are pushed.

### Build Locally
```sh
typst compile --font-path fonts main.typ rh-resume.pdf
```