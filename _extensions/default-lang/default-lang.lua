local lang = nil

function has_any_class(el)
  if (el and el.classes and #el.classes > 0) then
    return true
  end
  return false
end

function has_class(el, class)
  if has_any_class(el) then
    for _, c in pairs(el.classes) do
      if c == class then
        return true
      end
    end
  end
  return false
end

function add_lang(el)
  if not has_any_class(el) then
    -- el has not class, thus we can add the lang
    el.classes = { lang }
  end
  return el
end

cleanup_cell_output = {
  Div = function(el)
    if has_class(el, "cell-output") then
      for i, block in ipairs(el.content) do
        if has_class(block, lang) then
          for ii, c in ipairs(block.classes) do
            if c == lang then
              table.remove(block.classes, ii)
              break
            end
          end
        end
      end
    end
    return el
  end
}

function parse_lang(lang)
  if lang[1].t ~= "Str" then
    error("default-code-lang must be a string")
  end
  return lang[1].text
end

default_lang = {
  Code = add_lang,
  CodeBlock = add_lang
}

function Pandoc(doc)
  if doc.meta['default-code-lang'] then
    lang = parse_lang(doc.meta['default-code-lang'])
    local blocks = pandoc.walk_block(pandoc.Div(doc.blocks), default_lang)
    blocks = pandoc.walk_block(blocks, cleanup_cell_output)
    doc.blocks = blocks.content
  end

  return doc
end
