module ServantHrr.Handler.Book
  ( handler
  ) where

import           Data.Functor.ProductIsomorphic ((|$|), (|*|))
import           Database.Relational            ((!), (.=.))
import qualified Database.Relational            as R
import           Servant                        (err404, err500, throwError)

import           ServantHrr.Data.Book           (Result (Result))
import           ServantHrr.Data.Common         (BookId, Handler)
import qualified ServantHrr.Data.Relation.Book  as Book
import           ServantHrr.Handler.Common      (runQuery')

handler :: BookId -> Handler Result
handler bookId = do
  records <-
    flip runQuery' () $ R.relationalQuery $ R.relation $ do
      b <- R.query Book.book
      R.wheres $ b ! Book.id' .=. R.value bookId
      pure $ Result |$| b ! Book.name' |*| b ! Book.auther'
  case records of
    [r] -> pure r
    []  -> throwError err404
    _   -> throwError err500
