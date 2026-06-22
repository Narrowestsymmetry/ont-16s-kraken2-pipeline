#!/usr/bin/env bash
# 01_basecall.sh
# Dorado basecalling: POD5 → FASTQ
# Usage: bash 01_basecall.sh <pod5_dir> <output_dir> [model]

set -euo pipefail

POD5_DIR="${1:?Usage: $0 <pod5_dir> <output_dir> [model]}"
OUT_DIR="${2:?Usage: $0 <pod5_dir> <output_dir> [model]}"
MODEL="${3:-dna_r10.4.1_e8.2_400bps_hac@v4.3.0}"

mkdir -p "$OUT_DIR"

echo "[$(date '+%H:%M:%S')] Starting Dorado basecalling..."
echo "  POD5 input : $POD5_DIR"
echo "  Output dir : $OUT_DIR"
echo "  Model      : $MODEL"

dorado basecaller "$MODEL" "$POD5_DIR" \
    --min-qscore 8 \
    --emit-fastq \
    > "$OUT_DIR/basecalled.fastq"

echo "[$(date '+%H:%M:%S')] Basecalling done."
echo "  Output: $OUT_DIR/basecalled.fastq"

# Basic read count
READ_COUNT=$(grep -c "^@" "$OUT_DIR/basecalled.fastq")
echo "  Reads passing filter: $READ_COUNT"
