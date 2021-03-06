package isdcm.webapp.model.dao;

import isdcm.webapp.model.User;
import isdcm.webapp.model.vo.ResultActionsCRUD;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
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

    public Optional<User> findByEmail(String email) {

        try {
            return Optional.of(
                    entityMgr
                            .createQuery("SELECT u FROM User u where u.email = :email", User.class)
                            .setParameter("email", email)
                            .getSingleResult()
            );
        } catch (NoResultException exception) {
            return Optional.empty();
        }

    }

    public ResultActionsCRUD createUser(User user) {

        try {

            entityMgr.getTransaction().begin();
            entityMgr.persist(user);
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

}
