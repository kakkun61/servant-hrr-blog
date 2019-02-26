module ServantHrr.Handler.Books
  ( handler
  ) where

import           Data.Functor.ProductIsomorphic ((|$|), (|*|))
import qualified Data.HashMap.Strict            as HashMap
import           Database.Relational            ((!))
import qualified Database.Relational            as R

import           ServantHrr.Data.Books          (Record (Record, name), Result)
import           ServantHrr.Data.Common         (Handler)
import qualified ServantHrr.Data.Relation.Book  as Book
import           ServantHrr.Handler.Common      (runQuery')

handler :: Handler Result
handler = do
  records <-
    flip runQuery' () $ R.relationalQuery $ R.relation $ do
      b <- R.query Book.book
      pure $ Record |$| b ! Book.name' |*| b ! Book.auther'
  pure $ HashMap.fromList $ (\r@Record { name } -> (name, r)) <$> records
