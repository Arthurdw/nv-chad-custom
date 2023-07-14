local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- #[component]
-- fn ${1}(cx: Scope) -> impl IntoView {
--     ${2}
-- }
local comp_snippet = s("comp", {
    t("#[component]"),
    t{"", "fn "},
    i(1),
    t("(cx: Scope) -> impl IntoView {"),
    t{"", "\t"},
    i(2),
    t{"", "}"},
})

-- view! { cx,
--     ${1}
-- }
local view_snippet = s("view", {
    t{"view! { cx,"},
    t{"", "\t"},
    i(1),
    t{"", "}"},
})


-- #[test]
-- fn ${1}() {
--    ${2}
--  }
local test_snippet = s("tfn", {
    t("#[test]"),
    t{"", "fn "},
    i(1),
    t{"", "() {"},
    t{"", "\t"},
    i(2),
    t{"", "}"},
})

-- #[tokio::test]
-- async fn ${1}() {
--    ${2}
--  }
local tokio_test_snippet = s("atfn", {
    t("#[test]"),
    t{"", "fn "},
    i(1),
    t{"", "() {"},
    t{"", "\t"},
    i(2),
    t{"", "}"},
})

-- async fn ${1}() {
--   ${2}
-- }
local async_fn_snippet = s("afn", {
    t{"", "async fn "},
    i(1),
    t{"", "() {"},
    t{"", "\t"},
    i(2),
    t{"", "}"},
})

return {
  comp_snippet,
  view_snippet,
  test_snippet,
  tokio_test_snippet,
  async_fn_snippet,
}
