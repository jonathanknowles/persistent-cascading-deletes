{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeFamilies          #-}

import Control.Monad.IO.Class (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH

import qualified Version1 as V1
import qualified Version2 as V2


main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration V1.migrateAll

    insert $ V1.Person "Jane"
    insert $ V1.Person "John"

    liftIO . print =<< get (V1.PersonKey "Jane")
    liftIO . print =<< get (V1.PersonKey "John")

    runMigration V2.migrateAll

