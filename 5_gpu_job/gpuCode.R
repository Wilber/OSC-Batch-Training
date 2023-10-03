#An R code for GPU-accelerated matrix miltiplication

#install package, "install.packages" can be problematic
#devtools::install_github('cdeterman/gpuR', ref = 'develop')

#library(pryr) #if we wanted to look at addresses
nr <- 5000  #lets be square
x <- matrix(rnorm(nr * nr, 0, 1), nrow = nr, ncol = nr)

# CPU bound version, we could optimize but lets stay vanilla
time1 <- system.time({
    mm1 <- x %*% x
})

library(gpuR)
# GPU version, GPU pointer to CPU memory!! (gpuMatrix is simply a pointer)
gpuX = gpuMatrix(x, type = "float")  #point GPU to matrix
time2 <- system.time({
    mm2 <- gpuX %*% gpuX
})

# GPU version, in GPU memory!! (vclMatrix formation is a memory transfer)
vclX = vclMatrix(x, type = "float")  #push matrix to GPU
time3 <- system.time({
    mm3 <- vclX %*% vclX
})

write.table(rbind(time1,time2,time3), "gpu_proc_time.txt", sep = "\t",col.names=NA)

detach("package:gpuR", unload = TRUE)

