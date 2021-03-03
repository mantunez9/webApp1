package isdcm.webapp.controller;

import isdcm.webapp.model.User;
import isdcm.webapp.model.UserDAO;
import isdcm.webapp.model.VideoDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Optional;

@WebServlet(name = "userRegisterServlet", value = "/register")
public class UserRegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {

        try {
            req.getRequestDispatcher("/registroUsu.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        try {

            UserDAO userDao = new UserDAO();
            VideoDAO videoDAO = new VideoDAO();

            String nickName = req.getParameter("nickName");
            String password = req.getParameter("password");
            String name = req.getParameter("name");
            String surnames = req.getParameter("surnames");
            String email = req.getParameter("email");

            Optional<User> userOptional = userDao.findByNickName(nickName);

            if (!userOptional.isPresent()) {

                User user = new User();
                user.setSurnames(surnames);
                user.setNickName(nickName);
                user.setPassword(password);
                user.setName(name);
                user.setEmail(email);

                userDao.createUser(user);
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                req.setAttribute("videos", videoDAO.findAllVideo());
                req.getRequestDispatcher("/registroVid.jsp").forward(req, resp);

            }

            String message = "El nombre de usuario ya existe";
            req.setAttribute("message", message);
            req.getRequestDispatcher("/registroUsu.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
