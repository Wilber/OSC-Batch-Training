#A function representing the core 'work' for our task: sum elements of a large vector
#We'll want to run this proc 100x
myProc <- function(size=500000000){
	# Load a large vector 
	vec <- rnorm(size) 
	# Now sum the vec values 
	return(sum(vec)) 
}

max_loop <- 100 

## version 5: use snow backed by Rmpi 
#These packages are installed at OSC
library(Rmpi)# for mpi.* 
library(snow) # for clusterExport, clusterApply

workers <- as.numeric(Sys.getenv(c("SLURM_NTASKS")))-1 

cl <- makeCluster(workers, type="MPI") # MPI tasks to use 
clusterExport(cl, list('myProc')) 
tick <- proc.time()
result <- clusterApply(cl, 1:max_loop, function(i) myProc()) 
write.table(result, file = "foo.csv", sep = ",", row.names = FALSE) 
tock <- proc.time() - tick 
cat("\nsnow w/ Rmpi test times using", workers, "MPI workers: \n")
tock 
stopCluster(cl)
mpi.quit()
