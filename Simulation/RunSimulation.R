#devtools::install_github('jdwor/mmdt')
library(mmdt)
source('path/to/mmdt_paper/Simulation')

#################################################
## Different values used in simulation studies ##
#################################################

# beta_params gives the four scenarios with different levels of group difference
# Each row gives c(\alpha_A, \beta_A, \alpha_B, \beta_B) for drawing \theta_i
beta_params=rbind(c(2,5,2,5),c(5,4,4,5),
                  c(5,3,3,5),c(5,2,2,5))

# samples gives different sample sizes per group
samples=c(20,30,50,80)

# voxels gives different numbers of voxels per subject
voxels=c(500,1000,2500,5000,10000)


#########################################################
## Obtain results for a specific combination of params ##
#########################################################

tvals=beta_params[3,]
samp=samples[2]
vox=voxels[4]

# this sets whether you want the code to run in parallel
par=T
cores=4

# this function creates the data object
mmdt.obj=simSample(n1=samp,n2=samp,voxels=vox,
                   a1=tvals[1],b1=tvals[2],
                   a2=tvals[3],b2=tvals[4])

# this function runs the MMDT (see ?mmdt for instructions on input values)
results=mmdt(mmdt.obj,mins=c(-3,-3),maxs=c(3,3),
             gridsize=c(151,151),mc.adjust=c("BH","BY"),
             nperm=500,parallel=par,cores=cores)

# results obj will contain several objects that can be used to check sim results
# 1) subject.densities gives subjects' density estimates over a grid
# 2) teststat.matrix gives the test statistic matrix
# 3) pval.matrix.uncorrected gives uncorrected p-values 
# 4-x) pval.matrix.XX.corrected gives p-values corrected by XX method
# x+1) evaluated.points gives a vector of the tested locations in the density space for each dimension
# x+2) group.diff gives the direction of the group differences test by group names

# create matrix stating whether the null is false or true at each tested point
evals=results$evaluated.points
falsenull=matrix(FALSE, nrow=151, ncol=151)
falsenull[evals[[1]]<=0,evals[[2]]>=0]=TRUE

# visualize results
image(falsenull)
fig.mmdt(results, type="t-statistic")
fig.mmdt(results, type="significance",mc.adjust="BH")


