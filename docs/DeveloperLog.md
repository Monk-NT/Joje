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

## 2017-06-30
Finally continue working on this. Changed regex lib from `regex-compat` with `regex-pcre-builtin` since compat is POSIX
compliant and that is not working for me. Now I have to rewrite the entire regex part.

I should maybe try removing regexes completely...

### Update 1
Ok. I actually don't need regex, at least for path search. I can just split the string by `'/'` and then replace the
first string with `":var/"` and just continue. Why did I think using regexes was a good idea in the first place
I don't understand.

Also, for path creation, I can skip the regex, I think, using something similar to the idea I just described for path
search.

I think this will be my most rewritten project. I _'pivoted'_ it so many times...

## 2017-07-02
Ok. Non-regex solution works better but still kinda craps itself if some _corner cases_ are applied. Non the matter,
will fix that later.

## 2017-07-03
Adding tests. First, I have to choose what will I use. As far as I understand, I can choose between QuickCheck, HUnit
and HSpec. It seems that HUnit and HSpec are related, HSpec being built on top of HUnit. So, then the real difference is
between verbosity of one and other, and between QuickCheck approach versus other two. QuickCheck is a _'library for
random testing of program properties'_ to quote official documentation. That means that you _describe_ what the function
does and then QuickCheck uses random input data to test it. It is an interesting approach, but alas, I will not use it,
at least not for now.

Furthermore, HSpec can use QuickCheck, or at least parts of it, meaning that HSpec is probably best from both worlds. So,
it's decided, I'll use Hspec. Now, only thing I have to do is create the Spec.hs file...

### Update 1
So I added my simple first `Spec.hs` (actually, filename is `JojeSpec.hs`, but who cares). This simple script tests
`findLongestRoute` function for now. Should redo the test, so it doesn't expose the internal workings of the library.
Don't know what to think about the whole `Web.Joje.Internal` module I exposed. I see some of the bigger and better libraries
doing it, but somehow, that seems wrong to me. Library API should do what library API says it does, no need for Internal
workings to be shown. Then again... I don't know, maybe some parts should be exposed. Maybe some "goodness" is hidden
in internal workings. I'll try to grok it to its fullness.

## 2017-07-04
Never ever let atom rename a file. Git gets... confused.

## 2017-10-12
I think I'm going about this the wrong way.  Or maybe too much time has passed and I can't remember. I don't think I need this:

```Haskell
  findLongestRoute rt "/joje/123/handler/" `shouldBe` ("/joje/:var/handler/" :: ByteString)
  findLongestRoute rt "/joje/123/handler/123/" `shouldBe` ("/joje/:var/handler/:var/" :: ByteString)
```

I think that is a completely wrong way of looking at things. I just complicated my life.

###Update 1
I think I need some time to grok this.

##2017-11-15
Something tells me that a new full rewrite is coming soon. Was watching servant. I like some ideas in it. I also like
some ideas in scotty. I should combine them :).
