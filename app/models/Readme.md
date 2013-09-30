
Using Sequel semantics, each of the models will be associated with the 
*first* database opened, which *should* be the only one opened by the 
PersistentStore class.  (See Sequel::DATABASES contant).

