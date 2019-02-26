module ServantHrr.DataSource
  ( connect
  , defineTable
  ) where

import           Database.HDBC.PostgreSQL        (Connection, connectPostgreSQL)
import           Database.HDBC.Query.TH          (defineTableFromDB)
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           GHC.Generics                    (Generic)
import           Language.Haskell.TH             (Dec, Q)

import           ServantHrr.DataSource.Secret    (dbPassword, dbUser)

connect :: IO Connection
connect =
  connectPostgreSQL $
    "host=localhost port=5432 user='" ++ dbUser ++ "' password='" ++ dbPassword ++ "' dbname=blog"

defineTable :: String -> Q [Dec]
defineTable tableName =
  defineTableFromDB
    connect
    driverPostgreSQL
    "public"
    tableName
    [''Show, ''Generic]

