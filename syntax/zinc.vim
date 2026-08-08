" Vim syntax file
" Language:     Zinc
" Author:       Nicholas Nethercote <njn@csse.unimelb.edu.au>
" Based on Ralph Becket's mercury.vim.
" vim: ts=2 sw=2 et

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "zinc"

  " Zinc is case sensitive.
  "
syn case match

  " The default highlighting for Zinc comments is to highlight
  " everything including the comment text.  To only highlight the
  " initial `%' and subsequent `line' punctuation characters, put:
  "
  "   let zinc_only_highlight_comment_start = 1
  "
  " somewhere in your `.vimrc' file.
  "
  " By default, parts of lines that extend over 80 characters will be
  " highlighted.  To avoid this behaviour, add
  "
  "   let zinc_highlight_overlong = 1
  "
  " somewhere in your `.vimrc' file.
  "
if exists("zinc_only_highlight_comment_start") && zinc_only_highlight_comment_start
  syn region  zincComment      start=+%[-=%*_]*+ end=+.*$+he=s-1                             contains=zincToDo
else
  syn region  zincComment      start=+%+ end=+.*$+                                           contains=zincToDo,@Spell
endif

syn keyword zincType        ann any array bool enum float int list of opt
syn keyword zincType        par record set string tuple var variant_record

" Generic (polymorphic) type-inst identifiers, e.g. `function $T: foo($T: x)`
" or `$$E` for a generic enum type.  lexer.lxx:413,416
syn match   zincType        "\$\$\?[A-Za-z][A-Za-z0-9_]*"

" Record/tuple field access tail, e.g. `expr.1`, `expr.name` (2.7.0)
syn match   zincFieldTail   "\.\([0-9]\+\|[A-Za-z_][A-Za-z0-9_]*\|'[^'\n]*'\)"

syn keyword zincKeyword     annotation assert case constraint
syn keyword zincKeyword     else elseif endif function if in include let
syn keyword zincKeyword     minimize maximize op output predicate satisfy
syn keyword zincKeyword     solve test then type where

syn match   zincInt         "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match   zincFloat       "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match   zincFloat       "\<[0-9]\+[eE][-+]\=[0-9]\+\>"

syn keyword zincAtom        infinity

syn keyword zincOp          not xor subset superset
syn keyword zincOp          default diff div intersect mod symdiff union
syn match   zincOp          &\.\.\|+\|-\|\*\|\/\|\^\|++&

" Half-open range operators (2.6.0)
syn match   zincOp          &<\.\.<\|\.\.<\|<\.\.&

syn match   zincOp          +<->\|<-\|->\|/\\\|\\/+

" Although '=' can be an operator, don't highlight it because it's mostly
" used in definitions.  Likewise, 'in' can be an operator, but we treat it
" as a keyword because it's mostly used in generators.
syn match   zincOp          +==\|!=\|<>\|=<\|<=\|<\|>=\|=>\|>\|>+
syn match   zincOp          +\.\.\.+

" Weak arithmetic operators (2.6.0); `~` is escaped since it's a magic atom
syn match   zincOp          &\~+\|\~-\|\~\*\|\~/\|\~!=\|\~=\|\~div&

syn keyword zincToDo        XXX TODO NOTE
syn region  zincString       start=+"+ skip=+\\.+ end=+"+                              contains=zincStringFmt,zincInterp,@Spell
syn match   zincStringFmt    +\\[abfnrtv]\|\\x[0-9a-fA-F]*\\\|%[-+# *.0-9]*[dioxXucsfeEgGp]+                                                                           contained

" String interpolation: "text \(expr) text".  The interpolated expression is
" ordinary Zinc code, so highlight it as such (via contains=TOP) rather than
" swallowing it as part of the string body; \( and ) are shown like other
" string escapes (zincStringFmt).  Parens inside the expression nest via
" zincInterpParen so a `)` from e.g. a function call doesn't end it early.
syn region  zincInterp        matchgroup=zincStringFmt start=+\\(+ end=+)+             contained contains=TOP,zincInterpParen
syn region  zincInterpParen                             start=+(+  end=+)+             contained contains=TOP,zincInterpParen

syn keyword zincFun         abs sum product max min forall exists card
syn keyword zincFun         ceil floor round bool2int int2float set2array
syn keyword zincFun         sqrt pow exp ln log sin cos
syn keyword zincFun         show show_int show_float concat join

" Global constraints: https://www.minizinc.org/doc-2.5.5/en/lib-globals.html
"
" Counting constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#counting-constraints
syn keyword zincGlobal      among among_fn at_least at_most at_most1 count count_eq count_fn count_geq count_gt count_leq count_lt count_neq distribute distribute_fn exactly global_cardinality global_cardinality_closed global_cardinality_closed_fn global_cardinality_fn global_cardinality_low_up global_cardinality_low_up_closed sliding_among

" All-Different and co: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#all-different-and-related-constraints
syn keyword zincGlobal      all_different all_different_except all_different_except_0 all_disjoint all_equal alldifferent_except alldifferent_except_0 nvalue nvalue_fn symmetric_all_different

" Lexicographic constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#lexicographic-constraints
syn keyword zincGlobal      lex2 lex2_strict lex_chain lex_chain_greater lex_chain_greatereq lex_chain_greatereq_orbitope lex_chain_less lex_chain_lesseq lex_chain_lesseq_orbitope lex_greater lex_greatereq lex_less lex_lesseq seq_precede_chain strict_lex2 value_precede value_precede_chain

" Sorting constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#sorting-constraints
syn keyword zincGlobal      arg_sort arg_val sort sort_fn increasing decreasing strictly_increasing strictly_decreasing

" Channeling constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#channeling-constraints
syn keyword zincGlobal      int_set_channel inverse inverse_fn inverse_in_range inverse_set link_set_to_booleans

" Packing constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#packing-constraints
syn keyword zincGlobal      bin_packing bin_packing_capa bin_packing_load bin_packing_load_fn diffn diffn_k diffn_nonstrict diffn_nonstrict_k geost geost_bb geost_nonoverlap_k geost_smallest_bb knapsack

" Scheduling constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#scheduling-constraints
syn keyword zincGlobal      alternative cumulative cumulative_opt cumulatives cumulatives_opt disjunctive disjunctive_opt disjunctive_strict disjunctive_strict_opt span

" Graph constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#graph-constraints
syn keyword zincGlobal      bounded_dpath bounded_path connected d_weighted_spanning_tree dag dconnected dpath dreachable dsteiner dtree path reachable steiner subgraph tree weighted_spanning_tree

" Extensional constraints: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#extensional-constraints-table-regular-etc
syn keyword zincGlobal      cost_mdd cost_regular mdd mdd_nondet regular regular_nfa regular_regexp table

" Machine learning constraints
syn keyword zincGlobal      neural_net

" Other declarations: https://www.minizinc.org/doc-2.10.0/en/lib-globals.html#other-declarations
syn keyword zincGlobal      arg_max arg_min circuit circuit_opt disjoint element maximum maximum_arg member minimum minimum_arg network_flow network_flow_cost partition_set piecewise_linear range range_fn roots roots_fn sliding_sum subcircuit sum_pred sum_set var_perm_sym var_sqr_sym write writes writes_seq

if exists("zinc_highlight_overlong") && !zinc_highlight_overlong
  " The complicated regexp here matches an 80-column string,
  " with proper treatment of tabs (assuming the tab size is 8):
  " each row consists of 10 columns, and each column consists of either 8
  " non-tab characters, or 0-7 non-tab characters followed by a tab.
  syn match   zincFirst80 +^\([^	]\{8}\|[^	]\{0,7}	\)\{10}+                                contains=ALL
  syn match   zincTooLong +^\([^	]\{8}\|[^	]\{0,7}	\)\{10}..*+                             contains=zincFirst80
endif

syn region  cComment   start="/\*" end=".*\*/"                                          contains=zincToDo
syn region  zincDocComment  start="/\*\*\+" end=".*\*/"                                 contains=zincToDo

syn sync fromstart

hi link zincComment          Comment
hi link cComment             Comment
hi link zincDocComment       SpecialComment
hi link zincType             Type
hi link zincInt              Number
hi link zincFloat            Number
hi link zincKeyword          Keyword
hi link zincToDo             Todo
hi link zincOp               Special
hi link zincFieldTail        Special
hi link zincString           String
hi link zincStringFmt        Special
hi link zincAtom             Constant
hi link zincTooLong          ErrorMsg
hi link zincFun              Function
hi link zincGlobal           Function
