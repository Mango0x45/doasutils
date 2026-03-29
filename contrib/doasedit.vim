" ==============================================================================
" File:          doasedit.vim
" Description:   Automatic filetype detection for doasedit
" Author:        Thomas Voss <mail@thomasvoss.com>
" URL:           https://git.thomasvoss.com/doasutils
" License:       BSD-2-Clause
" ==============================================================================
"
" Permission to use, copy, modify, and distribute this software for any
" purpose with or without fee is hereby granted, provided that the above
" copyright notice and this permission notice appear in all copies.
"
" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
" WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
" WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
" AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
" DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
" OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
" TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
" PERFORMANCE OF THIS SOFTWARE.
" ==============================================================================

if exists('g:loaded_doasedit_ft')
	finish
endif
let g:loaded_doasedit_ft = 1

let s:tmpdir = empty($TMPDIR) ? '/tmp' : $TMPDIR
let s:tmpdir = substitute(s:tmpdir, '/\+$', '', '')
let s:pattern = escape(s:tmpdir . '/doasedit.*', ' ')

augroup doasedit_filetype
	autocmd!
	execute 'autocmd BufNewFile,BufRead ' . s:pattern . ' call s:SetFiletype()'
augroup END

function! s:SetFiletype()
	if empty($DOASEDIT_EDITING)
		return
	endif
	execute 'doautocmd filetypedetect BufRead ' . fnameescape($DOASEDIT_EDITING)
endfunction
