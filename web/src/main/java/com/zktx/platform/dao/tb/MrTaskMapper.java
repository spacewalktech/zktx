package com.zktx.platform.dao.tb;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.zktx.platform.entity.tb.MrTask;
import com.zktx.platform.entity.tb.MrTaskWithBLOBs;

public interface MrTaskMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MrTaskWithBLOBs record);

    int insertSelective(MrTaskWithBLOBs record);

    MrTaskWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MrTaskWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(MrTaskWithBLOBs record);

    int updateByPrimaryKey(MrTask record);
    
    void taskAction(Integer id);
    
    List<MrTaskWithBLOBs> findByPagination(
    		@Param("latest_running_status") Integer latest_running_status,
    		@Param("offset") Integer offset,
    		@Param("limit") Integer limit,
    		@Param("search_name") String search_name, 
    		@Param("search_type") String search_type, 
    		@Param("search_triggle_tables") String search_triggle_tables, 
    		@Param("search_active") String search_active, 
    		@Param("search_create_time_begin") String search_create_time_begin, 
    		@Param("search_create_time_end") String search_create_time_end
    );
    //查询待运行的任务
    List<MrTaskWithBLOBs> findByHasProcessed(@Param("has_processed") Integer has_processed,@Param("offset") Integer offset ,@Param("limit") Integer limit);

	int findCount();

	int findCountByPagination(
    		@Param("latest_running_status") Integer latest_running_status,
    		@Param("offset") Integer offset,
    		@Param("limit") Integer limit,
    		@Param("search_name") String search_name, 
    		@Param("search_type") String search_type, 
    		@Param("search_triggle_tables") String search_triggle_tables, 
    		@Param("search_active") String search_active, 
    		@Param("search_create_time_begin") String search_create_time_begin, 
    		@Param("search_create_time_end") String search_create_time_end
	);
    
}