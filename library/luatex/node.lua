---@meta
---A helper table to better navigate through the documentation using the
---outline: https://github.com/Josef-Friedrich/LuaTeX_Lua-API#navigation-table-_n
_N = {}

---
---The node library contains functions that facilitate dealing with (lists of) nodes and their values.
---They allow you to create, alter, copy, delete, and insert LuaTEX node objects, the core objects
---within the typesetter.
---
---LuaTEX nodes are represented in Lua as userdata with the metadata type `luatex.node.` The
---various parts within a node can be accessed using named fields.
---
---Each node has at least the three fields next, id, and subtype:
---
---* The next field returns the userdata object for the next node in a linked list of nodes, or nil,
---  if there is no next node.
---* The id indicates TEX’s ‘node type’. The field id has a numeric value for efficiency reasons,
---  but some of the library functions also accept a string value instead of id.
---* The subtype is another number. It often gives further information about a node of a particular
---  id, but it is most important when dealing with ‘whatsits’, because they are differentiated
---  solely based on their subtype.
---
---The other available fields depend on the id (and for ‘whatsits’, the subtype) of the node.
---
---Support for unset (alignment) nodes is partial: they can be queried and modified from Lua code,
---but not created.
---
---Nodes can be compared to each other, but: you are actually comparing indices into the node
---memory. This means that equality tests can only be trusted under very limited conditions. It will
---not work correctly in any situation where one of the two nodes has been freed and/or reallocated:
---in that case, there will be false positives.
---
---At the moment, memory management of nodes should still be done explicitly by the user. Nodes
---are not ‘seen’ by the Lua garbage collector, so you have to call the node freeing functions yourself
---when you are no longer in need of a node (list). Nodes form linked lists without reference
---counting, so you have to be careful that when control returns back to LuaTEX itself, you have
---not deleted nodes that are still referenced from a next pointer elsewhere, and that you did not
---create nodes that are referenced more than once. Normally the setters and getters handle this
---for you.
---
---There are statistics available with regards to the allocated node memory, which can be handy
---for tracing.
node = {}

---
---Deep down in TEX a node has a number which is a numeric entry in a memory table. In fact, this
---model, where TEX manages memory is real fast and one of the reasons why plugging in callbacks
---that operate on nodes is quite fast too. Each node gets a number that is in fact an index in the
---memory table and that number often is reported when you print node related information. You
---go from userdata nodes and there numeric references and back with:
---
---```
---<integer> d = node.todirect(<node> n)
---<node> n = node.tonode(<integer> d)
---```
---
---The userdata model is rather robust as it is a virtual interface with some additional checking
---while the more direct access which uses the node numbers directly. However, even with userdata
---you can get into troubles when you free nodes that are no longer allocated or mess up lists. if
---you apply tostring to a node you see its internal (direct) number and id.
node.direct = {}

---
---*LuaTeX* only understands 4 of the 16 direction specifiers of aleph: `TLT` (latin), `TRT` (arabic), `RTT` (cjk), `LTL` (mongolian). All other direction specifiers generate an error. In addition to a keyword driven model we also provide an integer driven one.
---@alias DirectionSpecifier
---| "TLT" # latin
---| "TRT" # arabic
---| "RTT" # cjk
---| "LTL" # mongolian

---
---@alias NodeTypeName
---| 'hlist' # 0
---| 'vlist' # 1
---| 'rule' # 2
---| 'ins' # 3
---| 'mark' # 4
---| 'adjust' # 5
---| 'boundary' # 6
---| 'disc' # 7
---| 'whatsit' # 8
---| 'local_par' # 9
---| 'dir' # 10
---| 'math' # 11
---| 'glue' # 12
---| 'kern' # 13
---| 'penalty' # 14
---| 'unset' # 15
---| 'style' # 16
---| 'choice' # 17
---| 'noad' # 18
---| 'radical' # 19
---| 'fraction' # 20
---| 'accent' # 21
---| 'fence' # 22
---| 'math_char' # 23
---| 'sub_box' # 24
---| 'sub_mlist' # 25
---| 'math_text_char' # 26
---| 'delim' # 27
---| 'margin_kern' # 28
---| 'glyph' # 29
---| 'align_record' # 30
---| 'pseudo_file' # 31
---| 'pseudo_line' # 32
---| 'page_insert' # 33
---| 'split_insert' # 34
---| 'expr_stack' # 35
---| 'nested_list' # 36
---| 'span' # 37
---| 'attribute' # 38
---| 'glue_spec' # 39
---| 'attribute_list' # 40
---| 'temp' # 41
---| 'align_stack' # 42
---| 'movement_stack' # 43
---| 'if_stack' # 44
---| 'unhyphenated' # 45
---| 'hyphenated' # 46
---| 'delta' # 47
---| 'passive' # 48
---| 'shape' # 49

---
---@alias NodeTypeId
---| 0  # hlist
---| 1  # vlist
---| 2  # rule
---| 3  # ins
---| 4  # mark
---| 5  # adjust
---| 6  # boundary
---| 7  # disc
---| 8  # whatsit
---| 9  # local_par
---| 10 # dir
---| 11 # math
---| 12 # glue
---| 13 # kern
---| 14 # penalty
---| 15 # unset
---| 16 # style
---| 17 # choice
---| 18 # noad
---| 19 # radical
---| 20 # fraction
---| 21 # accent
---| 22 # fence
---| 23 # math_char
---| 24 # sub_box
---| 25 # sub_mlist
---| 26 # math_text_char
---| 27 # delim
---| 28 # margin_kern
---| 29 # glyph
---| 30 # align_record
---| 31 # pseudo_file
---| 32 # pseudo_line
---| 33 # page_insert
---| 34 # split_insert
---| 35 # expr_stack
---| 36 # nested_list
---| 37 # span
---| 38 # attribute
---| 39 # glue_spec
---| 40 # attribute_list
---| 41 # temp
---| 42 # align_stack
---| 43 # movement_stack
---| 44 # if_stack
---| 45 # unhyphenated
---| 46 # hyphenated
---| 47 # delta
---| 48 # passive
---| 49 # shape

---
---A number in the range `[0,4]` indicating the glue order.
---@alias GlueOrder 0|1|2|3|4

---
---The calculated glue ratio.
---@alias GlueSet number

---
---@alias GlueSign
---|0 # `normal`,
---|1 # `stretching`,
---|2 # `shrinking`

_N.Node = true

---
---A node that comprise actual typesetting commands. A few fields are
---present in all nodes regardless of their type, these are:
---
--- __Reference:__
---
---* Source code of the `LuaTeX` manual:  [luatex-nodes.tex#L49-L76](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L49-L76)
---@class Node
---@field next Node|nil # the next node in a list, or nil
---@field prev Node|nil # That prev field is always present, but only initialized on explicit request: when the function `node.slide()` is called, it will set up the `prev` fields to be a backwards pointer in the argument node list. By now most of *TeX*'s node processing makes sure that the `prev` nodes are valid but there can be exceptions, especially when the internal magic uses a leading `temp` nodes to temporarily store a state.
---@field id integer # the node’s type (id) number
---@field subtype integer # the node subtype identifier. The `subtype` is sometimes just a dummy entry because not all nodes actually use the `subtype`, but this way you can be sure that all nodes accept it as a valid field name, and that is often handy in node list traversal.
---@field head? Node
---@field attr Node # list of attributes. almost all nodes also have an `attr` field

_N.hlist = 0

---
---@alias HlistNodeSubtype
---|0 # unknown
---|1 # line
---|2 # box
---|3 # indent
---|4 # alignment
---|5 # cell
---|6 # equation
---|7 # equationnumber
---|8 # math
---|9 # mathchar
---|10 # hextensible
---|11 # vextensible
---|12 # hdelimiter
---|13 # vdelimiter
---|14 # overdelimiter
---|15 # underdelimiter
---|16 # numerator
---|17 # denominator
---|18 # limits
---|19 # fraction
---|20 # nucleus
---|21 # sup
---|22 # sub
---|23 # degree
---|24 # scripts
---|25 # over
---|26 # under
---|27 # accent
---|28 # radical

---
---A warning: never assign a node list to the `head` field unless you are sure
---its internal link structure is correct, otherwise an error may result.
---
---Note: the field name `head` and `list` are both valid. Sometimes it
---makes more sense to refer to a list by `head`, sometimes `list` makes
---more sense.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L78-L108](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L78-L108)
---@class HlistNode: Node
---@field subtype HlistNodeSubtype
---@field width number # the width of the box
---@field height number # the height of the box
---@field depth number # the depth of the box
---@field shift number # a displacement perpendicular to the character progression direction
---@field glue_order GlueOrder
---@field glue_set GlueSet
---@field glue_sign GlueSign
---@field head Node # the first node of the body of this list
---@field list Node # the first node of the body of this list
---@field dir DirectionSpecifier

_N.vlist = 1

---
---@alias VlistNodeSubtype
---|0 # unknown
---|4 # alignment
---|5 # cell

---
---@class VlistNode: Node

_N.rule = 2

---
---@alias RuleNodeSubtype
---|0 # normal
---|1 # box
---|2 # image
---|3 # empty
---|4 # user
---|5 # over
---|6 # under,
---|7 # fraction
---|8 # radical
---|9 # outline

---
---Contrary to traditional *TeX*, *LuaTeX* has more `rule` subtypes because we
---also use rules to store reuseable objects and images. User nodes are invisible
---and can be intercepted by a callback.
---
---The `left` and `right` keys are somewhat special (and experimental).
---When rules are auto adapting to the surrounding box width you can enforce a shift
---to the right by setting `left`. The value is also subtracted from the width
---which can be a value set by the engine itself and is not entirely under user
---control. The `right` is also subtracted from the width. It all happens in
---the backend so these are not affecting the calculations in the frontend (actually
---the auto settings also happen in the backend). For a vertical rule `left`
---affects the height and `right` affects the depth. There is no matching
---interface at the *TeX* end (although we can have more keywords for rules it would
---complicate matters and introduce a speed penalty.) However, you can just
---construct a rule node with *Lua* and write it to the *TeX* input. The `outline` subtype is just a convenient variant and the `transform` field
---specifies the width of the outline.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L119-L157](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L119-L157)
---@class RuleNode: Node
---@field subtype RuleNodeSubtype
---@field width integer # the width of the rule where the special value −1073741824 is used for ‘running’ glue dimensions
---@field height integer # the height of the rule (can be negative)
---@field depth integer # the depth of the rule (can be negative)
---@field left integer # shift at the left end (also subtracted from width)
---@field right integer # (subtracted from width)
---@field dir DirectionSpecifier the direction of this rule
---@field index integer # an optional index that can be referred too
---@field transform integer # an private variable (also used to specify outline width)

_N.ins = 3

---
---@class InsNode: Node
---@field subtype number # the insertion class
---@field attr Node # list of attributes
---@field cost number # the penalty associated with this insert
---@field height number # height of the insert
---@field depth number # depth of the insert
---@field head Node # the first node of the body of this insert
---@field list Node # the first node of the body of this insert

_N.mark = 4

---
---@class MarkNode: Node
---@field subtype number # unused
---@field attr Node # list of attributes
---@field class number # the mark class
---@field mark table # a table representing a token list

_N.adjust = 5

---
---@alias AdjustNodeSubtype
---|0 # normal
---|1 # pre

---
---@class AdjustNode: Node
---@field subtype AdjustNodeSubtype
---@field attr Node # list of attributes
---@field head Node # adjusted material
---@field list Node # adjusted material

_N.disc = 7

---
---@alias DiscNodeSubtype
---|0 # discretionary
---|1 # explicit
---|2 # automatic
---|3 # regular
---|4 # first
---|5 # second

---
---@class DiscNode: Node
---@field subtype DiscNodeSubtype
---@field attr Node # list of attributes
---@field pre Node # pointer to the pre-break text
---@field post Node # pointer to the post-break text
---@field replace Node # pointer to the no-break text
---@field penalty number # the penalty associated with the break, normally `hyphenpenalty` or `exhyphenpenalty`

_N.math = 11

---
---@alias MathNodeSubtype
---|0 # beginmath
---|1 # endmath

---
---@class MathNode: Node
---@field subtype MathNodeSubtype
---@field attr Node # list of attributes
---@field surround number # width of the `mathsurround` kern

_N.glue_spec = 39

---
---Skips are about the only type of data objects in traditional *TeX* that are not a
---simple value. They are inserted when *TeX* sees a space in the text flow but also
---by `hskip` and `vskip`. The structure that represents the glue
---components of a skip is called a `glue_spec`.
---
---The effective width of some glue subtypes depends on the stretch or shrink needed
---to make the encapsulating box fit its dimensions. For instance, in a paragraph
---lines normally have glue representing spaces and these stretch or shrink to make
---the content fit in the available space. The `effective_glue` function that
---takes a glue node and a parent (hlist or vlist) returns the effective width of
---that glue item. When you pass `true` as third argument the value will be
---rounded.
---
---A `glue_spec` node is a special kind of node that is used for storing a set
---of glue values in registers. Originally they were also used to store properties
---of glue nodes (using a system of reference counts) but we now keep these
---properties in the glue nodes themselves, which gives a cleaner interface to *Lua*.
---
---The indirect spec approach was in fact an optimization in the original *TeX*
---code. First of all it can save quite some memory because all these spaces that
---become glue now share the same specification (only the reference count is
---incremented), and zero testing is also a bit faster because only the pointer has
---to be checked (this is no longer true for engines that implement for instance
---protrusion where we really need to ensure that zero is zero when we test for
---bounds). Another side effect is that glue specifications are read-only, so in
---the end copies need to be made when they are used from *Lua* (each assignment to
---a field can result in a new copy). So in the end the advantages of sharing are
---not that high (and nowadays memory is less an issue, also given that a glue node
---is only a few memory words larger than a spec).
---
---In addition there are the `width`, `stretch` `stretch_order`,
---`shrink`, and `shrink_order` fields. Note that we use the key `width` in both horizontal and vertical glue. This suits the *TeX* internals well
---so we decided to stick to that naming.
---@class GlueSpecNode: Node
---@field width          integer # the horizontal or vertical displacement
---@field stretch        integer # extra (positive) displacement or stretch amount
---@field stretch_order  integer # factor applied to stretch amount
---@field shrink         integer # extra (negative) displacement or shrink amount
---@field shrink_order   integer # factor applied to shrink amount

_N.glue = 12

---
---@alias GlueNodeSubtype
---|0 # userskip
---|1 # lineskip
---|2 # baselineskip
---|3 # parskip
---|4 # abovedisplayskip
---|5 # belowdisplayskip
---|6 # abovedisplayshortskip
---|7 # belowdisplayshortskip
---|8 # leftskip
---|9 # rightskip
---|10 # topskip
---|11 # splittopskip
---|12 # tabskip
---|13 # spaceskip
---|14 # xspaceskip
---|15 # parfillskip
---|16 # mathskip
---|17 # thinmuskip
---|18 # medmuskip
---|19 # thickmuskip
---|98 # conditionalmathskip
---|99 # muglue
---|100 # leaders
---|101 # cleaders
---|102 # xleaders
---|103 # gleaders

---
---A regular word space also results in a `spaceskip` subtype (this used to be
---a `userskip` with subtype zero).
---
---@class GlueNode: Node
---@field subtype GlueNodeSubtype
---@field leader Node # pointer to a box or rule for leaders
---@field width integer # the horizontal or vertical displacement
---@field stretch integer # extra (positive) displacement or stretch amount
---@field stretch_order integer # factor applied to stretch amount
---@field shrink integer # extra (negative) displacement or shrink amount
---@field shrink_order integer # factor applied to shrink amount

---
---The effective_glue function that takes a glue node and a parent (hlist or vlist) returns the
---effective width of that glue item. When you pass true as third argument the value will be
---rounded.
---
---@param glue GlyphNode
---@param parent HlistNode|VlistNode
---@param round? boolean
---
---@return integer
function node.effective_glue(glue, parent, round) end
node.direct.effective_glue = node.effective_glue

_N.kern = 13

---
---@alias KernNodeSubtype
---|0 # fontkern
---|1 # userkern
---|2 # accentkern
---|3 # italiccorrection

---
---The `kern` command creates such nodes but for instance the font and math
---machinery can also add them.
---
---@class KernNode: Node
---@field subtype KernNodeSubtype
---@field kern integer # Fixed horizontal or vertical advance (in scaled points)

_N.penalty = 14

---
---@alias PenaltyNodeSubtype
---|0 # userpenalty
---|1 # linebreakpenalty
---|2 # linepenalty
---|3 # wordpenalty
---|4 # finalpenalty
---|5 # noadpenalty
---|6 # beforedisplaypenalty
---|7 # afterdisplaypenalty
---|8 # equationnumberpenalty

---
---@class PenaltyNode: Node
---@field subtype PenaltyNodeSubtype
---@field attr Node # list of attributes
---@field penalty number # the penalty value

_N.glyph = 29

---
---@alias GlyphNodeSubtype
---|1 # ligature
---|2 # ghost
---|3 # left
---|4 # right

---
---@class GlyphNode: Node
---@field subtype number # bit field
---@field attr Node # list of attributes
---@field char number # the character index in the font
---@field font number # the font identifier
---@field lang number # the language identifier
---@field left number # the frozen `\lefthyphenmnin` value
---@field right number # the frozen `\righthyphenmnin` value
---@field uchyph boolean # the frozen `uchyph` value
---@field components Node # pointer to ligature components
---@field xoffset number # a virtual displacement in horizontal direction
---@field yoffset number # a virtual displacement in vertical direction
---@field width number # the (original) width of the character
---@field height number # the (original) height of the character
---@field depth number # the (original) depth of the character
---@field expansion_factor number # the to be applied expansion_factor
---@field data number # a general purpose field for users (we had room for it)

---
---The `uses_font` helpers takes a node and font id and returns `true` when a glyph or disc node references that font.
---
---@param n Node
---@param font integer
---
---@return boolean
function node.uses_font(n, font) end
node.direct.uses_font = node.uses_font

_N.boundary = 6

---
---@alias BoundaryNodeSubtype
---|0 # cancel
---|1 # user
---|2 # protrusion
---|3 # word

---
---@class BoundaryNode: Node
---@field subtype BoundaryNodeSubtype
---@field attr Node # list of attributes
---@field value number # values 0--255 are reserved

_N.local_par = 9

---
---@class LocalParNode: Node
---@field attr Node # list of attributes
---@field pen_inter number # local interline penalty (from `localinterlinepenalty`)
---@field pen_broken number # local broken penalty (from `localbrokenpenalty`)
---@field dir string # the direction of this par. see \in [dirnodes]
---@field box_left Node # the `localleftbox`
---@field box_left_width number # width of the `localleftbox`
---@field box_right Node # the `localrightbox`
---@field box_right_width number # width of the `localrightbox`

_N.dir = 10

---
---@class DirNode: Node
---@field attr Node # list of attributes
---@field dir string # the direction (but see below)
---@field level number # nesting level of this direction whatsit

_N.margin_kern = 28

---
---@alias MarginKernNodeSubtype
---|0 # left
---|1 # right

---
---@class MarginKernNode: Node
---@field subtype number # \showsubtypes{marginkern}
---@field attr Node # list of attributes
---@field width number # the advance of the kern
---@field glyph Node # the glyph to be used

_N.math_char = 23

---
---@class MathCharNode: Node
---@field attr Node # list of attributes
---@field char number # the character index
---@field fam number # the family number

_N.math_text_char = 26

---
---@class MathTextCharNode: Node
---@field attr Node # list of attributes
---@field char number # the character index
---@field fam number # the family number

_N.sub_box = 24

---
---@class SubBoxNode: Node
---@field attr Node # list of attributes
---@field head Node # list of nodes
---@field list Node # list of nodes

_N.sub_mlist = 25

---
---@class SubMlistNode: Node
---@field attr Node # list of attributes
---@field head Node # list of nodes
---@field list Node # list of nodes

_N.delim = 27

---
---@class DelimNode: Node
---@field attr Node # list of attributes
---@field small_char number # character index of base character
---@field small_fam number # family number of base character
---@field large_char number # character index of next larger character
---@field large_fam number # family number of next larger character

_N.noad = 18

---
---@alias NoadNodeSubtype
---|0 # ord
---|1 # opdisplaylimits
---|2 # oplimits
---|3 # opnolimits
---|4 # bin
---|5 # rel
---|6 # open
---|7 # close
---|8 # punct
---|9 # inner
---|10 # under
---|11 # over
---|12 # vcenter

---
---@class NoadNode: Node
---@field subtype NoadNodeSubtype
---@field attr Node # list of attributes
---@field nucleus Node # base
---@field sub Node # subscript
---@field sup Node # superscript
---@field options number # bitset of rendering options

_N.accent = 21

---
---@alias AccentNodeSubtype
---|0 # bothflexible
---|1 # fixedtop
---|2 # fixedbottom
---|3 # fixedboth

---
---@class AccentNode: Node
---@field subtype AccentNodeSubtype
---@field nucleus Node # base
---@field sub Node # subscript
---@field sup Node # superscript
---@field accent Node # top accent
---@field bot_accent Node # bottom accent
---@field fraction number # larger step criterium (divided by 1000)

_N.style = 16

---
---@class StyleNode: Node
---@field style string # contains the style

_N.choice = 17

---
---@class ChoiceNode: Node
---@field attr Node # list of attributes
---@field display Node # list of display size alternatives
---@field text Node # list of text size alternatives
---@field script Node # list of scriptsize alternatives
---@field scriptscript Node # list of scriptscriptsize alternatives

_N.radical = 19

---
---@alias RadicalNodeSubtype
---|0 # radical
---|1 # uradical
---|2 # uroot
---|3 # uunderdelimiter
---|4 # uoverdelimiter
---|5 # udelimiterunder
---|6 # udelimiterover

---
---@class RadicalNode: Node
---@field subtype RadicalNodeSubtype
---@field attr Node # list of attributes
---@field nucleus KernNode # base
---@field sub KernNode # subscript
---@field sup KernNode # superscript
---@field left DelimNode
---@field degree KernNode # only set by `Uroot`
---@field width number # required width
---@field options number # bitset of rendering options

_N.fraction = 20

---
---@class FractionNode: Node

_N.fence = 22

---
---@alias FenceNodeSubtype
---|0 # unset
---|1 # left
---|2 # middle
---|3 # right
---|4 # no

---
---@class FenceNode: Node

_N.whatsit = 8

---
---@alias WhatsitTypeId
---| 0  # open
---| 1  # write
---| 2  # close
---| 3  # special
---| 6  # save_pos
---| 7  # late_lua
---| 8  # user_defined
---| 16 # pdf_literal
---| 17 # pdf_refobj
---| 18 # pdf_annot
---| 19 # pdf_start_link
---| 20 # pdf_end_link
---| 21 # pdf_dest
---| 22 # pdf_action
---| 23 # pdf_thread
---| 24 # pdf_start_thread
---| 25 # pdf_end_thread
---| 26 # pdf_thread_data
---| 27 # pdf_link_data
---| 28 # pdf_colorstack
---| 29 # pdf_setmatrix
---| 30 # pdf_save
---| 31 # pdf_restore
---| 32 # pdf_link_state

---
---@alias WhatsitTypeName
---| 'open' # 0
---| 'write' # 1
---| 'close' # 2
---| 'special' # 3
---| 'save_pos' # 6
---| 'late_lua' # 7
---| 'user_defined' # 8
---| 'pdf_literal' # 16
---| 'pdf_refobj' # 17
---| 'pdf_annot' # 18
---| 'pdf_start_link' # 19
---| 'pdf_end_link' # 20
---| 'pdf_dest' # 21
---| 'pdf_action' # 22
---| 'pdf_thread' # 23
---| 'pdf_start_thread' # 24
---| 'pdf_end_thread' # 25
---| 'pdf_thread_data' # 26
---| 'pdf_link_data' # 27
---| 'pdf_colorstack' # 28
---| 'pdf_setmatrix' # 29
---| 'pdf_save' # 30
---| 'pdf_restore' # 31
---| 'pdf_link_state' # 32

_N._whatsit = {}

---
---Whatsit nodes come in many subtypes that you can ask for them by running
---`node.whatsits`.
---
---Some of them are generic and independent of the output mode and others are
---specific to the chosen backend: \DVI\ or \PDF. Here we discuss the generic
---font-end nodes nodes.
---
---Source: [luatex-nodes.tex#L781-L797](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L781-L797)
---@class WhatsitNode: Node

_N._whatsit.open = 0

---
---@class OpenWhatsitNode: Node
---@field attr Node # list of attributes
---@field stream integer # *TeX*'s stream id number
---@field name string # file name
---@field ext string # file extension
---@field area string # file area (this may become obsolete)

_N._whatsit.write = 1

---
---@class WriteWhatsitNode: Node
---@field attr Node # list of attributes
---@field stream number # *TeX*'s stream id number
---@field data table # a table representing the token list to be written

_N._whatsit.close = 2

---
---@class CloseWhatsitNode: Node
---@field attr Node # list of attributes
---@field stream number # *TeX*'s stream id number

_N._whatsit.user_defined = 8

---
---User-defined whatsit nodes can only be created and handled from *Lua* code. In
---effect, they are an extension to the extension mechanism. The *LuaTeX* engine
---will simply step over such whatsits without ever looking at the contents.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L833-L864](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L833-L864)
---@class UserDefinedWhatsitNode: WhatsitNode
---@field user_id number # id number
---@field type 97|100|108|110|115|116 # The `type` can have one of six distinct values. The number is the ASCII value if the first character of the type name (so you can use string.byte("l") instead of `108`): 97 “a” list of attributes (a node list), 100 “d” a *Lua* number, 108 “l” a *Lua* value (table, number, boolean, etc), 110 “n” a node list, 115 “s” a *Lua* string, 116 “t” a *Lua* token list in *Lua* table form (a list of triplets).
---@field value number|Node|string|table

_N._whatsit.save_pos = 6

---
---@class SavePosWhatsitNode: WhatsitNode
---@field attr Node # list of attributes

_N._whatsit.late_lua = 7

---
---The difference between `data` and `string` is that on assignment, the
---`data` field is converted to a token list, cf. use as `latelua`. The
---`string` version is treated as a literal string.
---
---When a function is used, it gets called with as first argument the node that triggers
---the call.
---
---@class LateLuaWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field data string # or function  the to be written information stored as *Lua* value
---@field token string # the to be written information stored as token list
---@field name string # the name to use for *Lua* error reporting

_N._whatsit.special = 3

---
---There is only one DVI backend whatsit, and it just flushes its content to the
---output file.
---
---@class SpecialWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field data string # the `special` information

_N._whatsit.pdf_literal = 16

---
---* Corresponding C source code: [texnodes.c#L1082-L1088](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1082-L1088)
---
---@alias PdfLiteralModes
---|0 `origin`
---|1 `page`
---|2 `direct`
---|3 `raw`
---|4 `text`
---|5 `font`
---|6 `special`

---
---The higher the number, the less checking and the more you can run into trouble.
---Especially the `raw` variant can produce bad *PDF* so you can best check
---what you generate.
---
---* Corresponding C source code: [texnodes.c#L1148-L1151](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1148-L1151)
---
---@class PdfLiteralWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field mode PdfLiteralModes # the “mode” setting of this literal
---@field data string # the to be written information stored as *Lua* string
---@field token string # the to be written information stored as token list

_N._whatsit.pdf_refobj = 17

---
---@class PdfRefobjWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field objnum number # the referenced *PDF* object number

_N._whatsit.pdf_annot = 18

---
---@class PdfAnnotWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field width number # the width (not used in calculations)
---@field height number # the height (not used in calculations)
---@field depth number # the depth (not used in calculations)
---@field objnum number # the referenced *PDF* object number
---@field data string # the annotation data

_N._whatsit.pdf_start_link = 19

---
---@class PdfStartLinkWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field width number # the width (not used in calculations)
---@field height number # the height (not used in calculations)
---@field depth number # the depth (not used in calculations)
---@field objnum number # the referenced *PDF* object number
---@field link_attr table # the link attribute token list
---@field action Node # the action to perform

_N._whatsit.pdf_end_link = 20

---
---@class PdfEndLinkWhatsitNode: WhatsitNode
---@field attr Node # list of attributes

_N._whatsit.pdf_dest = 21

---
---@class PdfDestWhatsitNode: WhatsitNode
---@field attr Node # list of attributes
---@field width number # the width (not used in calculations)
---@field height number # the height (not used in calculations)
---@field depth number # the depth (not used in calculations)
---@field named_id number # is the `dest_id` a string value?
---@field dest_id number # the destination id string the destination name
---@field dest_type number # type of destination
---@field xyz_zoom number # the zoom factor (times 1000)
---@field objnum number # the *PDF* object number; for structure references the *PDF* object number of the linked structure element

_N._whatsit.pdf_action = 22
_N._8_6_7_pdf_action = 142

---
---* Corresponding C source code: [texnodes.c#L1090-L1093](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1090-L1093)
---
---@alias PdfActionTypes
---|0 'page'
---|1 'goto'
---|2 'thread'
---|3 'user'

---
---* Corresponding C source code: [texnodes.c#L1095-L1097](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1095-L1097)
---
---@alias PdfWindowTypes
---|0 'notset'
---|1 'new'
---|2 'nonew'

---
---* Corresponding C source code: [texnodes.c#L1104-L1111](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1104-L1111)
---
---@class PdfActionWhatsitNode: WhatsitNode
---@field action_type PdfActionTypes # the kind of action involved
---@field named_id number # are `dest_id` and `struct_id` string values?
---@field action_id number|string # token list reference or string
---@field file string # the target filename
---@field new_window PdfWindowTypes # the window state of the target
---@field struct_id nil|number|string # `nil`: the action does not reference a structure; `number`: id of the referenced structure; `string`: name of the referenced structure destination
---@field data string # the name of the destination

_N._whatsit.pdf_thread = 23

---
------* Corresponding C source code: [texnodes.c#L1185-L1192](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1185-L1192)
---
---@class PdfThreadWhatsitNode
---@field attr Node # list of attributes
---@field width number # the width (not used in calculations)
---@field height number # the height (not used in calculations)
---@field depth number # the depth (not used in calculations)
---@field named_id number # is `tread_id` a string value?
---@field tread_id number # the thread id  string  the thread name
---@field thread_attr number # extra thread information

_N._whatsit.pdf_start_thread = 24

---
---* Corresponding C source code: [texnodes.c#L1176-L1183](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1176-L1183)
---
---@class PdfStartThreadWhatsitNode
---@field attr Node # list of attributes
---@field width number # the width (not used in calculations)
---@field height number # the height (not used in calculations)
---@field depth number # the depth (not used in calculations)
---@field named_id number # is `tread_id` a string value?
---@field tread_id number # the thread id  string  the thread name
---@field thread_attr number # extra thread information

_N._whatsit.pdf_end_thread = 25

---
---* Corresponding C source code: [texnodes.c#L1145-L1146](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/tex/texnodes.c#L1145-L1146)
---
---@class PdfEndThreadWhatsitNode
---@field attr Node # list of attributes

_N._whatsit.pdf_colorstack = 28

---
---From the pdfTeX manual:
---
---`\pdfcolorstack ⟨stack number⟩ ⟨stack action⟩ ⟨general text⟩`
---
---The command operates on the stack of a given number. If ⟨stack action⟩ is `push` keyword, the
---new value provided as ⟨general text⟩ is inserted into the top of the graphic stack and becomes
---the current stack value. If followed by `pop`, the top value is removed from the stack and the
---new top value becomes the current. `set` keyword replaces the current value with ⟨general text⟩
---without changing the stack size. `current` keyword instructs just to use the current stack value
---without modifying the stack at all.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [pdftex-t.tex#L3954-L3980](https://github.com/tex-mirror/pdftex/blob/6fb2352aa70a23ad3830f1434613170be3f3cd74/doc/manual/pdftex-t.tex#L3954-L3980)
---Source: [luatex-nodes.tex#L1097-L1107](https://github.com/TeX-Live/luatex/blob/e1cb50f34dc1451c9c5319dc953305b52a7a96fd/manual/luatex-nodes.tex#L1097-L1107)
---
---@class PdfColorstackWhatsitNode: WhatsitNode
---@field stack integer # The colorstack id number.
---@field command integer # The command to execute. ⟨stack action⟩ → set (0) | push (1) | pop (2) | current (3) [texnodes.c#L3523-L3545](https://github.com/TeX-Live/luatex/blob/6472bd794fea67de09f01e1a89e9b12141be7474/source/texk/web2c/luatexdir/tex/texnodes.c#L3523-L3545)
---@field data string # General text that is placed on top of the stack, for example `1 0 0 rg 1 0 0 RG`. `rg` only colors filled outlines while the stroke color is set with `RG`. From the [PDF Reference, fourth edition](https://opensource.adobe.com/dc-acrobat-sdk-docs/pdfstandards/pdfreference1.5_v6.pdf), 4.5.7 Color Operators Page 251: `gray G`: Set the stroking color space to DeviceGray. `gray` is a number between 0.0 (black) and 1.0 (white). `gray g`: Same as `G`, but for nonstroking operations. `r g b RG`: Set the stroking color space to DeviceRGB. Each operand must be a number between 0.0 (minimum intensity) and 1.0 (maximum intensity). `r g b rg`: same as `RG`, but for nonstroking operations. `c m y k K`: Set the stroking color space to DeviceCMYK. Each operand must be a number between 0.0 (zero concentration) and 1.0 (maximum concentration). `c m y k k`: Same as `K`, but for nonstroking operations.

_N._whatsit.pdf_setmatrix = 29

---
---@class PdfSetmatrixWhatsitNode
---@field attr Node # list of attributes
---@field data string # data

_N._whatsit.pdf_save = 30

---
---@class PdfSaveWhatsitNode
---@field attr Node # list of attributes

_N._whatsit.pdf_restore = 31

---
---@class PdfRestoreWhatsitNode
---@field attr Node # list of attributes

_N._whatsit.pdf_thread_data = 26

_N._whatsit.pdf_link_data = 27

_N._whatsit.pdf_link_state = 32

_N.unset = 15

---
---@class UnsetNode: Node

_N.align_record = 30

---
---@class AlignRecordNode: Node

_N.pseudo_file = 31

---
---@class PseudoFileNode: Node

_N.pseudo_line = 32

---
---@class PseudoLineNode: Node

_N.page_insert = 33

---
---@class PageInsertNode: Node

_N.split_insert = 34

---
---@class Split_InsertNode: Node

_N.expr_stack = 35

---
---@class ExprStackNode: Node

_N.nested_list = 36

---
---@class Nested_ListNode: Node

_N.span = 37

---
---@class SpanNode: Node

_N.attribute = 38

---
---@class AttributeNode: Node

_N.attribute_list = 40

---
---@class AttributeListNode: Node

_N.temp = 41

---
---@class TempNode: Node

_N.align_stack = 42

---
---@class AlignStackNode: Node

_N.movement_stack = 43

---
---@class MovementStackNode: Node

_N.if_stack = 44

---
---@class IfStackNode: Node

_N.unhyphenated = 45

---
---@class UnhyphenatedNode: Node

_N.hyphenated = 46

---
---@class HyphenatedNode: Node

_N.delta = 47

---
---@class DeltaNode: Node

_N.passive = 48

---
---@class PassiveNode: Node

_N.shape = 49

---
---@class ShapeNode: Node

_N._7_2_is_node = 145

---
---This function returns a number (the internal index of the node) if the argument is a userdata
---object of type <node> and false when no node is passed.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1199-L1211](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1199-L1211)
---* Corresponding C source code: [lnodelib.c#L8295-L8303](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8295-L8303)
---
---@param item any
---
---@return false|integer t
function node.is_node(item) end

---
---* Corresponding C source code: [lnodelib.c#L8326-L8343](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8326-L8343)
---
---@param item any
---
---@return false|integer t
function node.direct.is_node(item) end

_N._7_3_types_whatsits = 145

---
---This function returns an array that maps node id numbers to node type strings, providing an
---overview of the possible top-level `id` types.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1218-L1224](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1218-L1224)
---
---@return table
function node.types() end

---
---TEX’s ‘whatsits’ all have the same id. The various subtypes are defined by their subtype fields.
---The function is much like types, except that it provides an array of subtype mappings.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1226-L1233](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1226-L1233)
---
---@return table
function node.whatsits() end

_N._7_4_id = 145

---
---Convert a single type name to its internal numeric representation.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1235-L1244](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1235-L1244)
---
---@param type NodeTypeName
---
---@return NodeTypeId
function node.id(type) end

_N._7_5_type_subtype = 145

---
---Convert an internal numeric node type representation to an external
---node type string.
---
---If the argument is a number, then the type function converts an
---internal numeric representation to an external string representation.
---Otherwise, it will return the string `node` if the object
---represents a node, and `nil` otherwise.
---
---```lua
---node.type(29) -- glyph
---node.type(node.new("glyph")) -- node
---node.type('xxx') -- nil
---```
---
---@param n NodeTypeId # The numeric node type id.
---
---@return NodeTypeName|'node'|nil
function node.type(n) end

---
---Convert a single whatsit name to its internal numeric representation (subtype).
---
---```lua
---node.subtype('pdf_literal') -- 16
---node.subtype('xxx') -- nil
---```
---
---@param whatsit_type_name WhatsitTypeName
---
---@return WhatsitTypeId whatsit_type_id
function node.subtype(whatsit_type_name) end

_N._7_6_fields = 146

---
---Return an array of valid field names for a particular type of
---node.
---
---If you want to get the valid fields for a “whatsit”, you have to
---supply the second argument also. In other cases, any given second argument will
---be silently ignored.
---
---@param id NodeTypeId
---@param subtype? number
---
---@return {[number]: string}
function node.fields(id, subtype) end

_N._7_7_has_field = 146

---
---This function returns a boolean that is only true if `n` is actually a node, and it has the field.
---
---@param n Node
---@param field string
---
---@return boolean t
function node.has_field(n, field) end

---
---This function returns a boolean that is only true if `d` is a valid index number in the memory table of nodes, and it has the field.
---
---* Corresponding C source code: [lnodelib.c#L3041-L3049](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3041-L3049)
---
---@param d integer
---@param field string
---
---@return boolean t
function node.direct.has_field(d, field) end

_N._7_8_new = 146

---
---Create a new node.
---
---All its fields are initialized to
---either zero or `nil` except for `id` and `subtype`. Instead of
---numbers you can also use strings (names). If you create a new `whatsit` node
---the second argument is required. As with all node functions, this function
---creates a node at the *TeX* level.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1299-L1314](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1299-L1314)
---* Corresponding C source code: [lnodelib.c#L2055-L2060](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2055-L2060)
---
---@param id integer|NodeTypeName
---@param subtype? integer|string
---
---@return Node
function node.new(id, subtype) end

---
---Create a new node.
---
---All its fields are initialized to
---either zero or `nil` except for `id` and `subtype`. Instead of
---numbers you can also use strings (names). If you create a new `whatsit` node
---the second argument is required. As with all node functions, this function
---creates a node at the *TeX* level.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1299-L1314](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1299-L1314)
---* Corresponding C source code: [lnodelib.c#L2064-L2069](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2064-L2069)
---
---@param id integer|NodeTypeName
---@param subtype? integer|string
---
---@return integer d
function node.direct.new(id, subtype) end

_N._7_9_free_flush_node_list = 146

---
---Free the *TeX* memory allocated for node `n`.
---
---Be careful: no checks are
---done on whether this node is still pointed to from a register or some `next` field: it is up to you to make sure that the internal data structures
---remain correct.
---
---The `free` function returns the next field of the freed node
---
---* Corresponding C source code: [lnodelib.c#L2073-L2090](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2073-L2090)
---
---@param n Node
---
---@return Node next
function node.direct.free(n) end

---
---Free the *TeX* memory allocated for the specified node.
---
---Be careful: no checks are
---done on whether this node is still pointed to from a register or some `next` field: it is up to you to make sure that the internal data structures
---remain correct.
---
---The `free` function returns the next field of the freed node
---
---* Corresponding C source code: [lnodelib.c#L2094-L2109](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2094-L2109)
---
---@param d integer
---
---@return integer next
function node.direct.free(d) end

---
---Free the *TeX* memory allocated for the specified node.
---and return nothing.
---
---* Corresponding C source code: [lnodelib.c#L2113-L2122](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2113-L2122)
---
---@param n Node
function node.flush_node(n) end

---
---Free the *TeX* memory allocated for the specified node.
---and return nothing.
---
---* Corresponding C source code: [lnodelib.c#L2126-L2133](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2126-L2133)
---
---@param d integer
function node.direct.flush_node(d) end

---
---Free the *TeX* memory allocated for a list of nodes.
---
---Be
---careful: no checks are done on whether any of these nodes is still pointed to
---from a register or some `next` field: it is up to you to make sure that the
---internal data structures remain correct.
---
---* Corresponding C source code: [lnodelib.c#L2137-L2146](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2137-L2146)
---
---@param n Node
function node.flush_list(n) end

---
---Free the *TeX* memory allocated for a list of nodes.
---
---Be
---careful: no checks are done on whether any of these nodes is still pointed to
---from a register or some `next` field: it is up to you to make sure that the
---internal data structures remain correct.
---
---* Corresponding C source code: [lnodelib.c#L2150-L2157](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2150-L2157)
---
---@param d integer
function node.direct.flush_list(d) end

_N._7_10_copy_copy_list = 147

---
---Create a deep copy of node `n`, including all nested lists as in the case
---of a `hlist` or `vlist` node. Only the `next` field is not copied.
---
---* Corresponding C source code: [lnodelib.c#L2476-L2485](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2476-L2485)
---
---@param n Node
---
---@return Node m
function node.copy(n) end

---
---Create a deep copy of node `n`, including all nested lists as in the case
---of a `hlist` or `vlist` node. Only the `next` field is not copied.
---
---* Corresponding C source code: [lnodelib.c#L2489-L2500](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2489-L2500)
---
---@param d integer
---
---@return integer e
function node.direct.copy(d) end

---
---Create a deep copy of the node list that starts at node `n`.
---
---If
---`m` is also given, the copy stops just before node `m`.
---
---Note that you cannot copy attribute lists this way. However, there is normally no
---need to copy attribute lists as when you do assignments to the `attr` field
---or make changes to specific attributes, the needed copying and freeing takes
---place automatically.
---
---* Corresponding C source code: [lnodelib.c#L2440-L2452](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2440-L2452)
---
---@param n Node
---@param m? Node
---
---@return Node m
function node.copy_list(n, m) end

---
---Create a deep copy of the node list that starts at node `d`.
---
---If
---`e` is also given, the copy stops just before node `e`.
---
---Note that you cannot copy attribute lists this way. However, there is normally no
---need to copy attribute lists as when you do assignments to the `attr` field
---or make changes to specific attributes, the needed copying and freeing takes
---place automatically.
---
---* Corresponding C source code: [lnodelib.c#L2456-L2472](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2456-L2472)
---
---@param d integer
---@param e? integer
---
---@return integer e
function node.direct.copy_list(d, e) end

_N._7_11_prev_next = 147

---
---Return the node preceding the given node, or `nil` if
---there is no such node.
---
---* Corresponding C source code: [lnodelib.c#L379-L388](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L379-L388)
---
---@param n Node
---
---@return Node|nil m
function node.prev(n) end

---
---Return the node following the given node, or `nil` if
---there is no such node.
---
---* Corresponding C source code: [lnodelib.c#L390-L399](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L390-L399)
---
---@param n Node
---
---@return Node|nil m
function node.next(n) end

_N._7_12_current_attr = 0

---
---Return the currently active list of attributes, if there is one.
---
---The intended usage of `current_attr` is as follows:
---
---```
---local x1 = node.new("glyph")
---x1.attr = node.current_attr()
---local x2 = node.new("glyph")
---x2.attr = node.current_attr()
---```
---
---or:
---
---```
---local x1 = node.new("glyph")
---local x2 = node.new("glyph")
---local ca = node.current_attr()
---x1.attr = ca
---x2.attr = ca
---```
---
---The attribute lists are ref counted and the assignment takes care of incrementing
---the refcount. You cannot expect the value `ca` to be valid any more when
---you assign attributes (using `tex.setattribute`) or when control has been
---passed back to *TeX*.
---
---Note: this function is somewhat experimental, and it returns the *actual*
---attribute list, not a copy thereof. Therefore, changing any of the attributes in
---the list will change these values for all nodes that have the current attribute
---list assigned to them.
---
---* Corresponding C source code: [lnodelib.c#L6511-L6532](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6511-L6532)
---
---@return Node|nil m
function node.current_attr() end

---
---Return the currently active list of attributes, if there is one.
---
---* Corresponding C source code: [lnodelib.c#L6511-L6532](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6511-L6532)
---
---@return integer|nil e
function node.direct.current_attr() end

_N._7_13_hpack = 0

---
---Create a new `hlist` by packaging the list that begins at node `n` into a horizontal box.
---
---With only a single argument, this box is created using
---the natural width of its components. In the three argument form, `info`
---must be either `additional` or `exactly`, and `width` is the
---additional (`\hbox spread`) or exact (`\hbox to`) width to be used.
---The second return value is the badness of the generated box.
---
---Caveat: there can be unexpected side-effects to this function, like updating
---some of the `marks` and `\inserts`. Also note that the content of
---`h` is the original node list `n`: if you call `node.free(h)`
---you will also free the node list itself, unless you explicitly set the `list` field to `nil` beforehand. And in a similar way, calling `node.free(n)` will invalidate `h` as well!
---
---* Corresponding C source code: [lnodelib.c#L2576-L2619](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2576-L2619)
---
---@param n Node
---@param width? integer
---@param info? string
---@param dir? string
---
---@return Node n
---@return integer badness
function node.hpack(n, width, info, dir) end

---
---Create a new `hlist` by packaging the list that begins at node `d` into a horizontal box.
---
---With only a single argument, this box is created using
---the natural width of its components. In the three argument form, `info`
---must be either `additional` or `exactly`, and `width` is the
---additional (`\hbox spread`) or exact (`\hbox to`) width to be used.
---The second return value is the badness of the generated box.
---
---Caveat: there can be unexpected side-effects to this function, like updating
---some of the `marks` and `\inserts`. Also note that the content of
---`h` is the original node list `n`: if you call `node.free(h)`
---you will also free the node list itself, unless you explicitly set the `list` field to `nil` beforehand. And in a similar way, calling `node.free(n)` will invalidate `h` as well!
---
---* Corresponding C source code: [lnodelib.c#L2576-L2619](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2576-L2619)
---
---@param d integer
---@param width? integer
---@param info? string
---@param dir? string
---
---@return integer d
---@return integer badness
function node.direct.hpack(d, width, info, dir) end

_N._7_14_vpack = 0

---
---Create a new `vlist` by packaging the list that begins at node `n` into a vertical box.
---
---With only a single argument, this box is created using
---the natural height of its components. In the three argument form, `info`
---must be either `additional` or `exactly`, and `w` is the
---
---The second return value is the badness of the generated box. See the description
---of `hpack` for a few memory allocation caveats.
---
---* Corresponding C source code: [lnodelib.c#L2673-L2716](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2673-L2716)
---
---@param n Node
---@param width? integer
---@param info? string
---@param dir? string
---
---@return Node n
---@return integer badness
function node.vpack(n, width, info, dir) end

---
---Create a new `vlist` by packaging the list that begins at node `n` into a vertical box.
---
---With only a single argument, this box is created using
---the natural height of its components. In the three argument form, `info`
---must be either `additional` or `exactly`, and `w` is the
---
---The second return value is the badness of the generated box. See the description
---of `hpack` for a few memory allocation caveats.
---
---* Corresponding C source code: [lnodelib.c#L2720-L2763](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2720-L2763)
---
---@param d integer
---@param width? integer
---@param info? string
---@param dir? string
---
---@return integer d
---@return integer badness
function node.direct.vpack(d, width, info, dir) end

_N._7_15_prepend_prevdepth = 0

---
---Add the interlinespace to a line keeping the baselineskip and lineskip into
---account.
---
---* Corresponding C source code: [lnodelib.c#L8763-L8801](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8763-L8801)
---
---@param n Node # vlist or hlist
---@param prevdepth integer
---
---@return integer new_prevdepth
function node.prepend_prevdepth(n, prevdepth) end

---
---Add the interlinespace to a line keeping the baselineskip and lineskip into
---account.
---
---* Corresponding C source code: [lnodelib.c#L8803-L8840](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8803-L8840)
---
---@param d integer
---@param prevdepth integer
---
---@return integer new_prevdepth
function node.direct.prepend_prevdepth(d, prevdepth) end

_N._7_16_dimensions_rangedimensions = 149

---
---Calculate the natural in-line dimensions of the end of the node list starting
---at node `n`.
---
---The return values are scaled points.
---
---You need to keep in mind that this is one of the few places in *TeX* where floats
---are used, which means that you can get small differences in rounding when you
---compare the width reported by `hpack` with `dimensions`.
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2767-L2812](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2767-L2812)
---
---@param n Node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.dimensions(n, dir) end

---
---Calculate the natural in-line dimensions of the end of the node list starting
---at node `n`.
---
---The return values are scaled points.
---
---You need to keep in mind that this is one of the few places in *TeX* where floats
---are used, which means that you can get small differences in rounding when you
---compare the width reported by `hpack` with `dimensions`.
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2838-L2880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2838-L2880)
---
---@param d integer
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.direct.dimensions(d, dir) end

---
---Calculate the natural in-line dimensions of the node list starting
---at node `n` and terminating just before node `t`.
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2767-L2812](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2767-L2812)
---
---@param n Node
---@param t Node # terminating node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.dimensions(n, t, dir) end

---
---Calculate the natural in-line dimensions of the node list starting
---at node `n` and terminating just before node `t`.
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2838-L2880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2838-L2880)
---
---@param d integer
---@param t integer # terminating node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.direct.dimensions(d, t, dir) end

---
---Calculates the natural in-line dimensions of the end of the node list starting
---at node `n`.
---
---This is an
---alternative format that starts with glue parameters as the first three arguments.
---
---This calling method takes glue settings into account and is especially useful for
---finding the actual width of a sublist of nodes that are already boxed, for
---example in code like this, which prints the width of the space in between the
---`a` and `b` as it would be if `\box0` was used as-is:
---
---```
---\setbox0 = \hbox to 20pt {a b}
---
---\directlua{print (node.dimensions(
---    tex.box[0].glue_set,
---    tex.box[0].glue_sign,
---    tex.box[0].glue_order,
---    tex.box[0].head.next,
---    node.tail(tex.box[0].head)
---)) }
---```
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2838-L2880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2838-L2880)
---
---@param glue_set integer
---@param glue_sign integer
---@param glue_order integer
---@param n Node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.dimensions(glue_set, glue_sign, glue_order, n, dir) end

---
---Calculates the natural in-line dimensions of the end of the node list starting
---at node `n`.
---
---This is an
---alternative format that starts with glue parameters as the first three arguments.
---
---This calling method takes glue settings into account and is especially useful for
---finding the actual width of a sublist of nodes that are already boxed, for
---example in code like this, which prints the width of the space in between the
---`a` and `b` as it would be if `\box0` was used as-is:
---
---```
---\setbox0 = \hbox to 20pt {a b}
---
---\directlua{print (node.dimensions(
---    tex.box[0].glue_set,
---    tex.box[0].glue_sign,
---    tex.box[0].glue_order,
---    tex.box[0].head.next,
---    node.tail(tex.box[0].head)
---)) }
---```
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2838-L2880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2838-L2880)
---
---@param glue_set integer
---@param glue_sign integer
---@param glue_order integer
---@param d integer
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.direct.dimensions(glue_set, glue_sign, glue_order, d, dir) end

---
---Calculate the natural in-line dimensions of the node list starting
---at node `n` and terminating just before node `t`.
---
---This is an
---alternative format that starts with glue parameters as the first three arguments.
------
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2767-L2812](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2767-L2812)
---
---@param glue_set integer
---@param glue_sign integer
---@param glue_order integer
---@param d integer
---@param t integer # terminating node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.dimensions(glue_set, glue_sign, glue_order, d, t, dir) end

---
---Calculate the natural in-line dimensions of the node list starting
---at node `n` and terminating just before node `t`.
---
---This is an
---alternative format that starts with glue parameters as the first three arguments.
---
---[Source: luatex-nodes.tex#L1490-L1546](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1490-L1546)
---* Corresponding C source code: [lnodelib.c#L2838-L2880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2838-L2880)
---
---@param glue_set integer
---@param glue_sign integer
---@param glue_order integer
---@param n Node
---@param t Node # terminating node
---@param dir? DirectionSpecifier
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.direct.dimensions(glue_set, glue_sign, glue_order, n, t, dir) end

---
---Calculate the natural in-line dimensions of the node list `parent` starting
---at node `first` and terminating just before node `last`.
---
---This functions saves a few lookups in comparison to `node.dimensions()` and can be more convenient in some
---cases.
---
---* Corresponding C source code: [lnodelib.c#L2814-L2834](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2814-L2834)
---
---@param parent Node
---@param first Node
---@param last? Node
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.rangedimensions(parent, first, last) end

---
---Calculate the natural in-line dimensions of the node list `parent` starting
---at node `first` and terminating just before node `last`.
---
---This functions saves a few lookups in comparison to `node.dimensions()` and can be more convenient in some
---cases.
---
---* Corresponding C source code: [lnodelib.c#L2882-L2902](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2882-L2902)
---
---@param parent integer
---@param first integer
---@param last? integer
---
---@return integer width # scaled points
---@return integer height # scaled points
---@return integer depth # scaled points
function node.direct.rangedimensions(parent, first, last) end

_N._7_17_mlist_to_hlist = 0

---
---Run the internal `mlist` to `hlist` conversion, converting the math list in
---`n` into the horizontal list `h`.
---
---The interface is exactly the same
---as for the callback `mlist_to_hlist`.
---
---* Corresponding C source code: [lnodelib.c#L2906-L2918](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2906-L2918)
---
---@param n Node
---@param display_type string
---@param penalties boolean
---
---@return Node h
function node.mlist_to_hlist(n, display_type, penalties) end

_N._7_18_slide = 0

---
---see _N._9_9

_N._7_19_tail = 152

---
---Return the last node of the node list that starts at `n`.
---
---* Corresponding C source code: [lnodelib.c#L3262-L3274](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3262-L3274)
---
---@param n Node
---
---@return Node m
function node.tail(n) end

---
---Return the last node of the node list that starts at `d`.
---
---* Corresponding C source code: [lnodelib.c#L3278-L3289](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3278-L3289)
---
---@param d integer
---
---@return integer e
function node.direct.tail(d) end

_N._7_20_length_and_count = 0

---
---Return the number of nodes contained in the node list that starts at `n`.
---
---If `m` is also supplied it stops at `m` instead of at the end of the
---list. The node `m` is not counted.
---
---* Corresponding C source code: [lnodelib.c#L4374-L4386](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4374-L4386)
---
---@param n Node
---@param m? Node
---
---@return integer i
function node.length(n, m) end

---
---Return the number of nodes contained in the node list that starts at `d`.
---
---If `e` is also supplied it stops at `e` instead of at the end of the
---list. The node `d` is not counted.
---
---* Corresponding C source code: [lnodelib.c#L4350-L4360](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4350-L4360)
---
---@param d integer
---@param e? Node
---
---@return integer i
function node.direct.length(d, e) end

---
---Return the number of nodes contained in the node list that starts at `n`
---that have a matching `id` field.
---
---If `m` is also supplied, counting
---stops at `m` instead of at the end of the list. The node `m` is not
---counted. This function also accept string `id`’s.
---
---* Corresponding C source code: [lnodelib.c#L4388-L4401](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4388-L4401)
---
---@param id integer|string
---@param n Node
---@param m? Node
---
---@return integer i
function node.count(id, n, m) end

---
---Return the number of nodes contained in the node list that starts at `d`
---that have a matching `id` field.
---
---If `e` is also supplied, counting
---stops at `e` instead of at the end of the list. The node `d` is not
---counted. This function also accept string `id`’s.
---
---* Corresponding C source code: [lnodelib.c#L4362-L4369](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4362-L4369)
---
---@param id integer|string
---@param d integer
---@param e? Node
---
---@return integer i
function node.direct.count(id, d, e) end

_N._7_21_is_char_and_is_glyph = 0

---
---The subtype of a glyph node signals if the glyph is already turned into a character reference
---or not.
---
---* Corresponding C source code: [lnodelib.c#L3004-L3024](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3004-L3024)
---
---@param n Node
---@param font? integer
---
---@return boolean|integer|nil
---@return integer|nil
function node.is_char(n, font) end

---
---The subtype of a glyph node signals if the glyph is already turned into a character reference
---or not.
---
---* Corresponding C source code: [lnodelib.c#L7572-L7592](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L7572-L7592)
---
---@param d integer
---@param font? integer
---
---@return boolean|integer|nil
---@return integer|nil
function node.direct.is_char(d, font) end

---
---The subtype of a glyph node signals if the glyph is already turned into a character reference
---or not.
---
---* Corresponding C source code: [lnodelib.c#L3026-L3037](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3026-L3037)
---
---@param n Node
---
---@return boolean|integer character
---@return integer font
function node.is_glyph(n) end

---
---The subtype of a glyph node signals if the glyph is already turned into a character reference
---or not.
---
---* Corresponding C source code: [lnodelib.c#L7594-L7605](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L7594-L7605)
---
---@param n Node
---
---@return boolean|integer character
---@return integer font
function node.direct.is_glyph(n) end

_N._7_22_traverse = 0

---
---Return a *Lua* iterator that loops over the node list that starts at `n`.
---
---__Example:__
---
---```lua
---for n in node.traverse(head) do
---   ...
---end
---```
---
---It should be clear from the definition of the function `f` that even though
---it is possible to add or remove nodes from the node list while traversing, you
---have to take great care to make sure all the `next` (and `prev`)
---pointers remain valid.
---
---* Corresponding C source code: [lnodelib.c#L4156-L4168](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4156-L4168)
---
---@param n Node
---
---@return fun(): t: Node, id: integer, subtype: integer
function node.traverse(n) end

---
---Return a *Lua* iterator that loops over the node list that starts at `d`.
---
---__Example:__
---
---```lua
---for d in node.traverse(head) do
---   ...
---end
---```
---
---It should be clear from the definition of the function `f` that even though
---it is possible to add or remove nodes from the node list while traversing, you
---have to take great care to make sure all the `next` (and `prev`)
---pointers remain valid.
---
---* Corresponding C source code: [lnodelib.c#L3937-L3953](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3937-L3953)
---
---@param d integer
---
---@return fun(): t: integer, id: integer, subtype: integer
function node.direct.traverse(d) end

_N._7_23_traverse_id = 0

---
---Return an iterator that loops over all the nodes in the list that starts at
---`n` that have a matching `id` field.
---
---* Corresponding C source code: []()
---
---@param id integer
---@param n Node
---
---@return fun(): t: Node, subtype: integer
function node.traverse_id(id, n) end

---
---Return an iterator that loops over all the nodes in the list that starts at
---`d` that have a matching `id` field.
---
---* Corresponding C source code: [lnodelib.c#L3980-L3995](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3980-L3995)
---
---@param id integer
---@param d integer
---
---@return fun(): t: integer, subtype: integer
function node.direct.traverse_id(id, d) end

_N._7_24_traverse_char_and_traverse_glyph = 0

---
---Loop over the `glyph` nodes in a list.
---
---Only nodes with a subtype less than 256 are seen.
---
---* Corresponding C source code: [lnodelib.c#L4237-L4249](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4237-L4249)
---
---@param n Node
---
---@return fun(): n: Node, font: integer, char: integer
function node.traverse_char(n) end

---
---Loop over the `glyph` nodes in a list.
---
---Only nodes with a subtype less than 256 are seen.
---
---* Corresponding C source code: [lnodelib.c#L4022-L4038](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4022-L4038)
---
---@param d integer
---
---@return fun(): d: integer, font: integer, char: integer
function node.direct.traverse_char(d) end

---
---Loop over a list and return the list and
---filter all glyphs.
---
---* Corresponding C source code: [lnodelib.c#L4277-L4289](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4277-L4289)
---
---@param n Node
---
---@return fun(): n: Node, font: integer, char: integer
function node.traverse_glyph(n) end

---
---Loop over a list and return the list and
---filter all glyphs.
---
---* Corresponding C source code: [lnodelib.c#L4065-L4081](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4065-L4081)
---
---@param d integer
---
---@return fun(): d: integer, font: integer, char: integer
function node.direct.traverse_glyph(d) end

_N._7_25_traverse_list = 0

---
---Loop over the `hlist` and `vlist` nodes in a list.
---
---The four return values can save some time compared to fetching these fields.
---
---* Corresponding C source code: [lnodelib.c#L4318-L4330](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4318-L4330)
---
---@param n Node
---
---@return fun(): n: Node, id: integer, subtype: integer, list: Node
function node.traverse_list(n) end

---
---Loop over the `hlist` and `vlist` nodes in a list.
---
---The four return values can save some time compared to fetching these fields.
---
---* Corresponding C source code: [lnodelib.c#L4318-L4330](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L4318-L4330)
---
---@param d integer
---
---@return fun(): d: integer, id: integer, subtype: integer, list: Node
function node.direct.traverse_list(d) end

_N._7_26_has_glyph = 0

---
---Return the first `glyph` or `disc` node in the given list.
---
---* Corresponding C source code: [lnodelib.c#L6368-L6382](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6368-L6382)
---
---@param n Node
---
---@return Node|nil n
function node.has_glyph(n) end

---
---Return the first `glyph` or `disc` node in the given list.
---
---* Corresponding C source code: [lnodelib.c#L6368-L6382](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6368-L6382)
---
---@param d integer
---
---@return integer|nil d
function node.direct.has_glyph(d) end

_N._7_27_end_of_math = 0

---
---Look for and return the next `math` node following the start node `n`.
---
---If
---the given node is a math end node this helper returns that node, else it follows
---the list and returns the next math endnote. If no such node is found `nil` is
---returned.
---
---* Corresponding C source code: [lnodelib.c#L3293-L3313](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3293-L3313)
---
---@param n Node
---
---@return Node|nil t
function node.end_of_math(n) end

---
---Look for and return the next `math` node following the start node `d`.
---
---If
---the given node is a math end node this helper returns that node, else it follows
---the list and returns the next math endnote. If no such node is found `nil` is
---returned.
---
---* Corresponding C source code: [lnodelib.c#L3317-L3334](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3317-L3334)
---
---@param d integer
---
---@return integer|nil t
function node.direct.end_of_math(d) end

_N._7_28_remove = 153

---
---Remove the node `current` from the list following `head`.
---
---It is your responsibility to make sure it is really part of that list.
---The return values are the new `head` and `current` nodes. The
---returned `current` is the node following the `current` in the calling
---argument, and is only passed back as a convenience (or `nil`, if there is
---no such node). The returned `head` is more important, because if the
---function is called with `current` equal to `head`, it will be
---changed.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1775-L1791](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1775-L1791)
---* Corresponding C source code: [lnodelib.c#L2176-L2215](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2176-L2215)
---
---@param head Node
---@param current Node # A node following the list `head`.
---
---@return Node head # The new `head`
---@return Node|nil current # The node following the `current` in the calling
---argument.
function node.remove(head, current) end

---
---Remove the node `current` from the list following `head`.
---
---It is your responsibility to make sure it is really part of that list.
---The return values are the new `head` and `current` nodes. The
---returned `current` is the node following the `current` in the calling
---argument, and is only passed back as a convenience (or `nil`, if there is
---no such node). The returned `head` is more important, because if the
---function is called with `current` equal to `head`, it will be
---changed.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1775-L1791](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1775-L1791)
---* Corresponding C source code: [lnodelib.c#L2219-L2267](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2219-L2267)
---
---@param head integer
---@param current integer # A node following the list `head`.
---
---@return integer|nil head # The new `head`
---@return integer|nil current # The node following the `current` in the calling
---argument.
function node.direct.remove(head, current) end

_N._7_29_insert_before = 153

---
---Insert the node `new` before `current` into the list
---following `head`.
---
---It is your responsibility to make sure that `current` is really part of that list. The return values are the (potentially
---mutated) `head` and the node `new`, set up to be part of the list
---(with correct `next` field). If `head` is initially `nil`, it
---will become `new`.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1793-L1807](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1793-L1807)
---* Corresponding C source code: [lnodelib.c#L2271-L2315](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2271-L2315)
---
---@param head Node
---@param current Node
---@param new Node
---
---@return Node head
---@return Node new
function node.insert_before(head, current, new) end

---
---Insert the node `new` before `current` into the list
---following `head`.
---
---It is your responsibility to make sure that `current` is really part of that list. The return values are the (potentially
---mutated) `head` and the node `new`, set up to be part of the list
---(with correct `next` field). If `head` is initially `nil`, it
---will become `new`.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1793-L1807](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1793-L1807)
---* Corresponding C source code: [lnodelib.c#L2319-L2357](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2319-L2357)
---
---@param head integer
---@param current integer
---@param new integer
---
---@return integer head
---@return integer new
function node.direct.insert_before(head, current, new) end

_N._7_30_insert_after = 153

---
---Insert the node `new` after `current` into the list
---following `head`.
---
---It is your responsibility to make sure that `current` is really part of that list. The return values are the `head` and
---the node `new`, set up to be part of the list (with correct `next`
---field). If `head` is initially `nil`, it will become `new`.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1809-L1822](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1809-L1822)
---* Corresponding C source code: [lnodelib.c#L2361-L2395](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2361-L2395)
---
---@param head Node
---@param current Node
---@param new Node
---
---@return Node head
---@return Node new
function node.insert_after(head, current, new) end

---
---Insert the node `new` after `current` into the list
---following `head`.
---
---It is your responsibility to make sure that `current` is really part of that list. The return values are the `head` and
---the node `new`, set up to be part of the list (with correct `next`
---field). If `head` is initially `nil`, it will become `new`.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L1809-L1822](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1809-L1822)
---* Corresponding C source code: [lnodelib.c#L2399-L2430](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2399-L2430)
---
---@param head integer
---@param current integer
---@param new integer
---
---@return integer head
---@return integer new
function node.direct.insert_after(head, current, new) end

_N._7_31_first_glyph = 154

---
---Return the first node in the list starting at `n` that is a glyph node
---with a subtype indicating it is a glyph, or `nil`.
---
---If `m` is given,
---processing stops at (but including) that node, otherwise processing stops at the
---end of the list.
---
---* Corresponding C source code: [lnodelib.c#L6312-L6337](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6312-L6337)
---
---@param n Node
---@param m? Node
---
---@return Node|nil n
---@return boolean success
function node.first_glyph(n, m) end

---
---Return the first node in the list starting at `d` that is a glyph node
---with a subtype indicating it is a glyph, or `nil`.
---
---If `e` is given,
---processing stops at (but including) that node, otherwise processing stops at the
---end of the list.
---
---* Corresponding C source code: [lnodelib.c#L6341-L6362](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6341-L6362)
---
---@param d integer
---@param e? integer
---
---@return integer|nil d
function node.direct.first_glyph(d, e) end

_N._7_32_ligaturing = 154

---
---Apply *TeX*-style ligaturing to the specified nodelist.
---
---* Corresponding C source code: [lnodelib.c#L5945-L5984](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5945-L5984)
---
---@param head Node
---@param tail? Node
---
---@return Node head # the new head
---@return Node tail # the new tail (both `head` and `tail` can change into a new ligature)
---@return boolean success
function node.ligaturing(head, tail) end

---
---Apply *TeX*-style ligaturing to the specified nodelist.
---
---* Corresponding C source code: [lnodelib.c#L5986-L6017](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5986-L6017)
---
---@param head integer
---@param tail? integer
---
---@return integer head # the new head
---@return integer tail # the new tail (both `head` and `tail` can change into a new ligature)
---@return boolean success
function node.direct.ligaturing(head, tail) end

_N._7_33_kerning = 154

---
---Apply *TeX*-style kerning to the specified node list.
---
---* Corresponding C source code: [lnodelib.c#L6021-L6060](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6021-L6060)
---
---@param head Node
---@param tail? Node
---
---@return Node head  # the new head (can be an inserted kern node, because special kernings with word boundaries are possible).
---@return Node tail # the new tail (can be an inserted kern node, because special kernings with word boundaries are possible).
---@return boolean success
function node.kerning(head, tail) end

---
---Apply *TeX*-style kerning to the specified node list.
---
---* Corresponding C source code: [lnodelib.c#L6062-L6097](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6062-L6097)
---
---@param head integer
---@param tail? integer
---
---@return integer head  # the new head (can be an inserted kern node, because special kernings with word boundaries are possible).
---@return integer tail # the new tail (can be an inserted kern node, because special kernings with word boundaries are possible).
---@return boolean success
function node.direct.kerning(head, tail) end

_N._7_34_unprotect_glyphs = 155

---
---Convert from `characters` to `glyphs` during node
---processing by subtracting `256` from all glyph node subtypes.
---
---* Corresponding C source code: [lnodelib.c#L6217-L6223](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6217-L6223)
---
---@param n Node
function node.unprotect_glyph(n) end

---
---Convert from `characters` to `glyphs` during node
---processing by subtracting `256` from the glyph node subtype.
---
---* Corresponding C source code: [lnodelib.c#L6272-L6278](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6272-L6278)
---
---@param d integer
function node.direct.unprotect_glyph(d) end

---
---Convert from `characters` to `glyphs` during node
---processing by subtracting `256` from the glyph node subtype.
---
---* Corresponding C source code: [lnodelib.c#L6243-L6259](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6243-L6259)
---
---@param head Node
---@param tail? Node
function node.unprotect_glyphs(head, tail) end

---
---Convert from `characters` to `glyphs` during node
---processing by subtracting `256` from all glyph node subtypes.
---
---* Corresponding C source code: [lnodelib.c#L6295-L6308](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6295-L6308)
---
---@param head integer
---@param tail? integer
function node.direct.unprotect_glyphs(head, tail) end

_N._7_35_protect_glyphs = 155

---
---Add `256` to the `glyph` node subtype
---except that if the value is `1`, add only `255`.
---
---The special handling of `1` means
---that `characters` will become `glyphs` after subtraction of `256`.
---
---* Corresponding C source code: [lnodelib.c#L6209-L6215](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6209-L6215)
---
---@param n Node
function node.protect_glyph(n) end

---
---Add `256` to the `glyph` node subtype
---except that if the value is `1`, add only `255`.
---
---The special handling of `1` means
---that `characters` will become `glyphs` after subtraction of `256`.
---
---* Corresponding C source code: [lnodelib.c#L6264-L6270](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6264-L6270)
---
---@param d integer
function node.direct.protect_glyph(d) end

---
---Add `256` to all `glyph` node subtypes in the node list starting at `head`,
---except that if the value is `1`, add only `255`.
---
---The special handling of `1` means
---that `characters` will become `glyphs` after subtraction of `256`.
---
---* Corresponding C source code: [lnodelib.c#L6225-L6241](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6225-L6241)
---
---@param head Node
---@param tail? Node
function node.protect_glyphs(head, tail) end

---
---Add `256` to all `glyph` node subtypes in the node list starting at `head`,
---except that if the value is `1`, add only `255`.
---
---The special handling of `1` means
---that `characters` will become `glyphs` after subtraction of `256`.
---
---* Corresponding C source code: [lnodelib.c#L6280-L6293](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6280-L6293)
---
---@param head integer
---@param tail? integer
function node.direct.protect_glyphs(head, tail) end

_N._7_36_last_node = 155

---
---Pop the last node from *TeX*'s “current list”.
---
---* Corresponding C source code: [lnodelib.c#L2556-L2563](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2556-L2563)
---
---@return Node|nil n
function node.last_node() end

---
---Pop the last node from *TeX*'s “current list”.
---
---* Corresponding C source code: [lnodelib.c#L2567-L2572](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2567-L2572)
---
---@return integer|nil n
function node.direct.last_node() end

_N._7_37_write = 155

---
---Append a node list to *TeX*'s “current list”.
---
---The
---node list is not deep-copied! There is no error checking either! You mignt need
---to enforce horizontal mode in order for this to work as expected.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L2518-L2521](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L2518-L2521), [luatex-nodes.tex#L1913-L1923](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1913-L1923)
---* Corresponding C source code: [lnodelib.c#L2505-L2525](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2505-L2525)
---
---@param n Node
function node.write(n) end

---
---Append a node list to *TeX*'s “current list”.
---
---The
---node list is not deep-copied! There is no error checking either! You mignt need
---to enforce horizontal mode in order for this to work as expected.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L2518-L2521](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L2518-L2521), [luatex-nodes.tex#L1913-L1923](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L1913-L1923)
---* Corresponding C source code: [lnodelib.c#L2529-L2552](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2529-L2552)
---
---@param d integer
function node.direct.write(d) end

_N._7_38_protrusion_skippable = 155

---
---Return `true` if, for the purpose of line boundary discovery when
---character protrusion is active, this node can be skipped.
---
---@param n Node
---
---@return boolean skippable
function node.protrusion_skippable(n) end
node.direct.protrusion_skippable = node.protrusion_skippable

_N._8_glue = 155

_N._8_1_setglue = 155

---
---Set the five properties of a glue in one go.
---
---Non-numeric values are
---equivalent to zero and reset a property.
---
---When you pass values, only arguments that are numbers are assigned so
---
---```
---node.setglue(n,655360,false,65536)
---```
---
---will only adapt the width and shrink.
---
---When a list node is passed, you set the glue, order and sign instead.
---
---@param n Node
---@param width integer|any
---@param stretch integer|any
---@param shrink integer|any
---@param stretch_order integer|any
---@param shrink_order integer|any
function node.setglue(n, width, stretch, shrink, stretch_order, shrink_order) end
node.direct.setglue = node.setglue

_N._8_2_getglue = 155

---
---Return 5 values or nothing when no glue is passed.
---
---When the second argument is false, only the width is returned (this is consistent
---with `tex.get`).
---
---When a list node is passed, you get back the glue that is set, the order of that
---glue and the sign.
---
---@param n Node
---
---@return integer|nil width
---@return integer|nil stretch
---@return integer|nil shrink
---@return integer|nil stretch_order
---@return integer|nil shrink_order
function node.getglue(n) end
node.direct.getglue = node.getglue

_N._8_3_is_zero_glue = 156

---
---Return `true` when the width, stretch and shrink properties
---are zero.
---
---@param n Node
---
---@return boolean isglue
function node.is_zero_glue(n) end
node.direct.is_zero_glue = node.is_zero_glue

_N._9_attribute_handling = 156
_N._9_1_attributes = 156
_N._9_2_attribute_list_nodes = 156
_N._9_3_attr_nodes = 157
_N._9_4_has_attribute = 157

---
---Test if a node has the attribute with number `id` set.
---
---If `val` is
---also supplied, also tests if the value matches `val`. It returns the value,
---or, if no match is found, `nil`.
---
---* Corresponding C source code: [lnodelib.c#L3339-L3353](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3339-L3353)
---
---@param n Node
---@param id integer
---@param val? integer
---
---@return integer|nil v
function node.has_attribute(n, id, val) end
node.direct.has_attribute = node.has_attribute

_N._9_5_get_attribute = 157

---
---Tests if a node has an attribute with number `id` set. It returns the
---value, or, if no match is found, `nil`. If no `id` is given then the
---zero attributes is assumed.
---
---* Corresponding C source code: [lnodelib.c#L3375-L3406](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3375-L3406)
---
---@param n Node
---@param id integer
---
---@return integer|nil v
function node.get_attribute(n, id) end
node.direct.get_attribute = node.get_attribute

_N._9_6_find_attribute = 157

---
---Finds the first node that has attribute with number `id` set. It returns
---the value and the node if there is a match and otherwise nothing.
---
---* Corresponding C source code: [lnodelib.c#L3408-L3443](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3408-L3443)
---
---@param n Node
---@param id integer
---
---@return integer v
---@return Node n
function node.find_attribute(n, id) end
node.direct.find_attribute = node.find_attribute

_N._9_7_set_attribute = 157

---
---Sets the attribute with number `id` to the value `val`. Duplicate
---assignments are ignored.
---
---* Corresponding C source code: [lnodelib.c#L3563-L3578](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3563-L3578)
---
---@param n Node
---@param id integer
---@param val? integer
function node.set_attribute(n, id, val) end
node.direct.set_attribute = node.set_attribute

_N._9_8_unset_attribute = 158

---
---Unsets the attribute with number `id`. If `val` is also supplied, it
---will only perform this operation if the value matches `val`. Missing
---attributes or attribute-value pairs are ignored.
---
---If the attribute was actually deleted, returns its old value. Otherwise, returns
---`nil`.
---
---* Corresponding C source code: [](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3580-L3596)
---
---@param n Node
---@param id integer
---@param val? integer
---
---@return integer v
function node.unset_attribute(n, id, val) end
node.direct.unset_attribute = node.unset_attribute

_N._9_9_slide = 158

---
---This helper makes sure that the node lists is double linked and returns the found
---tail node.
---
---After some callbacks automatic sliding takes place. This feature can be turned
---off with `node.fix_node_lists(false)` but you better make sure then that
---you don't mess up lists. In most cases *TeX* itself only uses `next`
---pointers but your other callbacks might expect proper `prev` pointers too.
---Future versions of *LuaTeX* can add more checking but this will not influence
---usage.
---
---* Corresponding C source code: [lnodelib.c#L3226-L3241](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3226-L3241)
---
---@param n Node
---
---@return Node tail
function node.slide(n) end
node.direct.slide = node.slide

_N._9_10_check_discretionaries = 158

---
---When you fool around with disc nodes you need to be aware of the fact that they
---have a special internal data structure. As long as you reassign the fields when
---you have extended the lists it's ok because then the tail pointers get updated,
---but when you add to list without reassigning you might end up in trouble when
---the linebreak routine kicks in. You can call this function to check the list for
---issues with disc nodes.
---
---The plural variant runs over all disc nodes in a list, the singular variant
---checks one node only (it also checks if the node is a disc node).
---
---* Corresponding C source code: [lnodelib.c#L8615-L8627](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8615-L8627)
---
---@param head Node
function node.check_discretionaries(head) end
node.direct.check_discretionaries = node.check_discretionaries

---
---When you fool around with disc nodes you need to be aware of the fact that they
---have a special internal data structure. As long as you reassign the fields when
---you have extended the lists it's ok because then the tail pointers get updated,
---but when you add to list without reassigning you might end up in trouble when
---the linebreak routine kicks in. You can call this function to check the list for
---issues with disc nodes.
---
---* Corresponding C source code: [lnodelib.c#L8629-L8638](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8629-L8638)
---@param n Node
function node.check_discretionary(n) end
node.direct.check_discretionary = node.check_discretionary

_N._9_11_flatten_discretionaries = 158

---
---This function will remove the discretionaries in the list and inject the replace
---field when set.
---
---* Corresponding C source code: [lnodelib.c#L8640-L8679](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8640-L8679)
---
---@param n Node
---
---@return Node head
---@return integer count
function node.flatten_discretionaries(n) end
node.direct.flatten_discretionaries = node.flatten_discretionaries

_N._9_12_family_font = 158

---
---When you pass a proper family identifier the next helper will return the font
---currently associated with it. You can normally also access the font with the
---normal font field or getter because it will resolve the family automatically for
---noads.
---
---* Corresponding C source code: [lnodelib.c#L2922-L2932](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L2922-L2932)
---
---@param fam integer
---
---@return integer id
function node.family_font(fam) end

_N._10_two_access_models = 159

---
---* Corresponding C source code: [lnodelib.c#L6552-L6565](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6552-L6565)
---
---@param n Node
---
---@return integer d
function node.direct.todirect(n) end

---
---* Corresponding C source code: [lnodelib.c#L6570-L6581](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6570-L6581)
---
---@param d integer
---
---@return Node n
function node.direct.tonode(d) end

_N._10_two_access_models_page_2 = 160

---
---parsing nodelist always involves this one
---
---* Corresponding C source code: [lnodelib.c#L1782-L1800](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1782-L1800)
---
---@param n Node
---
---@return Node|nil next
function node.getnext(n) end
node.direct.getnext = node.getnext

---
---used less but a logical companion to `getnext`
---
---* Corresponding C source code: [lnodelib.c#L1831-L1846](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1831-L1846)
---
---@param n Node
---
---@return Node|nil prev
function node.getprev(n) end
node.direct.getprev = node.getprev

---
---* Corresponding C source code: [lnodelib.c#L1864-L1880](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1864-L1880)
---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setboth(d) end

---
---Return the next and prev pointer of a node.
---
---* Corresponding C source code: [lnodelib.c#L1884-L1902](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1884-L1902)
---
---@param n Node
---
---@return Node|nil next
---@return Node|nil prev
function node.getboth(n) end

---
---Return the next and prev pointer of a node.
---
---* Corresponding C source code: [lnodelib.c#L1851-L1862](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1851-L1862)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil next
---@return integer|nil prev
function node.direct.getboth(d) end

---
---Return the `id` (type) of a node.
---
---* Corresponding C source code: [lnodelib.c#L487-L496](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L487-L496)
---
---@param n Node
---
---@return integer id
function node.getid(n) end

---
---Return the `id` (type) of a node.
---
---* Corresponding C source code: [lnodelib.c#L500-L517](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L500-L517)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer id
function node.direct.getid(d) end

---
---Set the `subtype` of a node.
---
---* Corresponding C source code: [lnodelib.c#L533-L540](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L533-L540)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param subtype integer
function node.direct.setsubtype(d, subtype) end

---
---Return the `subtype` of a node.
---
---* Corresponding C source code: [lnodelib.c#L544-L558](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L544-L558)
---
---@param n Node
---
---@return integer subtype
function node.getsubtype(n) end

---
---Return the `subtype` of a node.
---
---* Corresponding C source code: [lnodelib.c#L522-L531](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L522-L531)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer subtype
function node.direct.getsubtype(d) end

---
---Set the font identifier on a `glyph` node.
---
---* Corresponding C source code: [lnodelib.c#L621-L632](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L621-L632)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@param font integer
function node.direct.setfont(d, font) end

---
---Return the font identifier of a `glyph`, `math_char`, `math_text_char` or `delim` node.
---
---* Corresponding C source code: [lnodelib.c#L636-L654](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L636-L654)
---
---@param n Node
---
---@return integer|nil font
function node.getfont(n) end

---
---Return the font identifier of a `glyph`, `math_char`, `math_text_char` or `delim` node.
---
---* Corresponding C source code: [lnodelib.c#L601-L619](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L601-L619)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil font
function node.direct.getfont(d) end

---
---idem and also in other places
---
---@param n Node
---
---@return integer|nil char
function node.getchar(n) end
node.direct.getchar = node.getchar

---
---returns the `width`, `height` and `depth` of a list, rule or (unexpanded) glyph as well as glue (its spec is looked at) and unset nodes
---
---@param n Node
function node.getwhd(n) end
node.direct.getwhd = node.getwhd

---
---returns the `pre`, `post` and `replace` fields and optionally when true is passed also the tail fields
---
---@param n Node
function node.getdisc(n) end
node.direct.getdisc = node.getdisc

---
---Set child node lists to parent `hlist`, `vlist`, `sub_box`, `sub_mlist`, `ins`, or `adjust` nodes.
---
---* Corresponding C source code: [lnodelib.c#L1404-L1436](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1404-L1436)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param list integer
function node.direct.setlist(d, list) end

---
---Get child node lists of parent `hlist`, `vlist`, `sub_box`, `sub_mlist`, `ins`, or `adjust` nodes.
---
---* Corresponding C source code: [lnodelib.c#L1440-L1458](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1440-L1458)
---
---@param n Node
---
---@return Node|nil list
function node.getlist(n) end

---
---Get child node lists of parent `hlist`, `vlist`, `sub_box`, `sub_mlist`, `ins`, or `adjust` nodes.
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil list
function node.direct.getlist(d) end

---
---Set the leaders to `glue` nodes.
---
---* Corresponding C source code: [lnodelib.c#L1474-L1485](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1474-L1485)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param leader integer
function node.direct.setleader(d, leader) end

---
---Get the leaders of `glue` nodes.
---
---* Corresponding C source code: [lnodelib.c#L1489-L1501](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1489-L1501)
---
---@param n Node
---
---@return Node|nil leaders
function node.getleader(n) end

---
---Get the leaders of `glue` nodes.
---
---* Corresponding C source code: [lnodelib.c#L1463-L1472](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1463-L1472)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil leaders
function node.direct.getleader(d) end

---
---Get the value of a generic node field.
---
---Other field names are often shared so a specific getter makes no sense.
---
---* Corresponding C source code: [lnodelib.c#L5189-L5207](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5189-L5207)
---
---@param n Node
---@param field string
---
---@return any|nil
function node.getfield(n, field) end

---
---Get the value of a generic node field.
---
---Other field names are often shared so a specific getter makes no sense.
---
---* Corresponding C source code: [lnodelib.c#L5402-L5891](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5402-L5891)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param field string
---
---@return any|nil
function node.direct.getfield(d, field) end

---
---Set the SyncTeX fields, a file number aka tag and a line
---number, for a glue, kern, hlist, vlist, rule and math nodes as well as glyph
---nodes (although this last one is not used in native SyncTeX).
---
---Of course you need to know what you're doing as no checking on sane values takes
---place. Also, the SyncTeX interpreter used in editors is rather peculiar and has
---some assumptions (heuristics).
---
---* Corresponding C source code: [lnodelib.c#L8683-L8719](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8683-L8719)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param tag integer
---@param line integer
function node.direct.set_synctex_fields(d, tag, line) end

---
---Query the SyncTeX fields, a file number aka tag and a line
---number, for a glue, kern, hlist, vlist, rule and math nodes as well as glyph
---nodes (although this last one is not used in native SyncTeX).
---
---Of course you need to know what you're doing as no checking on sane values takes
---place. Also, the SyncTeX interpreter used in editors is rather peculiar and has
---some assumptions (heuristics).
---
---* Corresponding C source code: [lnodelib.c#L8721-L8759](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8721-L8759)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer tag
---@return integer line
function node.direct.get_synctex_fields(d) end

---
---* Corresponding C source code: [lnodelib.c#L828-L854](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L828-L854)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param attr_list integer
function node.direct.setattributelist(d, attr_list) end

---
---* Corresponding C source code: [lnodelib.c#L817-L826](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L817-L826)
---
---@param n Node
---
---@return integer
function node.direct.getattributelist(n) end

---
---gets the given box (a list node)
---
---@param box integer
---
---@return Node node_list
function node.direct.getbox(box) end

---
---* Corresponding C source code: [lnodelib.c#L763-L772](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L763-L772)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil
function node.direct.getcomponents(d) end

---
---* Corresponding C source code: [lnodelib.c#L1678-L1714](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1678-L1714)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return any
function node.direct.getdata(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setdepth(d) end

---
---* Corresponding C source code: [lnodelib.c#L3699-L3719](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3699-L3719)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer|nil
function node.direct.getdepth(d) end

---
---Set the direction of `dir`, `hlist`, `vlist`, `rule` and `local_par` nodes as a string.
---
---* Corresponding C source code: [lnodelib.c#L1093-L1109](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1093-L1109)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param dir DirectionSpecifier
function node.direct.setdir(d, dir) end

---
---Get the direction  of `dir`, `hlist`, `vlist`, `rule` and `local_par` nodes as an string.
---
---* Corresponding C source code: [lnodelib.c#L1047-L1067](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1047-L1067)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return DirectionSpecifier
function node.direct.getdir(d) end

---
---Set the direction of `dir`, `hlist`, `vlist`, `rule` and `local_par` nodes as a integer.
---
---* Corresponding C source code: [lnodelib.c#L1111-L1134](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1111-L1134)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param dir integer
function node.direct.setdirection(d, dir) end

---
---Get the direction of `dir`, `hlist`, `vlist`, `rule` and `local_par` nodes as an integer.
---
---* Corresponding C source code: [lnodelib.c#LL1070-L1092](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#LL1070-L1092)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer
function node.direct.getdirection(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setexpansion(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getexpansion(d) end

---
---Set the the family number of `math_char`, `math_text_char`, `delim`, `fraction_noad`, `simple_noad` nodes.
---
---* Corresponding C source code: [lnodelib.c#L719-L735](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L719-L735)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param fam integer
function node.direct.setfam(d, fam) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getfam(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setheight(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getheight(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setkern(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getkern(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setlang(d) end

---
---* Corresponding C source code: [lnodelib.c#L790-L799](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L790-L799)
---
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return integer
function node.direct.getlang(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setnucleus(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getnucleus(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setoffsets(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getoffsets(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getpenalty(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getshift(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setsub(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getsub(d) end

---
---Set the `sup` field on `simple_noad`, `accent_noad` or `radical_noad` nodes.
---
---* Corresponding C source code: [lnodelib.c#L976-L990](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L976-L990)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param sup number # Rounded to an integer
function node.direct.setsup(d, sup) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getsup(d) end

---
---Set the width on `hlist`, `vlist`, `rule`, `glue`, `glue_spec`, `math`, `kern`, `margin_kern`, `ins`, `unset`, `fraction_noad` or `radical_noad` nodes.
---
---* Corresponding C source code: [lnodelib.c#L3641-L3657](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3641-L3657)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param width number # Rounded to an integer
function node.direct.setwidth(d, width) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.getwidth(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.is_direct(d) end

---
---Set the field char on glyph, math_char, math_text_char or delim nodes.
---
---* Corresponding C source code: [lnodelib.c#L702-L717](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L702-L717)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param char integer
function node.direct.setchar(d, char) end

---
---The components on glyph nodes.
---
---* Corresponding C source code: [lnodelib.c#L774-L785](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L774-L785)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param components integer
function node.direct.setcomponents(d, components) end

---
---* Corresponding C source code: [lnodelib.c#L1716-L1751](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1716-L1751)
---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setdata(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setdisc(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setlink(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setnext(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setpenalty(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setprev(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setshift(d) end

---
---@param d integer # The index number of the node in the memory table for direct access.
function node.direct.setsplit(d) end

---
---Set the `width`, `height` and `depth` fields of hlist, vlist, rule or unset nodes.
---
---* Corresponding C source code: [lnodelib.c#L1307-L1346](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L1307-L1346)
---
---@param d integer # The index number of the node in the memory table for direct access.
---@param width number # Rounded to an integer
---@param height number # Rounded to an integer
---@param depth number # Rounded to an integer
function node.direct.setwhd(d, width, height, depth) end

_N._11_properties = 164

---
---Each node also can have a properties table and you can assign values to this table using the
---`setproperty` function
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [lnodelib.c#L8397-L8410](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8397-L8410)
---
---@param node Node
---@param value any
function node.setproperty(node, value) end
node.direct.setproperty = node.setproperty

---
---Each node also can have a properties table and you can get properties using the `getproperty` function.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L2520-L2523](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L2520-L2523)
---* Corresponding C source code: [lnodelib.c#L8379-L8389](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8379-L8389)
---
---@param node Node
---
---@return any value
function node.getproperty(node) end

---
---Each node also can have a properties table and you can get properties using the `getproperty` function.
---
---__Reference:__
---
---* Source code of the `LuaTeX` manual: [luatex-nodes.tex#L2520-L2523](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/luatex-nodes.tex#L2520-L2523)
---* Corresponding C source code: [lnodelib.c#L8391-L8401](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8391-L8401)
---
---@param d integer
---
---@return any value
function node.direct.getproperty(d) end

---
---Managing properties in the node (de)allocator functions is disabled by default and is enabled by:
---
---* Corresponding C source code: [lnodelib.c#L8351-L8360](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8351-L8360)
---
---@param enable boolean
---@param use_metatable? boolean
function node.set_properties_mode(enable, use_metatable) end

---
---Managing properties in the node (de)allocator functions is disabled by default and is enabled by:
---
---* Corresponding C source code: [lnodelib.c#L8351-L8360](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8351-L8360)
---
---@param enable boolean
---@param use_metatable? boolean
function node.direct.set_properties_mode(enable, use_metatable) end

---
---* Corresponding C source code: [lnodelib.c#L366-L374](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L366-L374)
function node.fix_node_lists() end

---
---Warning! Undocumented code!<p>
---TODO: Please contribute
---https://github.com/Josef-Friedrich/LuaTeX_Lua-API#how-to-contribute
function node.flush_properties_table() end
node.direct.flush_properties_table = node.flush_properties_table

---
---@return table
function node.get_properties_table() end
node.direct.get_properties_table = node.get_properties_table

---
---* Corresponding C source code: [lnodelib.c#L6104-L6122](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6104-L6122)
---
---@param n Node
---@param m? Node
function node.hyphenating(n, m) end

---
---* Corresponding C source code: [lnodelib.c#L6124-L6142](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6124-L6142)
---
---@param d integer
---@param e? integer
function node.direct.hyphenating(d, e) end

---
---* Corresponding C source code: [lnodelib.c#L8842-L8868](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L8842-L8868)
---
---@param fnt integer
---@param chr integer
---@param size integer
---@param overlap? integer
---@param horizontal? boolean
---@param attlist? Node
function node.make_extensible(fnt, chr, size, overlap, horizontal, attlist) end

---
---@param n Node
---@param field string
---@param value any
function node.setfield(n, field, value) end

---
---@param d integer # The index number of the node in the memory table for direct access.
---@param field string
---@param value any
function node.direct.setfield(d, field, value) end

---
---* Corresponding C source code: [lnodelib.c#L3153-L3222](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3153-L3222)
---
---@param subtype string|integer
---
---@return string[]
function node.subtypes(subtype) end

---
---* Corresponding C source code: [lnodelib.c#L5913-L5918](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5913-L5918)
---
---@param n Node
---@return string # For example `<node    nil <    234 >    nil : glyph 0>`
function node.tostring(n) end

---
---* Corresponding C source code: [lnodelib.c#L5922-L5931](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L5922-L5931)
---@param d integer # The index number of the node in the memory table for direct access.
---
---@return string # For example `<direct    nil <    234 >    nil : glyph 0>`
function node.direct.tostring(d) end

---
---* Corresponding C source code: [lnodelib.c#L6471-L6476](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6471-L6476)
---
---@return Node n
function node.usedlist() end

---
---* Corresponding C source code: [lnodelib.c#L6480-L6484](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L6480-L6484)
---
---@return integer d
function node.direct.usedlist() end

---
---* Corresponding C source code: [lnodelib.c#L3117-L3151](https://github.com/TeX-Live/luatex/blob/f52b099f3e01d53dc03b315e1909245c3d5418d3/source/texk/web2c/luatexdir/lua/lnodelib.c#L3117-L3151)
---
---@param type 'dir'|'direction'|'glue'|'pdf_literal'|'pdf_action'|'pdf_window'|'color_stack'|'pagestate'
---
---@return string[]
function node.values(type) end
