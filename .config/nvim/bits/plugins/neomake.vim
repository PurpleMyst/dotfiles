

" Automatic syntax checking
silent! call neomake#configure#automake({
\'TextChanged':  {},
\'TextChangedI': {},
\'InsertLeave':  {},
\'BufWritePost': {'delay': 0},
\'BufReadPost':  {},
\}, 500)

let g:neomake_cpp_clang_args = ['-std=c++17', '-Wall', '-Wextra', '-Weffc++']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']
let g:neomake_c_clang_args = ['-std=c99', '-Wall', '-Wextra', '-Weffc++']

let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_sh_shellcheck_args = ['-fgcc']
