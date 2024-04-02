cd eval

# TIMES
for C in 1 2 4 8 16 32 64 128 256 512 1024;
do
	grep ALIGN "$C"chunks/results_ecoli_"$C"chunks/pipeline_info/execution_trace_*.txt | cut -f 9 > "$C"chunks_ALIGN.tsv
done

# CO2
for C in 1 2 4 8 16 32 64 128 256 512 1024;
do
	grep emissions "$C"chunks/results_ecoli_"$C"chunks/pipeline_info/co2footprint_summary_*.txt | cut -f 2 -d":" | cut -f 2 -d" " > "$C"chunks_ALIGN_emissions.tsv
done
