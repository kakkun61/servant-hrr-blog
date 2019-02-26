module ServantHrr.Data.Book
  ( Result (..)
  ) where

import           Data.Aeson.TH                     (defaultOptions, deriveJSON)
import           Data.Functor.ProductIsomorphic.TH (defineProductConstructor)
import           Database.HDBC                     (SqlValue)
import           Database.HDBC.Schema.PostgreSQL   ()
import           Database.Record.FromSql           (FromSql)
import           GHC.Generics                      (Generic)

import           ServantHrr.Data.Common            (Name)

data Result =
  Result
    { name   :: Name
    , auther :: Name
    }
  deriving (Show, Read, Generic)

$(deriveJSON defaultOptions ''Result)

$(defineProductConstructor ''Result)

instance FromSql SqlValue Result
