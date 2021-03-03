package isdcm.webapp.model;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class VideoDAO {

    private static final String PERSISTENCE_UNIT_NAME = "webApp1";
    EntityManagerFactory emFactoryObj = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
    EntityManager entityMgr = emFactoryObj.createEntityManager();

    public void createVideo(Video video) {

        entityMgr.getTransaction().begin();
        entityMgr.persist(video);
        entityMgr.getTransaction().commit();
        entityMgr.clear();

    }

    public List<Video> findAllVideo() {
        return entityMgr.createQuery("SELECT v FROM Video v", Video.class).getResultList();
    }

}
