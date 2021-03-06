package isdcm.webapp.controller;

import isdcm.webapp.model.Video;
import isdcm.webapp.model.dao.VideoDAO;
import isdcm.webapp.model.vo.ResultActionsCRUD;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "videoServlet", value = "/video")
public class VideoServlet extends HttpServlet {

    static final DateTimeFormatter format = DateTimeFormatter.ISO_LOCAL_DATE;
    static final DateTimeFormatter hora = DateTimeFormatter.ISO_LOCAL_TIME;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {

        try {

            HttpSession session = req.getSession(false);

            if (session != null && session.getAttribute("user") != null) {

                VideoDAO videoDAO = new VideoDAO();
                req.setAttribute("videos", videoDAO.findAllVideo());
                req.getRequestDispatcher("/gestionVid.jsp").forward(req, resp);

            }

            resp.sendRedirect("/login");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {

        try {

            VideoDAO videoDAO = new VideoDAO();

            String titulo = req.getParameter("titulo");
            String autor = req.getParameter("autor");
            String date = req.getParameter("date");
            String duracion = req.getParameter("duracion");
            String reproducciones = req.getParameter("reproducciones");
            String descripcion = req.getParameter("descripcion");
            String formato = req.getParameter("formato");
            String url = req.getParameter("url");

            Video video = new Video();
            video.setAuthor(autor);
            video.setDescription(descripcion);
            video.setCreationDate(LocalDate.parse(date, format).atStartOfDay());
            video.setDuration(LocalTime.parse(duracion, hora));
            video.setReproduction(Integer.parseInt(reproducciones));
            video.setFormat(formato);
            video.setTittle(titulo);
            video.setUrl(url);

            ResultActionsCRUD resultActionsCRUD = videoDAO.createVideo(video);

            if (resultActionsCRUD.isOk()) {

                req.setAttribute("videos", videoDAO.findAllVideo());
                req.getRequestDispatcher("/gestionVid.jsp").forward(req, resp);

            } else {

                //ERROR !
                req.setAttribute("error", resultActionsCRUD.getMissatge());
                req.getRequestDispatcher("/error.jsp").forward(req, resp);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
