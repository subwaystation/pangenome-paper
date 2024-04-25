odgi crush -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og -o chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og -t 28 -P
odgi view -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og -g > chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.gfa
# RUST_LOG=info panacus histgrowth chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.gfa -c bp -q 0,1,0.5,0.1 -t 28 > chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.gfa.histgrowth.tsv
RUST_LOG=info panacus histgrowth chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.gfa -c bp -q 0,0.95,0.5,0.1 -t 28 > chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.gfa.histgrowth.095.tsv
odgi stats -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og -m -sgdl > chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.stats.yaml
odgi stats -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og -m -sgdl > chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.stats.yaml
mv chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.stats.yaml chr19.1000.crush.fa.gz.gfaffix.unchop.Ygs.og.crush.og.stats.yaml
multiqc .
odgi layout -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og -o chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.lay -P -t 28
odgi draw -i chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og -c chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.lay -p chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.lay.png  -T chr19.1000.fa.gz.gfaffix.unchop.Ygs.og.crush.og.lay.tsv -C -w 20 -H 1000
