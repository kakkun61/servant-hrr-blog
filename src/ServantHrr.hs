module ServantHrr
  ( makeApp
  ) where

import           Control.Monad.Logger       (runStdoutLoggingT)
import           Control.Monad.Trans.Reader (ReaderT (runReaderT))
import           Data.Pool                  (Pool, createPool)
import           Database.HDBC              (disconnect)
import           Database.HDBC.PostgreSQL   (Connection)
import           Network.Wai                (Application)
import           Servant                    ((:<|>) ((:<|>)), Proxy (Proxy), Server, hoistServer, serve)

import           ServantHrr.Api             (Api)
import           ServantHrr.DataSource      (connect)
import qualified ServantHrr.Handler.Book    as Book
import qualified ServantHrr.Handler.Books   as Books
import qualified ServantHrr.Handler.Index   as Index

makeApp :: IO Application
makeApp = do
  pool <-
    createPool
    connect
    disconnect
    1 -- stripes
    1 -- time for keeping open
    5 -- resource per stripe
  pure $ serve api $ server pool

api :: Proxy Api
api = Proxy

server :: Pool Connection -> Server Api
server pool =
  hoistServer
    api
    (flip runReaderT pool . runStdoutLoggingT)
    $ Index.handler :<|>
      Books.handler :<|>
      Book.handler
