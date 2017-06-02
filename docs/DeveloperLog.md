# Developer log
Decided to write a developer log/diary. I want to keep progress of development, and write down ideas/current thinking I
have. Main problem I have most of the time is remembering and maintaining the same direction in implementation/idea.

## 2017-04-13
Not sure if JojeState is the best idea. I have both instincts to leave it, and to completely abandon it. Currently will
not do anything about it, but will instead focus on implementing the full router. Having a good router is
'goodness', meaning if I only implement a good router, I will be happy. Good thing that doesn't involve route handlers,
at least not directly.

I want to create something like Ruby on Rails router. Next step, for today, and probably some other night is to add
support for routes like:

```
    /route1/:var
```
where `:var` represents an ID/variable.

After that, we should probably go to something like

```Haskell
    /route1/:var/some_other_route
```

### Update 1
Ok, it seems to me that we can store routes the same way we are currently storing them. However, what should be added is:
when character `:` is found in the path, whatever expression we have after it (and before the `/` or `EOL`) should be
changed to something uniform so `Data.Trie` works as intended.

For example, if we have routes declared the following way:

```Haskell
    routes :: [Route]
    routes = [ get "/joje"                  getAllJojes
             , get "/joje/:details"         getJojeDetails
             , get "/joje/:singleJoje/size" getJojeDetailsSize ]
```

we should change both `":details"` and `":singleJoje"` to the same expression, e.g. `":var"`.

So, current plan is:

* Add logic to extract each `":expression"`  and change it to `":var"`
* Add logic that _gets_ what is an ID, and what is a regular path. Somehow, I think using the `Data.Trie` and not
implementing my own will not be good enough.

## 2017-04-18
Today I add a new function for preparing routes as described above.

## 2017-04-19
Continuing where I stopped yesterday. Today is adding logic that replaces `ID` with `":var"`. Current plan is to:

 * Check biggest match on `Data.Trie`;
 * If it is a full match, continue with that route.
 * If it is not a full match, replace the part after full match and before `/` with `":var"`.
 * Continue until last `/` is reached.
