package common.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import common.CommonPower;
import dao.ProjectDao;
import dto.ProjectDto;

public class MemberList implements CommonPower {

	@Override
	public void Execute(HttpServletRequest request) {
		ProjectDao dao = new ProjectDao();
		List<ProjectDto> list1 = dao.getMemberList();
		request.setAttribute("list", list1);

	}

}
