# Gene regulatory network inference


We inferred GRNs and regulon activity using pySCENIC via the official Docker image `aertslab/pyscenic:0.12.0`, following the SCENIC workflow: GRN inference → motif enrichment (CTX) → AUCell scoring. Input expression matrices and cisTarget ranking databases were mounted into the container and processed using 6 workers per step.

**Input**

* raw gene expression counts of 1539 posterior midgut cells across 10695 genes → `PMG_allgenes_expr.tsv`
* list of all genes encoding transcription factors in Drosophila melanogaster → `allTFs_dmel.txt`
* cisTarget database → `dm6_v10_clust.genes_vs_motifs.rankings.feather`
* motif annotation table → `motifs-v10nr_clust-nr.flybase-m0.001-o0.0.tbl`

**Output**

* GRN edges → `expr_mat.adjacencies.tsv`
* regulons → `regulons.csv`
* AUCell matrix → `auc_mtx.csv`

**How to run**

bash workflow/pyscenic/run_pyscenic.sh

**References**
- Aibar S. et al. (2017). SCENIC: single-cell regulatory network inference and clustering. *Nature Methods*.
- pySCENIC GitHub: https://github.com/aertslab/pySCENIC  
- Docker image used: aertslab/pyscenic:0.12.0