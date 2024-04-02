for C in 1 2 4 8 16 32 64 128 256 512 1024;
do
    rm -rf /sfs/9/ws/afaaj01-ecoli_2146/eval/"$C"chunks
    mkdir -p /sfs/9/ws/afaaj01-ecoli_2146/eval/"$C"chunks
    cd /sfs/9/ws/afaaj01-ecoli_2146/eval/"$C"chunks
    nextflow run nf-core/pangenome -r 1.1.2 -profile cfc --input /home-link/afaaj01/data/ecoli_2146/*.1024haps.fa.gz -c /home-link/afaaj01/nfx_configs/ecoli_chunks.config --n_haplotypes 1024 --wfmash_map_pct_id 90 --wfmash_segment_length 5k -w work_ecoli_"$C"chunks --outdir results_ecoli_"$C"chunks --wfmash_only --wfmash_chunks "$C"
done
