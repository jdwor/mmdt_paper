#devtools::install_github('jdwor/mmdt')
library(mmdt)
load('path/to/mmdt_paper/Application/ApplicationData.RData')

# this sets whether you want the code to run in parallel
par=T
cores=4

# run MMDT on application data
mmdt.results = mmdt(mmdt.obj, mins = c(-3, -3), maxs = c(3, 3),
                    parallel = par, cores = cores, mc.adjust="BH")

# visualize MMDT results (should match Figure 4C from paper)
fig.mmdt(mmdt.results, type="t-statistic")
fig.mmdt(mmdt.results, type="significance", mc.adjust="BH")

# get text summary of results
summarize.mmdt(mmdt.results)
