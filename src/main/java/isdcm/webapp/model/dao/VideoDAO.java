package isdcm.webapp.model.dao;

import isdcm.webapp.model.Video;
import isdcm.webapp.model.vo.ResultActionsCRUD;

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

    public List<Video> findAllVideo() {
        return entityMgr.createQuery("SELECT v FROM Video v", Video.class).getResultList();
    }

}
