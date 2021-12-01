require('lsp_config')

jdtls_setup = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local eclipse_dir = os.getenv('HOME') .. '/.config/eclipse-jdt/'
    local java_style = os.getenv('HOME') .. '/.config/CopernicusJavaCodeStyle.xml'
    local root_dir = require('jdtls.setup').find_root({'packageInfo'}, 'Config')
    local home = os.getenv('HOME')
    local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

    local ws_folders_lsp = {}
    local ws_folders_jdtls = {}
    if root_dir then
        local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r");
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line);
                table.insert(ws_folders_jdtls, string.format("file://%s", line))
            end
            file:close()
        end
    end

    local config = {
        on_attach = on_attach,
        cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:' .. eclipse_dir .. '/lombok.jar',
            '-jar', eclipse_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
            '-configuration', eclipse_dir .. '/config_linux',
            '-data', eclipse_dir .. project_name,
            eclipse_workspace
        },
        settings = {
            ["java.format.settings.url"] = java_style,
        },
        root_dir = root_dir,
        init_options = {
            workspaceFolders = ws_folders_jdtls,
        },
    }

    require('jdtls').start_or_attach(config)

    for _,line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end


jdtls_setup()

