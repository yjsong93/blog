package springController;


import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import java.util.Set;
import java.util.TreeSet;


import javax.servlet.http.HttpSession;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;
 
import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
@Controller
public class HelloController {
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public HelloController() throws IOException {
//		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
//		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
//		reader.close();
	 
	}

	 
     
	  
			
			@RequestMapping("/hi.do")
			public ModelAndView form12(@ModelAttribute String dto,HttpSession session) throws SQLException{
				ModelAndView m=new ModelAndView();
				//String id=(String)session.getAttribute("id");
			
				
				
				m.setViewName("/project/NewFile.jsp");
			//.addObject("id",id);
				
				return m;
				
			}
		

	
}
