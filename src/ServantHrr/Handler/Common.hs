module ServantHrr.Handler.Common
  ( runQuery'
  ) where

import           Control.Monad.IO.Class     (liftIO)
import           Control.Monad.Trans.Class  (lift)
import           Control.Monad.Trans.Reader (ask)
import           Data.Pool                  (withResource)
import           Database.HDBC              (SqlValue)
import qualified Database.HDBC.Record       as R
import           Database.Record            (FromSql, ToSql)
import           Database.Relational.Type   (Query)

import           ServantHrr.Data.Common     (Handler)

runQuery'
  :: (ToSql SqlValue p, FromSql SqlValue a)
  => Query p a
  -> p
  -> Handler [a]
runQuery' q p = do
  pool <- lift ask
  withResource pool $ \conn ->
    liftIO $ R.runQuery' conn q p
