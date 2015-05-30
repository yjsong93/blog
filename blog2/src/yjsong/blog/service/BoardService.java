package yjsong.blog.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import yjsong.blog.dao.BoardDAO;
import yjsong.blog.model.Board;


@Service
public class BoardService {

	@Autowired private BoardDAO boardDAO;
	
	public List<Board> selectBoardList(Board model) {
		return boardDAO.selectBoardList(model);
	}

	public Board selectBoardView(Board model) {
		return boardDAO.selectBoardView(model);
	}

	public Board selectSaveData() {
		return boardDAO.selectSaveData();
	}

	public void insertBoardWrite(Board model) {
		boardDAO.insertBoardWrite(model);
	}

	public void updateBoardWrite(Board model) {
		boardDAO.updateBoardWrite(model);
	}

	public void deleteBoardView(Board model) {
		boardDAO.deleteBoardView(model);
	}

	public void updateReadCount(Board model) {
		boardDAO.updateReadCount(model);
	}
	
	
}
