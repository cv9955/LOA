SELECT component
,current_size/1024/1024 current_size 
,min_size/1024/1024 min_size 
,max_size/1024/1024 max_size 
,user_specified_size/1024/1024 user_size 
,oper_count,last_oper_type, last_oper_time

FROM V$MEMORY_DYNAMIC_COMPONENTS order by current_size desc;