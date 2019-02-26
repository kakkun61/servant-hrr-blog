module Main where

import           Network.Wai.Handler.Warp             (run)
import           Network.Wai.Middleware.RequestLogger (logStdoutDev)

import           ServantHrr                           (makeApp)

main :: IO ()
main = do
  app <- makeApp
  run 8080 $ logStdoutDev app

