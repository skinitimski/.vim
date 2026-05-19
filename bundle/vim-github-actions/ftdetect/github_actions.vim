augroup github_actions_detect
    autocmd!
    autocmd BufNewFile,BufRead .github/workflows/*.yml,.github/workflows/*.yaml,*/.github/workflows/*.yml,*/.github/workflows/*.yaml let b:github_actions_workflow = 1 | setfiletype yaml
    autocmd BufNewFile,BufRead action.yml,action.yaml,*/action.yml,*/action.yaml let b:github_actions_workflow = 1 | setfiletype yaml
augroup END
