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

```
    /route1/:var/some_other_route
```
