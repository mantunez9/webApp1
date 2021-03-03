package isdcm.webapp.model;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.transaction.Transactional;
import java.util.Optional;

public class UserDAO {

    private static final String PERSISTENCE_UNIT_NAME = "webApp1";
    EntityManagerFactory emFactoryObj = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
    EntityManager entityMgr = emFactoryObj.createEntityManager();

    public Optional<User> findByNickName(String nickName) {

        try {
            return Optional.of(
                    entityMgr
                            .createQuery("SELECT u FROM User u where u.nickName = :nickName", User.class)
                            .setParameter("nickName", nickName)
                            .getSingleResult()
            );
        } catch (NoResultException exception) {
            return Optional.empty();
        }

    }

    @Transactional
    public void createUser(User user) {

        entityMgr.getTransaction().begin();
        entityMgr.persist(user);
        entityMgr.getTransaction().commit();
        entityMgr.clear();

    }

}
