#!/usr/bin/env bash
set -euo pipefail


REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# echo "REPO_ROOT = $REPO_ROOT"


source "${REPO_ROOT}/workflow/pyscenic/config.env"

mkdir -p "${REPO_ROOT}/${OUTDIR}"

docker run -it --rm \
  -v "${REPO_ROOT}":/data \
  "${IMG}" pyscenic grn \
    --num_workers "${NUM_WORKERS}" \
    -o "/data/${OUTDIR}/expr_mat.adjacencies.tsv" \
    "/data/${EXPR}" \
    "/data/${TFS}"

docker run -it --rm \
  -v "${REPO_ROOT}":/data \
  "${IMG}" pyscenic ctx \
    "/data/${OUTDIR}/expr_mat.adjacencies.tsv" \
    "/data/${DB}" \
    --annotations_fname "/data/${MOTIFS}" \
    --expression_mtx_fname "/data/${EXPR}" \
    --mode "custom_multiprocessing" \
    --output "/data/${OUTDIR}/regulons.csv" \
    --num_workers "${NUM_WORKERS}"

docker run -it --rm \
  -v "${REPO_ROOT}":/data \
  "${IMG}" pyscenic aucell \
    "/data/${EXPR}" \
    "/data/${OUTDIR}/regulons.csv" \
    -o "/data/${OUTDIR}/auc_mtx.csv" \
    --num_workers "${NUM_WORKERS}"
  