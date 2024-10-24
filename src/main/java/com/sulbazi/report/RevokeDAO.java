package com.sulbazi.report;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RevokeDAO {

	int revoke(RevokeDTO revoke_dto);

}
