module ServantHrr.Data.Common
  ( Name
  , BookId
  , Handler
  ) where

import           Control.Monad.Logger       (LoggingT)
import           Control.Monad.Trans.Reader (ReaderT)
import           Data.Int                   (Int32)
import           Data.Pool                  (Pool)
import           Database.HDBC.PostgreSQL   (Connection)
import qualified Servant

type Name = String

type BookId = Int32

type Handler = LoggingT (ReaderT (Pool Connection) Servant.Handler)
