---% language=us runpath=texruns:manuals/luametatex
---
---\environment luametatex-style
---
---\startcomponent luametatex-introduction
---
---\startchapter[title=Introduction]
---
---Around 2005 we started the *LuaTeX* project and it took about a decade to reach
---a state where we could consider the experiments to have reached a stable state.
---Pretty soon *LuaTeX* could be used in production, even if some of the interfaces
---evolved, but *ConTeXt* was kept in sync so that was not really a problem. In 2018
---the functionality was more or less frozen. Of course we might add some features
---in due time but nothing fundamental will change as we consider version 1.10 to be
---reasonable feature complete. Among the reasons is that this engine is now used
---outside *ConTeXt* too which means that we cannot simply change much without
---affecting other macro packages.
---
---In reaching that state some decisions were delayed because they didn't go well
---with a current stable version. This is why at the 2018 *ConTeXt* meeting those
---present agreed that we could move on with a follow up tagged \METATEX, a name we
---already had in mind for a while, but as *Lua* is an important component, it got
---expanded to *Lua*METATEX. This follow up is a lightweight companion to *LuaTeX*
---that will be maintained alongside. More about the reasons for this follow up as
---well as the philosophy behind it can be found in the document(s) describing the
---development. During *LuaTeX* development I kept track of what happened in a
---series of documents, parts of which were published as articles in user group
---journals, but all are in the *ConTeXt* distribution. I did the same with the
---development of *Lua*METATEX.
---
---The *Lua*METATEX\ engine is, as said, a follow up on *LuaTeX*. Just as we have
---*ConTeXt* \MKII\ for *PDF*TEX\ and \XETEX, we have \MKIV\ for *LuaTeX* so for
---*Lua*METATEX\ we have yet another version of *ConTeXt*: \LMTX. By freezing \MKII,
---and at some point freezing \MKIV, we can move on as we like, but we try to remain
---downward compatible where possible, something that the user interface makes
---possible. Although *Lua*METATEX\ can be used for production we can also use it for
---possibly drastic experiments but without affecting *LuaTeX*. Because we can easily
---adapt *ConTeXt* to support both, no other macro package will be harmed when (for
---instance) the interface that the engine provides change as part of an experiment
---or cleanup of code. Of course, when we consider something to be useful, it can be
---ported back to *LuaTeX*, but only when there are good reasons for doing so and
---when no compatibility issues are involved.
---
---By now the code of these two related engines differs a lot so in retrospect it
---makes less sense to waste time on porting back. When considering this follow up
---one consideration was that a lean and mean version with an extension mechanism is
---a bit closer to original *TeX*. Of course, because we also have new primitives,
---this is not entirely true. The basic algorithms remain the same but code got
---reshuffled and because we expose internal names of variables and such that is
---reflected in the code base (like more granularity in nodes and token commands).
---Delegating tasks to *Lua* already meant that some aspects, especially system
---dependent ones, no longer made sense and therefore had consequences for the
---interface at the system level. In *Lua*METATEX\ more got delegated, like all file
---related operations. The penalty of moving even more responsibility to *Lua* has
---been compensated by (hopefully) harmless optimization of code in the engine and
---some more core functionality. In the process system dependencies have been
---minimalized.
---
---One side effect of opening up is that what normally is hidden gets exposed and
---this is also true for all kind of codes that are used internally to distinguish
---states and properties of commands, tokens, nodes and more. Especially during
---development these can change but the good news is that they can be queried so on
---can write in code independent ways (in *LuaTeX* node id's are an example). That
---also means more interface related commands, so again lean and mean is not
---applicable here, especially because the detailed control over the text, math,
---font and language subsystems also results in additional commands to query their
---state. And, as the \METAPOST\ got extended, that subsystem is on the one hand
---leaner and meaner because backend code was dropped but on the other hand got a
---larger code base due to opening up the scanner and adding a feedback mechanism.
---
---This manual started as an adaptation of the *LuaTeX* manual and therefore looks
---similar. Some chapters are removed, others were added and the rest has been (and
---will be further) adapted. It also discusses the (main) differences. Some of the
---new primitives or functions that show up in *Lua*METATEX\ might show up in
---*LuaTeX* at some point, but most will be exclusive to *Lua*METATEX, so don't take
---this manual as reference for *LuaTeX* ! As long as we're experimenting we can
---change things at will but as we keep *ConTeXt* \LMTX\ synchronized users normally
---won't notice this. Often you can find examples of usage in *ConTeXt* related
---documents and the source code so that serves a reference too. More detailed
---explanations can be found in documents in the *ConTeXt* distribution, if only
---because there we can present features in the perspective of useability.
---
---For *ConTeXt* users the *Lua*METATEX\ engine will become the default. As
---mentioned, the *ConTeXt* variant for this engine is tagged \LMTX. The pair can be
---used in production, just as with *LuaTeX* and \MKIV. In fact, most users will
---probably not really notice the difference. In some cases there will be a drop in
---performance, due to more work being delegated to *Lua*, but on the average
---performance is much be better, due to some changes below the hood of the engine.
---Memory consumption is also less. The timeline of development is roughly: from
---2018 upto 2020 engine development, 2019 upto 2021 the stepwise code split between
---\MKIV\ and \LMTX, while in 2021 and 2022 we will (mostly) freeze \MKIV\ and
---\LMTX\ will be the default.
---
---As this follow up is closely related to *ConTeXt* development, and because we
---expect stock *LuaTeX* to be used outside the *ConTeXt* proper, there will be no
---special mailing list nor coverage (or pollution) on the *LuaTeX* related mailing
---lists. We have the *ConTeXt* mailing lists for that. In due time the source code
---will be part of the regular *ConTeXt* distribution so that is then also the
---reference implementation: if needed users can compile the binary themselves.
---
---This manual sometimes refers to *LuaTeX*, especially when we talk of features
---common to both engine, as well as to *Lua*METATEX, when it is more specific to the
---follow up. A substantial amount of time went into the transition and more will go
---in, so if you want to complain about *Lua*METATEX, don't bother me. Of course, if
---you really need professional support with these engines (or *TeX* in general),
---you can always consider contacting the developers.
---
---In 2021|--|2022 the math engine was fundamentally overhauled. As a side effect
---some additional features were added. Not all are yet described in the manual:
---some are still experimental and it just takes time and effort to document and the
---priorities are with implementing their usage. Given the long term stability of
---math and them unlikely to be used in other macro packages there is no real urge
---anyway. It is also easier when we have examples of usage. Of course much is
---discussed in `ontarget.pdf` and presentations. The same is true for
---additions to \METAPOST: in due time these will be discussed in the *Lua*METAFUN\
---manual (the official \METAPOST\ manual is maintained elsewhere and should not
---discuss features that are not in the *LuaTeX* version).
---
---\blank[big]
---
---Hans Hagen
---
---\blank[2*big]
---
--- *Lua*METATEX\ Banner   \EQ \cldcontext{LUATEXENGINE} % \cldcontext{LUATEXVERSION} / % \cldcontext{LUATEXFUNCTIONALITY} 
--- *Lua*METATEX\ Version  \EQ \currentdate 
--- *ConTeXt*    Version  \EQ LMTX \contextversion 
--- *LuaTeX*     Team     \EQ Hans Hagen, Hartmut Henkel, Taco Hoekwater, Luigi Scarso 
--- *Lua*METATEX\ Team     \EQ Hans Hagen, Alan Braslau, Mojca Miklavec, Wolfgang Schuster and Mikael Sundqvist 
--- resources and info at \EQ www.contextgarden.net\space\vl\space www.pragma-ade.nl\space\vl\space www.luametatex.org\space\vl\space ntg-context@ntg.nl (http://www.ntg.nl/mailman/listinfo/ntg-context) 
---
---\stopchapter
---
---\stopcomponent
---
---% I'm not that strict with incrementing numbers, but let's occasionally bump the
---% number. Once we're stable it might happen more systematically. For sure I don't
---% want to end up with these 0.99999999 kind of numbers.
---
---% We started with 2.00.0 and kept that number till November 2019, after Alan
---% Braslau and I did the initial beta release at April 1, 2019. After more than a
---% year working on the code base after the *ConTeXt* 2019 meeting a state was
---% reached where nothing fundamental got added for a while. When *LuaTeX* needs a
---% patch, I check the *Lua*METATEX\ code base as the same patch might be needed
---% there. On the other hand, we don't need a strict compatibility, so some patched
---% in *LuaTeX* are not applied here.
---%
---% In November 2019 I started wondering if we should bump the number, just for the
---% sake of showing that there's still some progress. So I decided to bump to 2.01.0
---% then. Just as a reminder for myself: it was the day when I watched Jacob Collier
---% perform *Lua* (feat. MARO) live on YouTube (of course that is not about the
---% language at all, but still a nice coincidence). Just for the fun of it the number
---% bumped a few more times, just to catch up, so end 2019 we're at 2.03.5.
---%
---% Thanks to the patient *ConTeXt* users we were able to apply the new macro scanner
---% and protection mechanisms that were introduced mid 2020.
---