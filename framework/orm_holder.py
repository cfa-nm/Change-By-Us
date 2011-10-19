from lib import web
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

from framework.config import Config

class OrmHolder (object):

    @property
    def orm(self):
        """
        Gets the SQLAlchemy ORM session, which is stored on the thread-global
        ``web.ctx`` object.  The object is wrapped so that we can more easily stub
        it when necessary.
        """
        if self.is_invalid:
            config = self.get_db_config()
            engine = self.get_db_engine(config)
            web.ctx.orm = self.get_orm(engine)
        return web.ctx.orm

    @property
    def is_invalid(self):
        """A flag denoting that the ORM session needs to be [re]loaded"""
        return not hasattr(web.ctx, 'orm') or web.ctx.orm is None

    @classmethod
    def invalidate(cls):
        web.ctx.orm = None
    
    def get_db_config(self):
        """Pulls the database config information from the config.yaml file."""
        return Config.get('database')


    def get_db_engine(self, db_config):
        """
        Gets the SQLAlchemy database engine.
        
        The database engine should be a global object in the process.  As such,
        we stick it on ``web.config``.  This way, all the threads share the
        engine and the db connection pool that it maintains.
        
        """
        if not hasattr(web.config, 'db_engine'):
            db_conn_string = '%(dbn)s://%(user)s:%(password)s@%(host)s/%(db)s' % db_config
            web.config.db_engine = create_engine(db_conn_string, echo=True)
        return web.config.db_engine


    def get_orm(self, engine):
        """
        Returns a thread-specific SQLAlchemy ORM session.
        
        The session is a scoped session, which means that it is global within
        a given thread.  New threads, however, will create new sessions.
        
        """
        OrmSession = scoped_session(sessionmaker(bind=engine))
        return OrmSession