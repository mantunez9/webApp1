package isdcm.webapp.controller;

import isdcm.webapp.model.User;
import isdcm.webapp.model.dao.UserDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Optional;

@WebServlet(name = "userLoginServlet", value = "/login")
public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {

        try {

            HttpSession session = req.getSession(false);

            if (session != null && session.getAttribute("user") != null) {
                resp.sendRedirect("/video");
            }

            req.getRequestDispatcher("/login.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        try {

            String web;
            String nickName = req.getParameter("nickName");
            String pass = req.getParameter("password");

            UserDAO userDao = new UserDAO();

            Optional<User> userOptional = userDao.findByNickName(nickName);

            if (userOptional.isPresent() && userOptional.get().getPassword().equals(pass)) {

                HttpSession session = req.getSession();
                session.setAttribute("user", userOptional.get());
                web = "/video";
                resp.sendRedirect(web);

            } else {

                String message = "Incorrect username or password";
                req.setAttribute("message", message);
                web = "/login";
                req.getRequestDispatcher(web).forward(req, resp);

            }


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
