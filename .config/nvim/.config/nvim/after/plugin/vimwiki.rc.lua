-- let wiki_1 = {}
-- let wiki_1.path = '~/my_docs/'
-- let wiki_1.html_template = '~/public_html/template.tpl'
-- let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
--
-- let wiki_2 = {}
-- let wiki_2.path = '~/project_docs/'
-- let wiki_2.index = 'main'
--
-- let g:vimwiki_list = [wiki_1, wiki_2]

vim.cmd([[
    let wiki = {}
    let wiki.path = '/DATA/PERSONAL/Wiki/'
    let wiki.public_html = '/DATA/PERSONAL/Wiki/html/'

    let g:vimwiki_list = [{'path': '/DATA/PERSONAL/Wiki/'}]

    " set nocompatible
    " filetype plugin on
    " syntax on
]])
