package com.sulbazi.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RevokeDAO {

	int revoke(RevokeDTO revoke_dto);

	void revokeUpdate(Map<String, Object> map);

	List<RevokeDTO> process();

}
