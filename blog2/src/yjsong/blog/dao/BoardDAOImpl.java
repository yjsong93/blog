package yjsong.blog.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.ModelMap;

import yjsong.blog.model.Board;




public class BoardDAOImpl implements BoardDAO {

	private SqlSession sqlSession;    
    
    public void setSqlSession(SqlSession sqlSession)
    {
        this.sqlSession = sqlSession;
    }

	@Override
	public List<Board> selectBoardList(Board model) {
		return sqlSession.selectList("Board.selectBoardList", model);
	}

	@Override
	public Board selectBoardView(Board model) {
		return sqlSession.selectOne("Board.selectBoardView", model);
	}

	@Override
	public Board selectSaveData() {
		return sqlSession.selectOne("Board.selectSaveData");
	}

	@Override
	public void insertBoardWrite(Board model) {
		sqlSession.insert("Board.insertBoardWrite", model);
	}

	@Override
	public void updateBoardWrite(Board model) {
		sqlSession.update("Board.updateBoardWrite", model);
	}

	@Override
	public void deleteBoardView(Board model) {
		sqlSession.update("Board.deleteBoardView", model);
	}

	@Override
	public void updateReadCount(Board model) {
		sqlSession.update("Board.updateReadCount", model);
	}
}
