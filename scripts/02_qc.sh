#!/usr/bin/env bash
# 02_qc.sh
# NanoPlot QC on basecalled FASTQ
# Usage: bash 02_qc.sh <fastq_file> <output_dir>

set -euo pipefail

FASTQ="${1:?Usage: $0 <fastq_file> <output_dir>}"
OUT_DIR="${2:?Usage: $0 <fastq_file> <output_dir>}"

mkdir -p "$OUT_DIR"

echo "[$(date '+%H:%M:%S')] Running NanoPlot QC..."
echo "  Input  : $FASTQ"
echo "  Output : $OUT_DIR"

NanoPlot \
    --fastq "$FASTQ" \
    --outdir "$OUT_DIR" \
    --plots hex dot \
    --N50 \
    --threads 4 \
    --prefix "16S_QC_"

echo "[$(date '+%H:%M:%S')] NanoPlot done."
echo "  Report: $OUT_DIR/16S_QC_NanoPlot-report.html"



bash scripts/02_qc.sh results/basecalled.fastq results/qc/
