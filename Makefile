
# use this Makefile as base in your project by running
# git remote add make https://github.com/spraakbanken/python-uv-make-conf
# git fetch make
# git merge --allow-unrelated-histories make/main
#
# To later update this makefile:
# git fetch make
# git merge make/main
#
.default: help

.PHONY: help
help:
	@echo "usage:"
	@echo "dev | install-dev"
	@echo "   setup development environment"
	@echo "install"
	@echo "   setup production environment"
	@echo ""
	@echo "info"
	@echo "   print info about the system and project"
	@echo ""
	@echo "test"
	@echo "   run all tests"
	@echo ""
	@echo "test-w-coverage [cov=] [cov_report=]"
	@echo "   run all tests with coverage collection. (Default: cov_report='term-missing', cov='--cov=${PROJECT_SRC}')"
	@echo ""
	@echo "lint"
	@echo "   lint the code"
	@echo ""
	@echo "lint-fix"
	@echo "   lint the code and try to fix it"
	@echo ""
	@echo "type-check"
	@echo "   check types"
	@echo ""
	@echo "fmt"
	@echo "   format the code"
	@echo ""
	@echo "check-fmt"
	@echo "   check that the code is formatted"
	@echo ""
	@echo "bumpversion [part=]"
	@echo "   bumps the given part of the version of the project. (Default: part='patch')"
	@echo ""
	@echo "bumpversion-show"
	@echo "   shows the bump path that is possible"
	@echo ""
	@echo "publish [branch=]"
	@echo "   pushes the given branch including tags to origin, for CI to publish based on tags. (Default: branch='main')"
	@echo "   Typically used after 'make bumpversion'"
	@echo ""
	@echo "prepare-release"
	@echo "   run tasks to prepare a release"
	@echo ""

PLATFORM := `uname -o`
REPO := sparv-sbx-emotional-classification
PROJECT_SRC := "sparv-sbx-sentence-emotional-classification-kb-emoclass/src"

ifeq (${VIRTUAL_ENV},)
  VENV_NAME = .venv
  INVENV = uv run
else
  VENV_NAME = ${VIRTUAL_ENV}
  INVENV =
endif

default_cov := "--cov"
cov_report := "term-missing"
cov := ${default_cov}

all_tests := sparv-sbx-sentence-emotional-classification-kb-emoclass/tests
tests := sparv-sbx-sentence-emotional-classification-kb-emoclass/tests

info:
	@echo "Platform: ${PLATFORM}"
	@echo "INVENV: '${INVENV}'"

dev: install-dev

# setup development environment
install-dev: install-pre-commit
	uv sync --all-packages --dev

# install pre-commit hooks
install-pre-commit: .git/hooks/pre-commit
.git/hooks/pre-commit: .pre-commit-config.yaml
	@if command -v pre-commit > /dev/null; then pre-commit install; else echo "WARN: 'pre-commit' not installed"; fi

# setup production environment
install:
	uv sync --all-packages --no-dev

lock: uv.lock

uv.lock: pyproject.toml
	uv lock

.PHONY: test
test:
	${INVENV} pytest -vv ${tests}

.PHONY: test-w-coverage
# run all tests with coverage collection
test-w-coverage:
	${INVENV} pytest -vv ${cov} --cov-report=term-missing --cov-report=xml:coverage.xml --cov-report=lcov:coverage.lcov ${all_tests}

.PHONY: doc-tests
doc-tests:
	${INVENV} pytest ${cov} --cov-report=term-missing --cov-report=xml:coverage.xml --cov-report=lcov:coverage.lcov --doctest-modules ${PROJECT_SRC}

.PHONY: type-check
# check types
type-check:
	${INVENV} mypy ${PROJECT_SRC} ${tests}

.PHONY: lint
# lint the code
lint:
	${INVENV} ruff check ${PROJECT_SRC} ${tests}

.PHONY: lint-fix
# lint the code (and fix if possible)
lint-fix:
	${INVENV} ruff check --fix ${PROJECT_SRC} ${tests}

part := "patch"
bumpversion:
	${INVENV} bump-my-version bump ${part}

bumpversion-show:
	${INVENV} bump-my-version show-bump

# run formatter(s)
fmt:
	${INVENV} ruff format ${PROJECT_SRC} ${tests}

.PHONY: check-fmt
# check formatting
check-fmt:
	${INVENV} ruff format --check ${PROJECT_SRC} ${tests}

build:
	uv build

branch := "main"
publish:
	git push -u origin ${branch} --tags


.PHONY: prepare-release
prepare-release: update-changelog tests/requirements-testing.lock

# we use lock extension so that dependabot doesn't pick up changes in this file
tests/requirements-testing.lock: pyproject.toml
	uv export --dev --format requirements-txt --no-hashes --no-emit-project --output-file $@

.PHONY: update-changelog
update-changelog: CHANGELOG.md

.PHONY: CHANGELOG.md
CHANGELOG.md:
	git cliff --unreleased --prepend $@

# update snapshots for `syrupy`
.PHONY: snapshot-update
snapshot-update:
	${INVENV} pytest --snapshot-update

### === project targets below this line ===
test-example-small-txt:
	rm -rf examples/small-txt/export examples/small-txt/sparv-workdir .snakemake
	cd examples/small-txt; ${INVENV} sparv run --stats
	diff assets/small-txt/small_export.gold.xml \
	    examples/small-txt/export/xml_export.pretty/small_export.xml

update-example-small-txt-snapshot: assets/small-txt/small_export.gold.xml

assets/small-txt/small_export.gold.xml: examples/small-txt/export/xml_export.pretty/small_export.xml
	@mkdir -pv $(shell dirname "$@")
	@cp $< $@

.PHONY: check-example-load-time
example-importtime-small-txt: examples/small-txt/importtime-small-txt.log

.PHONY: examples/small-txt/importtime-small-txt.log
examples/small-txt/importtime-small-txt.log:
	cd examples/small-txt; ${INVENV} python -X importtime -m sparv config 2> importtime-small-txt.log

.PHONY: display-importtime-small-txt
display-importtime-small-txt: examples/small-txt/importtime-small-txt.log
	tuna $<

install-dev-metadata:
	uv sync --all-packages --group metadata --dev

.PHONY: generate-metadata
generate-metadata: install-dev-metadata \
	sparv-sbx-sentence-emotional-classification-kb-emoclass/src/sbx_sentence_emotional_classification_kb_emoclass/metadata.yaml
	rm -rf assets/metadata/export/sbx_metadata
	cd assets/metadata; ${INVENV} sparv run sbx_metadata:plugin_analysis_metadata_export
