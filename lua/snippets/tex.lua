local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
  s("sol",
    fmt([[
      \begin{{solution}}[label={1}]
        \begin{{question}}
          {2}
        \end{{question}}
        \tcblower{{}}
        \begin{{proof}}[{3}]
          {4}
        \end{{proof}}
      \end{{solution}}
    ]], {
        i(1, "label"),
        i(2, "Question"),
        i(3, "Proof"),
        i(4, "Proof")
      })
  )
})

ls.add_snippets("tex", {
  s("init",
    fmt([[
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Define Article %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\documentclass{{{1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Using Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{{geometry}}
\usepackage{{graphicx}}
\usepackage{{amssymb}}
\usepackage{{amsmath}}
\usepackage{{amsthm}}
\usepackage{{empheq}}
\usepackage{{booktabs}}
\usepackage{{lipsum}}
\usepackage{{graphicx}}
\usepackage{{color}}
\usepackage{{psfrag}}
\usepackage{{pgfplots}}
\usepackage{{bm}}
\usepackage{{braket}}
\usepackage{{tikz}}
\usetikzlibrary{{quantikz2}}
\usepackage{{todonotes}}
\usepackage[]{{hyperref}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Other Settings
\setlength{{\marginparwidth}}{{2cm}}
{2}

%%%%%%%%%%%%%%%%%%%%%%%%%% Page Setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\geometry{{a4paper}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepgfplotslibrary{{colorbrewer}}
\pgfplotsset{{width=8cm,compat=1.9}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Title & Author %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\title{{{3}}}
\author{{{4}}}
\date{{\today}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{{document}}
    \maketitle

    \tableofcontents

    {5}

\end{{document}}
    ]], {
        i(1, "article"),
        i(2, [[\input{definitions.tex}]]),
        i(3, "Title"),
        i(4, "Sayam Sethi"),
        i(5, "Content")
    })
  )
})
