vim-github-actions
==================

Local Vim syntax support for GitHub Actions workflow and action files.

What it does:

- Marks `.github/workflows/*.yml` and `.github/workflows/*.yaml` as GitHub
  Actions YAML buffers.
- Marks `action.yml` and `action.yaml` as GitHub Action definition buffers.
- Extends YAML syntax so `run: |` and `run: >` blocks can highlight embedded
  `bash` by default, and embedded `python` when a preceding sibling key uses
  `shell: python`.

This bundle is intended for Pathogen and is loaded automatically from
`bundle/`.
