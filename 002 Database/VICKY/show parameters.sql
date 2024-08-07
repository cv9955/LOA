NAME                                        TYPE        VALUE                                                                                                
------------------------------------------- ----------- ---------------------------------------------------------------------------------------------------- 
active_instance_count                       integer                                                                                                          
adg_account_info_tracking                   string      LOCAL                                                                                                
adg_redirect_dml                            boolean     FALSE                                                                                                
allow_deprecated_rpcs                       string      YES                                                                                                  
allow_global_dblinks                        boolean     FALSE                                                                                                
allow_group_access_to_sga                   boolean     FALSE                                                                                                
allow_rowid_column_type                     boolean     FALSE                                                                                                
_always_anti_join                           string      CHOOSE                                                                                               
_always_semi_join                           string      CHOOSE                                                                                               
approx_for_aggregation                      boolean     FALSE                                                                                                
approx_for_count_distinct                   boolean     FALSE                                                                                                
approx_for_percentile                       string      NONE                                                                                                 
aq_tm_processes                             integer     1                                                                                                    
archive_lag_target                          integer     0                                                                                                    
asm_diskstring                              string                                                                                                           
asm_preferred_read_failure_groups           string                                                                                                           
audit_file_dest                             string      /opt/oracle/admin/XE/adump                                                                           
audit_syslog_level                          string                                                                                                           
audit_sys_operations                        boolean     TRUE                                                                                                 
audit_trail                                 string      DB                                                                                                   
auto_start_pdb_services                     boolean     FALSE                                                                                                
autotask_max_active_pdbs                    integer     2                                                                                                    
awr_pdb_autoflush_enabled                   boolean     FALSE                                                                                                
awr_pdb_max_parallel_slaves                 integer     10                                                                                                   
awr_snapshot_time_offset                    integer     0                                                                                                    
background_core_dump                        string      partial                                                                                              
background_dump_dest                        string      /opt/oracle/homes/OraDBHome21cXE/rdbms/log                                                           
backup_tape_io_slaves                       boolean     FALSE                                                                                                
bitmap_merge_area_size                      integer     1048576                                                                                              
blank_trimming                              boolean     FALSE                                                                                                
blockchain_table_max_no_drop                integer                                                                                                          
_bloom_serial_filter                        string      ON                                                                                                   
_b_tree_bitmap_plans                        boolean     TRUE                                                                                                 
buffer_pool_keep                            string                                                                                                           
buffer_pool_recycle                         string                                                                                                           
cdb_cluster                                 boolean     FALSE                                                                                                
cdb_cluster_name                            string                                                                                                           
cell_offload_compaction                     string      ADAPTIVE                                                                                             
cell_offload_decryption                     boolean     TRUE                                                                                                 
cell_offloadgroup_name                      string                                                                                                           
cell_offload_parameters                     string                                                                                                           
cell_offload_plan_display                   string      AUTO                                                                                                 
cell_offload_processing                     boolean     TRUE                                                                                                 
circuits                                    integer                                                                                                          
client_result_cache_lag                     big integer 3000                                                                                                 
client_result_cache_size                    big integer 0                                                                                                    
client_statistics_level                     string      TYPICAL                                                                                              
clonedb                                     boolean     FALSE                                                                                                
clonedb_dir                                 string                                                                                                           
cluster_database                            boolean     FALSE                                                                                                
cluster_interconnects                       string                                                                                                           
commit_logging                              string                                                                                                           
commit_point_strength                       integer     1                                                                                                    
commit_wait                                 string                                                                                                           
commit_write                                string                                                                                                           
common_user_prefix                          string                                                                                                           
compatible                                  string      21.0.0                                                                                               
_complex_view_merging                       boolean     TRUE                                                                                                 
_compression_compatibility                  string      21.0.0                                                                                               
connection_brokers                          string      ((TYPE=DEDICATED)(BROKERS=1)), ((TYPE=EMON)(BROKERS=1))                                              
container_data                              string      ALL                                                                                                  
containers_parallel_degree                  integer     65535                                                                                                
control_file_record_keep_time               integer     7                                                                                                    
control_files                               string      /opt/oracle/oradata/XE/control01.ctl, /opt/oracle/oradata/XE/control02.ctl                           
control_management_pack_access              string      NONE                                                                                                 
core_dump_dest                              string      /opt/oracle/diag/rdbms/xe/XE/cdump                                                                   
cpu_count                                   integer     4                                                                                                    
cpu_min_count                               string      4                                                                                                    
create_bitmap_area_size                     integer     8388608                                                                                              
create_stored_outlines                      string                                                                                                           
cursor_bind_capture_destination             string      memory+disk                                                                                          
cursor_invalidation                         string      IMMEDIATE                                                                                            
cursor_sharing                              string      EXACT                                                                                                
cursor_space_for_time                       boolean     FALSE                                                                                                
data_guard_max_io_time                      integer     240                                                                                                  
data_guard_max_longio_time                  integer     240                                                                                                  
data_guard_sync_latency                     integer     0                                                                                                    
data_transfer_cache_size                    big integer 0                                                                                                    
db_big_table_cache_percent_target           string      0                                                                                                    
db_block_buffers                            integer     0                                                                                                    
db_block_checking                           string      FALSE                                                                                                
db_block_checksum                           string      TYPICAL                                                                                              
db_block_size                               integer     8192                                                                                                 
db_cache_advice                             string      ON                                                                                                   
db_cache_size                               big integer 0                                                                                                    
db_create_file_dest                         string                                                                                                           
db_create_online_log_dest_1                 string                                                                                                           
db_create_online_log_dest_2                 string                                                                                                           
db_create_online_log_dest_3                 string                                                                                                           
db_create_online_log_dest_4                 string                                                                                                           
db_create_online_log_dest_5                 string                                                                                                           
db_domain                                   string                                                                                                           
db_file_multiblock_read_count               integer     124                                                                                                  
db_file_name_convert                        string                                                                                                           
db_files                                    integer     200                                                                                                  
DBFIPS_140                                  boolean     FALSE                                                                                                
db_flashback_retention_target               integer     1440                                                                                                 
db_flash_cache_file                         string                                                                                                           
db_flash_cache_size                         big integer 0                                                                                                    
db_index_compression_inheritance            string      NONE                                                                                                 
db_keep_cache_size                          big integer 0                                                                                                    
db_lost_write_protect                       string      NONE                                                                                                 
db_name                                     string      XE                                                                                                   
dbnest_enable                               string      NONE                                                                                                 
dbnest_pdb_fs_conf                          string                                                                                                           
db_performance_profile                      string                                                                                                           
db_recovery_file_dest                       string      /mnt/fra                                                                                             
db_recovery_file_dest_size                  big integer 400G                                                                                                 
db_recycle_cache_size                       big integer 0                                                                                                    
db_securefile                               string      PREFERRED                                                                                            
db_ultra_safe                               string      OFF                                                                                                  
db_unique_name                              string      XE                                                                                                   
db_unrecoverable_scn_tracking               boolean     TRUE                                                                                                 
dbwr_io_slaves                              integer     0                                                                                                    
db_writer_processes                         integer     1                                                                                                    
db_16k_cache_size                           big integer 0                                                                                                    
db_2k_cache_size                            big integer 0                                                                                                    
db_32k_cache_size                           big integer 0                                                                                                    
db_4k_cache_size                            big integer 0                                                                                                    
db_8k_cache_size                            big integer 0                                                                                                    
ddl_lock_timeout                            integer     0                                                                                                    
default_sharing                             string      metadata                                                                                             
deferred_segment_creation                   boolean     TRUE                                                                                                 
dg_broker_config_file1                      string      /opt/oracle/homes/OraDBHome21cXE/dbs/dr1XE.dat                                                       
dg_broker_config_file2                      string      /opt/oracle/homes/OraDBHome21cXE/dbs/dr2XE.dat                                                       
dg_broker_start                             boolean     FALSE                                                                                                
_diag_adr_trace_dest                        string      /opt/oracle/diag/rdbms/xe/XE/trace                                                                   
diagnostic_dest                             string      /opt/oracle                                                                                          
diagnostics_control                         string      IGNORE                                                                                               
disable_pdb_feature                         big integer 0                                                                                                    
disk_asynch_io                              boolean     TRUE                                                                                                 
dispatchers                                 string      (PROTOCOL=TCP) (SERVICE=XEXDB), (ADDRESS=(PARTIAL=YES)(PROTOCOL=TCP)), (ADDRESS=(PARTIAL=YES)(PROTOC 
distributed_lock_timeout                    integer     60                                                                                                   
dml_locks                                   integer     2216                                                                                                 
dnfs_batch_size                             integer     4096                                                                                                 
drcp_connection_limit                       integer     0                                                                                                    
drcp_dedicated_opt                          string      NO                                                                                                   
dst_upgrade_insert_conv                     boolean     TRUE                                                                                                 
_ds_xt_split_count                          integer     1                                                                                                    
_eliminate_common_subexpr                   boolean     TRUE                                                                                                 
enable_automatic_maintenance_pdb            boolean     TRUE                                                                                                 
enable_ddl_logging                          boolean     FALSE                                                                                                
enable_dnfs_dispatcher                      boolean     FALSE                                                                                                
enabled_PDBs_on_standby                     string      *                                                                                                    
enable_goldengate_replication               boolean     FALSE                                                                                                
enable_imc_with_mira                        boolean     FALSE                                                                                                
enable_per_pdb_drcp                         boolean     FALSE                                                                                                
enable_pluggable_database                   boolean     TRUE                                                                                                 
_enable_system_app                          integer     1                                                                                                    
encrypt_new_tablespaces                     string      CLOUD_ONLY                                                                                           
event                                       string                                                                                                           
external_keystore_credential_location       string                                                                                                           
fal_client                                  string                                                                                                           
fal_server                                  string                                                                                                           
_fast_full_scan_enabled                     boolean     TRUE                                                                                                 
fast_start_io_target                        integer     0                                                                                                    
fast_start_mttr_target                      integer     0                                                                                                    
fast_start_parallel_rollback                string      LOW                                                                                                  
fileio_network_adapters                     string                                                                                                           
file_mapping                                boolean     FALSE                                                                                                
filesystemio_options                        string      none                                                                                                 
fixed_date                                  string                                                                                                           
forward_listener                            string                                                                                                           
gcs_server_processes                        integer     0                                                                                                    
_generalized_pruning_enabled                boolean     TRUE                                                                                                 
global_names                                boolean     FALSE                                                                                                
global_txn_processes                        integer     1                                                                                                    
_gs_anti_semi_join_allowed                  boolean     TRUE                                                                                                 
_hang_resolution_scope                      string      INSTANCE                                                                                             
hash_area_size                              integer     131072                                                                                               
heartbeat_batch_size                        integer     5                                                                                                    
heat_map                                    string      OFF                                                                                                  
hi_shared_memory_address                    integer     0                                                                                                    
hs_autoregister                             boolean     TRUE                                                                                                 
http_proxy                                  string                                                                                                           
hybrid_read_only                            boolean     FALSE                                                                                                
ifile                                       file                                                                                                             
ignore_session_set_param_errors             string                                                                                                           
_improved_outerjoin_card                    boolean     TRUE                                                                                                 
_improved_row_length_enabled                boolean     TRUE                                                                                                 
_index_join_enabled                         boolean     TRUE                                                                                                 
inmemory_adg_enabled                        boolean     TRUE                                                                                                 
inmemory_automatic_level                    string      OFF                                                                                                  
inmemory_clause_default                     string                                                                                                           
inmemory_deep_vectorization                 boolean     TRUE                                                                                                 
inmemory_expressions_usage                  string      ENABLE                                                                                               
_inmemory_ext_roarea                        big integer 0                                                                                                    
_inmemory_ext_rwarea                        big integer 0                                                                                                    
inmemory_force                              string      DEFAULT                                                                                              
inmemory_max_populate_servers               integer     0                                                                                                    
inmemory_optimized_arithmetic               string      DISABLE                                                                                              
inmemory_prefer_xmem_memcompress            string                                                                                                           
inmemory_prefer_xmem_priority               string                                                                                                           
inmemory_query                              string      ENABLE                                                                                               
inmemory_size                               big integer 0                                                                                                    
inmemory_trickle_repopulate_servers_percent integer     1                                                                                                    
inmemory_virtual_columns                    string      MANUAL                                                                                               
inmemory_xmem_size                          big integer 0                                                                                                    
instance_abort_delay_time                   integer     0                                                                                                    
instance_groups                             string                                                                                                           
instance_mode                               string      READ-WRITE                                                                                           
instance_name                               string      XE                                                                                                   
instance_number                             integer     0                                                                                                    
instance_type                               string      RDBMS                                                                                                
instant_restore                             boolean     FALSE                                                                                                
java_jit_enabled                            boolean     TRUE                                                                                                 
java_max_sessionspace_size                  integer     0                                                                                                    
java_pool_size                              big integer 0                                                                                                    
java_restrict                               string      none                                                                                                 
java_soft_sessionspace_limit                integer     0                                                                                                    
job_queue_processes                         integer     80                                                                                                   
kafka_config_file                           string                                                                                                           
_key_vector_create_pushdown_threshold       integer     20000                                                                                                
_ksb_restart_policy_times                   string      0, 60, 120, 240                                                                                      
large_pool_size                             big integer 320M                                                                                                 
ldap_directory_access                       string      NONE                                                                                                 
ldap_directory_sysauth                      string      no                                                                                                   
_left_nested_loops_random                   boolean     TRUE                                                                                                 
license_max_sessions                        integer     0                                                                                                    
license_max_users                           integer     0                                                                                                    
license_sessions_warning                    integer     0                                                                                                    
listener_networks                           string                                                                                                           
lob_signature_enable                        boolean     FALSE                                                                                                
local_listener                              string      LISTENER_XE                                                                                          
lock_name_space                             string                                                                                                           
lock_sga                                    boolean     FALSE                                                                                                
log_archive_config                          string                                                                                                           
log_archive_dest                            string                                                                                                           
log_archive_dest_state_1                    string      enable                                                                                               
log_archive_dest_state_10                   string      enable                                                                                               
log_archive_dest_state_11                   string      enable                                                                                               
log_archive_dest_state_12                   string      enable                                                                                               
log_archive_dest_state_13                   string      enable                                                                                               
log_archive_dest_state_14                   string      enable                                                                                               
log_archive_dest_state_15                   string      enable                                                                                               
log_archive_dest_state_16                   string      enable                                                                                               
log_archive_dest_state_17                   string      enable                                                                                               
log_archive_dest_state_18                   string      enable                                                                                               
log_archive_dest_state_19                   string      enable                                                                                               
log_archive_dest_state_2                    string      enable                                                                                               
log_archive_dest_state_20                   string      enable                                                                                               
log_archive_dest_state_21                   string      enable                                                                                               
log_archive_dest_state_22                   string      enable                                                                                               
log_archive_dest_state_23                   string      enable                                                                                               
log_archive_dest_state_24                   string      enable                                                                                               
log_archive_dest_state_25                   string      enable                                                                                               
log_archive_dest_state_26                   string      enable                                                                                               
log_archive_dest_state_27                   string      enable                                                                                               
log_archive_dest_state_28                   string      enable                                                                                               
log_archive_dest_state_29                   string      enable                                                                                               
log_archive_dest_state_3                    string      enable                                                                                               
log_archive_dest_state_30                   string      enable                                                                                               
log_archive_dest_state_31                   string      enable                                                                                               
log_archive_dest_state_4                    string      enable                                                                                               
log_archive_dest_state_5                    string      enable                                                                                               
log_archive_dest_state_6                    string      enable                                                                                               
log_archive_dest_state_7                    string      enable                                                                                               
log_archive_dest_state_8                    string      enable                                                                                               
log_archive_dest_state_9                    string      enable                                                                                               
log_archive_dest_1                          string      LOCATION=/mnt/fra/XE/archivelog                                                                      
log_archive_dest_10                         string                                                                                                           
log_archive_dest_11                         string                                                                                                           
log_archive_dest_12                         string                                                                                                           
log_archive_dest_13                         string                                                                                                           
log_archive_dest_14                         string                                                                                                           
log_archive_dest_15                         string                                                                                                           
log_archive_dest_16                         string                                                                                                           
log_archive_dest_17                         string                                                                                                           
log_archive_dest_18                         string                                                                                                           
log_archive_dest_19                         string                                                                                                           
log_archive_dest_2                          string      LOCATION=USE_DB_RECOVERY_FILE_DEST                                                                   
log_archive_dest_20                         string                                                                                                           
log_archive_dest_21                         string                                                                                                           
log_archive_dest_22                         string                                                                                                           
log_archive_dest_23                         string                                                                                                           
log_archive_dest_24                         string                                                                                                           
log_archive_dest_25                         string                                                                                                           
log_archive_dest_26                         string                                                                                                           
log_archive_dest_27                         string                                                                                                           
log_archive_dest_28                         string                                                                                                           
log_archive_dest_29                         string                                                                                                           
log_archive_dest_3                          string                                                                                                           
log_archive_dest_30                         string                                                                                                           
log_archive_dest_31                         string                                                                                                           
log_archive_dest_4                          string                                                                                                           
log_archive_dest_5                          string                                                                                                           
log_archive_dest_6                          string                                                                                                           
log_archive_dest_7                          string                                                                                                           
log_archive_dest_8                          string                                                                                                           
log_archive_dest_9                          string                                                                                                           
log_archive_duplex_dest                     string                                                                                                           
log_archive_format                          string      ARCH_%t_%s_%r.arc                                                                                    
log_archive_max_processes                   integer     4                                                                                                    
log_archive_min_succeed_dest                integer     1                                                                                                    
log_archive_start                           boolean     FALSE                                                                                                
log_archive_trace                           integer     0                                                                                                    
log_buffer                                  big integer 2628K                                                                                                
log_checkpoint_interval                     integer     0                                                                                                    
log_checkpoints_to_alert                    boolean     FALSE                                                                                                
log_checkpoint_timeout                      integer     1800                                                                                                 
log_file_name_convert                       string                                                                                                           
long_module_action                          boolean     TRUE                                                                                                 
mandatory_user_profile                      string                                                                                                           
max_auth_servers                            integer     25                                                                                                   
max_datapump_jobs_per_pdb                   string      100                                                                                                  
max_datapump_parallel_per_job               string      50                                                                                                   
max_dispatchers                             integer                                                                                                          
max_dump_file_size                          string      unlimited                                                                                            
max_idle_blocker_time                       integer     0                                                                                                    
max_idle_time                               integer     0                                                                                                    
max_iops                                    integer     0                                                                                                    
max_mbps                                    integer     0                                                                                                    
max_pdbs                                    integer     254                                                                                                  
max_shared_servers                          integer                                                                                                          
max_string_size                             string      STANDARD                                                                                             
memoptimize_pool_size                       big integer 0                                                                                                    
memory_max_target                           big integer 0                                                                                                    
memory_target                               big integer 0                                                                                                    
min_auth_servers                            integer     1                                                                                                    
multishard_query_data_consistency           string      strong                                                                                               
multishard_query_partial_results            string      not allowed                                                                                          
_mv_access_compute_fresh_data               string      ON                                                                                                   
native_blockchain_features                  string                                                                                                           
_new_initial_join_orders                    boolean     TRUE                                                                                                 
_new_sort_cost_estimate                     boolean     TRUE                                                                                                 
_nlj_batching_enabled                       integer     1                                                                                                    
nls_calendar                                string                                                                                                           
nls_comp                                    string      BINARY                                                                                               
nls_currency                                string                                                                                                           
nls_date_format                             string                                                                                                           
nls_date_language                           string                                                                                                           
nls_dual_currency                           string                                                                                                           
nls_iso_currency                            string                                                                                                           
nls_language                                string      LATIN AMERICAN SPANISH                                                                               
nls_length_semantics                        string      BYTE                                                                                                 
nls_nchar_conv_excp                         string      FALSE                                                                                                
nls_numeric_characters                      string                                                                                                           
nls_sort                                    string                                                                                                           
nls_territory                               string      ARGENTINA                                                                                            
nls_time_format                             string                                                                                                           
nls_timestamp_format                        string                                                                                                           
nls_timestamp_tz_format                     string                                                                                                           
nls_time_tz_format                          string                                                                                                           
noncdb_compatible                           boolean     FALSE                                                                                                
object_cache_max_size_percent               integer     10                                                                                                   
object_cache_optimal_size                   integer     10240000                                                                                             
ofs_threads                                 integer     4                                                                                                    
olap_page_pool_size                         big integer 0                                                                                                    
one_step_plugin_for_pdb_with_tde            boolean     FALSE                                                                                                
open_cursors                                integer     300                                                                                                  
open_links                                  integer     4                                                                                                    
open_links_per_instance                     integer     4                                                                                                    
_optim_enhance_nnull_detection              boolean     TRUE                                                                                                 
optimizer_adaptive_plans                    boolean     TRUE                                                                                                 
optimizer_adaptive_reporting_only           boolean     FALSE                                                                                                
optimizer_adaptive_statistics               boolean     FALSE                                                                                                
_optimizer_ads_use_partial_results          boolean     TRUE                                                                                                 
_optimizer_better_inlist_costing            string      ALL                                                                                                  
optimizer_capture_sql_plan_baselines        boolean     FALSE                                                                                                
optimizer_capture_sql_quarantine            boolean     FALSE                                                                                                
_optimizer_cbqt_or_expansion                string      ON                                                                                                   
_optimizer_cluster_by_rowid_control         integer     129                                                                                                  
_optimizer_control_shard_qry_processing     integer     65472                                                                                                
_optimizer_cost_based_transformation        string      LINEAR                                                                                               
_optimizer_cost_model                       string      CHOOSE                                                                                               
optimizer_cross_shard_resiliency            boolean     FALSE                                                                                                
optimizer_dynamic_sampling                  integer     2                                                                                                    
_optimizer_extended_cursor_sharing          string      UDO                                                                                                  
_optimizer_extended_cursor_sharing_rel      string      SIMPLE                                                                                               
_optimizer_extended_stats_usage_control     integer     192                                                                                                  
optimizer_features_enable                   string      21.1.0                                                                                               
optimizer_ignore_hints                      boolean     FALSE                                                                                                
optimizer_ignore_parallel_hints             boolean     FALSE                                                                                                
optimizer_index_caching                     integer     0                                                                                                    
optimizer_index_cost_adj                    integer     100                                                                                                  
optimizer_inmemory_aware                    boolean     TRUE                                                                                                 
_optimizer_join_order_control               integer     3                                                                                                    
_optimizer_max_permutations                 integer     2000                                                                                                 
optimizer_mode                              string      ALL_ROWS                                                                                             
_optimizer_mode_force                       boolean     TRUE                                                                                                 
_optimizer_native_full_outer_join           string      FORCE                                                                                                
_optimizer_or_expansion                     string      DEPTH                                                                                                
_optimizer_proc_rate_level                  string      BASIC                                                                                                
optimizer_real_time_statistics              boolean     FALSE                                                                                                
optimizer_secure_view_merging               boolean     TRUE                                                                                                 
optimizer_session_type                      string      NORMAL                                                                                               
_optimizer_system_stats_usage               boolean     TRUE                                                                                                 
_optimizer_try_st_before_jppd               boolean     TRUE                                                                                                 
_optimizer_use_cbqt_star_transformation     boolean     TRUE                                                                                                 
optimizer_use_invisible_indexes             boolean     FALSE                                                                                                
optimizer_use_pending_statistics            boolean     FALSE                                                                                                
optimizer_use_sql_plan_baselines            boolean     FALSE                                                                                                
optimizer_use_sql_quarantine                boolean     TRUE                                                                                                 
_optim_peek_user_binds                      boolean     TRUE                                                                                                 
_ordered_nested_loop                        boolean     TRUE                                                                                                 
_or_expand_nvl_predicate                    boolean     TRUE                                                                                                 
os_authent_prefix                           string      ops$                                                                                                 
os_roles                                    boolean     FALSE                                                                                                
outbound_dblink_protocols                   string      ALL                                                                                                  
parallel_adaptive_multi_user                boolean     FALSE                                                                                                
_parallel_broadcast_enabled                 boolean     TRUE                                                                                                 
parallel_degree_limit                       string      CPU                                                                                                  
parallel_degree_policy                      string      MANUAL                                                                                               
parallel_execution_message_size             integer     16384                                                                                                
parallel_force_local                        boolean     FALSE                                                                                                
parallel_instance_group                     string                                                                                                           
parallel_max_servers                        integer     1                                                                                                    
parallel_min_degree                         string      1                                                                                                    
parallel_min_percent                        integer     0                                                                                                    
parallel_min_servers                        integer     0                                                                                                    
parallel_min_time_threshold                 string      AUTO                                                                                                 
parallel_servers_target                     integer     1                                                                                                    
parallel_threads_per_cpu                    integer     1                                                                                                    
pdb_file_name_convert                       string                                                                                                           
pdb_lockdown                                string                                                                                                           
pdb_os_credential                           string                                                                                                           
pdb_template                                string                                                                                                           
permit_92_wrap_format                       boolean     FALSE                                                                                                
pga_aggregate_limit                         big integer 4G                                                                                                   
pga_aggregate_target                        big integer 512M                                                                                                 
_pivot_implementation_method                string      CHOOSE                                                                                               
pkcs11_library_location                     string                                                                                                           
plscope_settings                            string      identifiers:all                                                                                      
plsql_ccflags                               string                                                                                                           
plsql_code_type                             string      INTERPRETED                                                                                          
plsql_debug                                 boolean     FALSE                                                                                                
plsql_optimize_level                        integer     2                                                                                                    
plsql_v2_compatibility                      boolean     FALSE                                                                                                
plsql_warnings                              string      DISABLE:ALL                                                                                          
pmem_filestore                              string                                                                                                           
_pred_move_around                           boolean     TRUE                                                                                                 
pre_page_sga                                boolean     TRUE                                                                                                 
private_temp_table_prefix                   string      ORA$PTT_                                                                                             
processes                                   integer     320                                                                                                  
processor_group_name                        string                                                                                                           
_push_join_predicate                        boolean     TRUE                                                                                                 
_push_join_union_view                       boolean     TRUE                                                                                                 
_push_join_union_view2                      boolean     TRUE                                                                                                 
_px_adaptive_dist_nij_enabled               string      ON                                                                                                   
_px_dist_agg_partial_rollup_pushdown        string      ADAPTIVE                                                                                             
_px_groupby_pushdown                        string      FORCE                                                                                                
_px_partial_rollup_pushdown                 string      ADAPTIVE                                                                                             
_px_shared_hash_join                        boolean     FALSE                                                                                                
_px_wif_dfo_declumping                      string      CHOOSE                                                                                               
query_rewrite_enabled                       string      TRUE                                                                                                 
query_rewrite_integrity                     string      enforced                                                                                             
rdbms_server_dn                             string                                                                                                           
read_only                                   boolean     FALSE                                                                                                
read_only_open_delayed                      boolean     FALSE                                                                                                
recovery_parallelism                        integer     0                                                                                                    
recyclebin                                  string      on                                                                                                   
redo_transport_user                         string                                                                                                           
remote_dependencies_mode                    string      TIMESTAMP                                                                                            
remote_listener                             string                                                                                                           
remote_login_passwordfile                   string      EXCLUSIVE                                                                                            
remote_os_roles                             boolean     FALSE                                                                                                
remote_recovery_file_dest                   string                                                                                                           
replication_dependency_tracking             boolean     TRUE                                                                                                 
resource_limit                              boolean     TRUE                                                                                                 
resource_manage_goldengate                  boolean     FALSE                                                                                                
resource_manager_cpu_allocation             integer     0                                                                                                    
resource_manager_cpu_scope                  string      INSTANCE_ONLY                                                                                        
resource_manager_plan                       string                                                                                                           
result_cache_execution_threshold            integer     2                                                                                                    
_result_cache_latch_count                   integer     4                                                                                                    
result_cache_max_result                     integer     5                                                                                                    
result_cache_max_size                       big integer 30M                                                                                                  
result_cache_max_temp_result                integer     5                                                                                                    
result_cache_max_temp_size                  big integer 80M                                                                                                  
result_cache_mode                           string      MANUAL                                                                                               
result_cache_remote_expiration              integer     0                                                                                                    
resumable_timeout                           integer     0                                                                                                    
rollback_segments                           string                                                                                                           
scheduler_follow_pdbtz                      boolean     FALSE                                                                                                
sec_max_failed_login_attempts               integer     3                                                                                                    
sec_protocol_error_further_action           string      (DROP,3)                                                                                             
sec_protocol_error_trace_action             string      TRACE                                                                                                
sec_return_server_release_banner            boolean     FALSE                                                                                                
serial_reuse                                string      disable                                                                                              
service_names                               string      XE                                                                                                   
session_cached_cursors                      integer     50                                                                                                   
session_max_open_files                      integer     10                                                                                                   
sessions                                    integer     504                                                                                                  
sga_max_size                                big integer 1536M                                                                                                
sga_min_size                                big integer 0                                                                                                    
sga_target                                  big integer 1200M                                                                                                
shadow_core_dump                            string      partial                                                                                              
shard_queries_restricted_by_key             boolean     FALSE                                                                                                
shared_memory_address                       integer     0                                                                                                    
shared_pool_reserved_size                   big integer 13421772                                                                                             
shared_pool_size                            big integer 0                                                                                                    
shared_servers                              integer     0                                                                                                    
shared_server_sessions                      integer                                                                                                          
shrd_dupl_table_refresh_rate                integer     60                                                                                                   
skip_unusable_indexes                       boolean     TRUE                                                                                                 
smtp_out_server                             string                                                                                                           
sort_area_retained_size                     integer     0                                                                                                    
sort_area_size                              integer     65536                                                                                                
spatial_vector_acceleration                 boolean     TRUE                                                                                                 
spfile                                      string      /opt/oracle/dbs/spfileXE.ora                                                                         
_sql_model_unfold_forloops                  string      RUN_TIME                                                                                             
sql_trace                                   boolean     FALSE                                                                                                
sqltune_category                            string      DEFAULT                                                                                              
_sqltune_category_parsed                    string      DEFAULT                                                                                              
sql92_security                              boolean     TRUE                                                                                                 
ssl_wallet                                  string                                                                                                           
standby_db_preserve_states                  string      NONE                                                                                                 
standby_file_management                     string      MANUAL                                                                                               
standby_pdb_source_file_dblink              string                                                                                                           
standby_pdb_source_file_directory           string                                                                                                           
star_transformation_enabled                 string      FALSE                                                                                                
statistics_level                            string      TYPICAL                                                                                              
streams_pool_size                           big integer 0                                                                                                    
_subquery_pruning_mv_enabled                boolean     FALSE                                                                                                
_table_scan_cost_plus_one                   boolean     TRUE                                                                                                 
tablespace_encryption_default_algorithm     string      AES128                                                                                               
tape_asynch_io                              boolean     TRUE                                                                                                 
target_pdbs                                 integer     3                                                                                                    
tde_configuration                           string                                                                                                           
tde_key_cache                               boolean     FALSE                                                                                                
temp_undo_enabled                           boolean     FALSE                                                                                                
thread                                      integer     0                                                                                                    
threaded_execution                          boolean     FALSE                                                                                                
timed_os_statistics                         integer     0                                                                                                    
timed_statistics                            boolean     TRUE                                                                                                 
timezone_version_upgrade_online             boolean     FALSE                                                                                                
trace_enabled                               boolean     TRUE                                                                                                 
tracefile_identifier                        string                                                                                                           
transactions                                integer     554                                                                                                  
transactions_per_rollback_segment           integer     5                                                                                                    
undo_management                             string      AUTO                                                                                                 
undo_retention                              integer     900                                                                                                  
undo_tablespace                             string      UNDOTBS1                                                                                             
unified_audit_common_systemlog              string                                                                                                           
unified_audit_systemlog                     string                                                                                                           
_unified_pga_pool_size                      big integer 0                                                                                                    
uniform_log_timestamp_format                boolean     TRUE                                                                                                 
_union_rewrite_for_gs                       string      YES_GSET_MVS                                                                                         
_unnest_subquery                            boolean     TRUE                                                                                                 
_use_column_stats_for_function              boolean     TRUE                                                                                                 
use_dedicated_broker                        boolean     FALSE                                                                                                
use_large_pages                             string      TRUE                                                                                                 
user_dump_dest                              string      /opt/oracle/homes/OraDBHome21cXE/rdbms/log                                                           
wallet_root                                 string                                                                                                           
workarea_size_policy                        string      AUTO                                                                                                 
xml_db_events                               string      enable                                                                                               
_xt_sampling_scan_granules                  string      ON                                                                                                   
