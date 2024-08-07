SHOW PARAMETER PARALLEL;
/*
NAME                            TYPE    VALUE  
------------------------------- ------- ------ 
awr_pdb_max_parallel_slaves     integer 10     
containers_parallel_degree      integer 65535  
fast_start_parallel_rollback    string  LOW    
max_datapump_parallel_per_job   string  50     
optimizer_ignore_parallel_hints boolean FALSE  
parallel_adaptive_multi_user    boolean FALSE  
_parallel_broadcast_enabled     boolean TRUE   
parallel_degree_limit           string  CPU    
parallel_degree_policy          string  MANUAL 
parallel_execution_message_size integer 16384  
parallel_force_local            boolean FALSE  
parallel_instance_group         string         
parallel_max_servers            integer 1      
parallel_min_degree             string  1      
parallel_min_percent            integer 0      
parallel_min_servers            integer 0      
parallel_min_time_threshold     string  AUTO   
parallel_servers_target         integer 1      
parallel_threads_per_cpu        integer 1      
recovery_parallelism            integer 0  */

SHOW PARAMETER cpu;
/*
NAME                            TYPE    VALUE         
------------------------------- ------- ------------- 
cpu_count                       integer 4             
cpu_min_count                   string  4             
parallel_threads_per_cpu        integer 1             
resource_manager_cpu_allocation integer 0             
resource_manager_cpu_scope      string  INSTANCE_ONLY */




ALTER SESSION SET PARALLEL_DEGREE_POLICY = LIMITED;
