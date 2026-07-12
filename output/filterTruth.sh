for f in truth*.txt; do
  awk -F'\t' 'BEGIN{OFS="\t"} FNR==1{print; delete seen; next} { if (seen[$1]++) {$2=$3=$4=""} ; print }' "$f" > "${f%.txt}_sparse.txt"
done
