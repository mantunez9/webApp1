package isdcm.webapp.model.dao;

import com.fasterxml.jackson.databind.ObjectMapper;
import isdcm.webapp.model.Video;
import isdcm.webapp.model.VideoRestResponse;
import isdcm.webapp.model.vo.ResultActionsCRUD;
import isdcm.webapp.soapserver.ws.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class VideoDAO {

    private static final String PERSISTENCE_UNIT_NAME = "webApp1";

    EntityManagerFactory emFactoryObj = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
    EntityManager entityMgr = emFactoryObj.createEntityManager();
    ObjectMapper objectMapper = new ObjectMapper();

    public ResultActionsCRUD createVideo(Video video) {

        try {

            entityMgr.getTransaction().begin();
            entityMgr.persist(video);
            entityMgr.getTransaction().commit();
            entityMgr.clear();

            return ResultActionsCRUD
                    .builder()
                    .isOk(true)
                    .build();

        } catch (Exception e) {

            return ResultActionsCRUD
                    .builder()
                    .missatge(e.getMessage())
                    .isOk(false)
                    .build();

        }

    }

    public VideoRestResponse updateReproductions(Integer id) throws IOException {

        URL url = new URL("http://localhost:9000/video/" + id);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);
        connection.setInstanceFollowRedirects(false);
        connection.setRequestMethod("PUT");
        connection.setRequestProperty("Content-Type", "application/xml");

        if (connection.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP Error code : "
                    + connection.getResponseCode());
        }

        VideoRestResponse restResponse = objectMapper.readValue(connection.getInputStream(), VideoRestResponse.class);
        connection.disconnect();
        return restResponse;

    }

    public List<VideoDTO> findAllVideo() {

        VideoPortService ss = new VideoPortService();
        VideoPort port = ss.getVideoPortSoap11();
        ObjectFactory objectFactory = new ObjectFactory();
        return port.findAllVideo(objectFactory.createFindAllVideoRequest()).getReturn();

    }

    public List<VideoDTO> findByDate(String date) {

        VideoPortService ss = new VideoPortService();
        VideoPort port = ss.getVideoPortSoap11();
        ObjectFactory objectFactory = new ObjectFactory();
        FindVideoByDateRequest request = objectFactory.createFindVideoByDateRequest();

        String[] splited = date.split("-");
        request.setYear(splited[0]);

        if (!splited[1].equals("XX")) {
            request.setMonth(splited[1]);
        }

        if (!splited[2].equals("XX")) {
            request.setDay(splited[2]);
        }

        return port.findVideoByDate(request).getReturn();

    }

    public List<VideoDTO> findByTitle(String title) {

        VideoPortService ss = new VideoPortService();
        VideoPort port = ss.getVideoPortSoap11();
        ObjectFactory objectFactory = new ObjectFactory();
        FindVideoByTittleRequest request = objectFactory.createFindVideoByTittleRequest();
        request.setTittle(title);
        return port.findVideoByTittle(request).getReturn();

    }

    public List<VideoDTO> findByAuthor(String author) {

        VideoPortService ss = new VideoPortService();
        VideoPort port = ss.getVideoPortSoap11();
        ObjectFactory objectFactory = new ObjectFactory();
        FindVideoByAuthorRequest request = objectFactory.createFindVideoByAuthorRequest();
        request.setAuthor(author);
        return port.findVideoByAuthor(request).getReturn();

    }

}
