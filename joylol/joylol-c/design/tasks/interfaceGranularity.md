# Interface granularity

## Goal

Determine the correct interface granularity.

## Tasks 

## Questions 

### Should every JoyLoL pair be a Lua object?

**Answer** No. During a JoyLoL computation, the churn in JoyLoL objects 
(pairs) will be quite large. If all of these objects are full Lua objects, 
then there will be a large and complex memory/cpu cost to the Lua GC. 

Any particular calculation will tend to be driven by a much smaller JoyLoL 
"program" (description) than the actual (transient) computation itself.

If we have JoyLoL "internal" objects which do not correspond to Lua 
Objects, how to do we garbage collect? 

I suggest we use [generational garbage 
collection](http://wiki.c2.com/?GenerationalGarbageCollection) together 
with immutable objects so that objects in more recent "heaps" can only 
point to older "heaps" and not visa versa. This means that, if the 
individual "heaps" are first class Lua objects, then we can use the 
finalization of the heap object to ["stop and 
copy"](http://wiki.c2.com/?StopAndCopy) live JoyLoL objects into older 
heaps just before the newer heap is reclaimed by the Lua GC. Essentially 
we are letting the Lua GC drive the JoyLoL GC. 

