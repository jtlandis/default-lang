local lang = nil

function has_any_class(el)
  if (el and el.classes and #el.classes > 0) then
    return true
  end
  return false
end

function add_lang(el)
  if not has_any_class(el) then
    -- el has not class, thus we can add the lang
    el.classes = { lang[1].text }
  end
  return el
end

default_lang = {
  Code = add_lang,
  CodeBlock = add_lang
}

function Pandoc(doc)
  if doc.meta['default-code-lang'] then
    lang = doc.meta['default-code-lang']
    local blocks = pandoc.walk_block(pandoc.Div(doc.blocks), default_lang)
    doc.blocks = blocks.content
  end

  return doc
end
