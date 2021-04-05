package isdcm.webapp.model.dao;

import isdcm.webapp.model.Video;
import isdcm.webapp.model.vo.ResultActionsCRUD;
import isdcm.webapp.soapserver.ws.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class VideoDAO {

    private static final String PERSISTENCE_UNIT_NAME = "webApp1";
    EntityManagerFactory emFactoryObj = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
    EntityManager entityMgr = emFactoryObj.createEntityManager();

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
