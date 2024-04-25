odgi explode -i ecoli_2146.fa.gz.gfaffix.unchop.Ygs.og --biggest 1 --optimize -p ecoli2146.pan.explode
odgi crush -i ecoli2146.pan.explode.0.og -o ecoli2146.pan.explode.0.og.crush.og -P -t 28
## plasmids are distorting the core pangenome
# odgi view -i ecoli2146.pan.explode.0.og.crush.og -g > ecoli2146.pan.explode.0.og.crush.gfa
# RUST_LOG=info panacus histgrowth ecoli2146.pan.explode.0.og.crush.gfa -c bp -q 0,1,0.5,0.1 -t 28 > ecoli2146.pan.explode.0.og.crush.gfa.histgrowth.tsv
odgi paths -i ecoli2146.pan.explode.0.og.crush.og -L > ecoli2146.pan.explode.0.og.crush.og.paths
grep plasmid ecoli2146.pan.explode.0.og.crush.og.paths > ecoli2146.pan.explode.0.og.crush.og.paths.plasmids
odgi paths -i ecoli2146.pan.explode.0.og.crush.og -X ecoli2146.pan.explode.0.og.crush.og.paths.plasmids -t 28 -P -o ecoli2146.pan.explode.0.og.crush.og.2013.og
odgi view -i ecoli2146.pan.explode.0.og.crush.og.2013.og -g > ecoli2146.pan.explode.0.og.crush.og.2013.gfa
# RUST_LOG=info panacus histgrowth ecoli2146.pan.explode.0.og.crush.og.2013.gfa -c bp -q 0,1,0.5,0.1 -t 28 > ecoli2146.pan.explode.0.og.crush.og.2013.gfa.histgrowth.tsv
RUST_LOG=info panacus histgrowth ecoli2146.pan.explode.0.og.crush.og.2013.gfa -c bp -q 0,0.95,0.5,0.1 -t 28 > ecoli2146.pan.explode.0.og.crush.og.2013.gfa.histgrowth.095.tsv
odgi stats -i ecoli_2146.fa.gz.gfaffix.unchop.Ygs.og -m -sgdl > ecoli_2146.fa.gz.gfaffix.unchop.Ygs.og.stats.yaml
odgi stats -i ecoli2146.pan.explode.0.og -m -sgdl > ecoli2146.pan.explode.fa.0.og.stats.yaml
odgi stats -i ecoli2146.pan.explode.0.og.crush.og -m -sgdl > ecoli2146.pan.explode.crush.fa.0.og.crush.og.stats.yaml
odgi stats -i ecoli2146.pan.explode.0.og.crush.og.2013.og -m -sgdl > ecoli2146.pan.explode.crush.no_plasmids.fa.0.og.crush.og.2013.og.stats.yaml
multiqc .
odgi layout -i ecoli2146.pan.explode.0.og.crush.og.2013.og -o ecoli2146.pan.explode.0.og.crush.og.2013.og.lay -P -t 28
odgi draw -i ecoli2146.pan.explode.0.og.crush.og.2013.og -c ecoli2146.pan.explode.0.og.crush.og.2013.og.lay -p ecoli2146.pan.explode.0.og.crush.og.2013.og.lay.png  -T ecoli2146.pan.explode.0.og.crush.og.2013.og.lay.tsv -C -w 20 -H 1000
