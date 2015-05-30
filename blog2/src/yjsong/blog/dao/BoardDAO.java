package yjsong.blog.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.ModelMap;

import yjsong.blog.model.Board;




public interface BoardDAO {
	
	public void setSqlSession(SqlSession sqlSession);

	List<Board> selectBoardList(Board model);

	public Board selectBoardView(Board model);

	public Board selectSaveData();

	public void insertBoardWrite(Board model);

	public void updateBoardWrite(Board model);

	public void deleteBoardView(Board model);

	public void updateReadCount(Board model);

	
}
