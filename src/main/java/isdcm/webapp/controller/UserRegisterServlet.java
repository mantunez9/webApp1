package isdcm.webapp.controller;

import isdcm.webapp.model.User;
import isdcm.webapp.model.dao.UserDAO;
import isdcm.webapp.model.vo.ResultActionsCRUD;

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

            HttpSession session = req.getSession(false);

            if (session != null && session.getAttribute("user") != null) {
                resp.sendRedirect("/video");
            }

            req.getRequestDispatcher("/registroUsu.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        try {

            UserDAO userDao = new UserDAO();

            String nickName = req.getParameter("nickName");
            String password = req.getParameter("password");
            String name = req.getParameter("name");
            String surnames = req.getParameter("surnames");
            String email = req.getParameter("email");

            Optional<User> userByNickNameOptional = userDao.findByNickName(nickName);
            Optional<User> userByEmailOptional = userDao.findByEmail(email);

            if (!userByNickNameOptional.isPresent() && !userByEmailOptional.isPresent()) {

                User user = new User();
                user.setSurnames(surnames);
                user.setNickName(nickName);
                user.setPassword(password);
                user.setName(name);
                user.setEmail(email);

                ResultActionsCRUD resultActionsCRUD = userDao.createUser(user);

                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                if (resultActionsCRUD.isOk()) {

                    resp.sendRedirect("/video");

                } else {

                    //ERROR!
                    req.setAttribute("error", resultActionsCRUD.getMissatge());
                    req.getRequestDispatcher("/error.jsp").forward(req, resp);

                }

            }

            String message = "Username already exist";
            if (userByEmailOptional.isPresent())
                message = "Email already registered";
            req.setAttribute("message", message);
            req.getRequestDispatcher("/registroUsu.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
