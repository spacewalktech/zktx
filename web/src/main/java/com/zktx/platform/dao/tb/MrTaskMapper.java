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
    
    List<MrTaskWithBLOBs> findByPagination(@Param("fromRowId") Integer fromRowId,@Param("num") Integer num);
    //查询待运行的任务
    List<MrTaskWithBLOBs> findByHasProcessed(@Param("has_processed") Integer has_processed,@Param("fromRowId") Integer fromRowId,@Param("num") Integer num);
    
}