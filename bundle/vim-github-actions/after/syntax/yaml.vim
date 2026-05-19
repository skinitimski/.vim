if !exists('b:github_actions_workflow')
    finish
endif

if exists('b:current_syntax') && b:current_syntax !=# 'yaml'
    finish
endif

if exists('b:github_actions_yaml_syntax_loaded')
    finish
endif
let b:github_actions_yaml_syntax_loaded = 1

call github_actions#setup_buffer()
