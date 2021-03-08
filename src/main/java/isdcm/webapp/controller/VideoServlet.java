package isdcm.webapp.controller;

import isdcm.webapp.model.Video;
import isdcm.webapp.model.VideoDAO;

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

            videoDAO.createVideo(video);

            HttpSession session = req.getSession();
            session.setAttribute("user", session.getAttribute("user"));
            req.setAttribute("videos", videoDAO.findAllVideo());
            req.getRequestDispatcher("/registroVid.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
