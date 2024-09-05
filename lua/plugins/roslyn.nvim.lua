return {
  'seblj/roslyn.nvim',
  config = function()
    local util = require('lspconfig.util')
    require('roslyn').setup({
      exe = {
        'dotnet',
        vim.fs.joinpath(vim.fn.stdpath('data') --[[@as string]], 'roslyn', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
      },
      config = {
        --[[ capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = function(fname)
          return util.root_pattern('*.sln')(fname) or util.root_pattern('*.csproj')(fname)
        end, ]]
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ['csharp|completion'] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|highlighting'] = {
            dotnet_highlight_related_json_components = true,
            dotnet_highlight_related_regex_components = true,
          },
        },
      },
    })
  end,
}
