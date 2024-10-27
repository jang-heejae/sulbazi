package com.sulbazi.report;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface RevokeDAO {

	int revoke(RevokeDTO revoke_dto);

	void revokeUpdate(Map<String, Object> map);

	List<RevokeDTO> getRevokeByUserId(String reported_id);

	List<String> userIds();

	void revokeSchedule(String userId, LocalDate today);

}
