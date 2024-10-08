# model,TDP,n_cores,TDP_per_core
# AMD EPYC 7343,190,16,11.9

co2e <- function(t, nc, pc, uc, nm, pm, pue, ci) {
  return (t * (nc * pc * uc + nm *pm) * pue * ci)
}

t <- 173 # the running time of the computation (h)
nc <- 64 # number of cores as requested by the SLURM job
pc <- 11.9 # the power draw of a computing core (W) according to the CPU model
uc <- 0.73359375 # the core usage factor (between 0 and 1): Usage was 4692%, so we do: 4692/6400 = 0.73359375
nm <- 489 # the RAM we asked for
pm <- 0.3725 # the power draw of memory (W, per GB), default value from Sabrina
pue <- 1.3 # the efficiency coefficient of the data centre which is exactly this value for our cluster
ci <- 338 # the carbon intensity of energy production, which represents the carbon footprint of producing 1 kWh of energy for a given country and energy mix, in this case the one for Germany

pggb <- co2e(t,nc,pc,uc,nm,pm,pue,ci)
## we calculated the co2e in mg, but we want kg
pggb <- pggb / 1000000
pggb
# 56.31717
