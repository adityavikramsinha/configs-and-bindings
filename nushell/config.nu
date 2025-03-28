oh-my-posh init nu --config ~/.config/.poshthemes/1_shell.omp.json

source ~/.oh-my-posh.nu

let cat_theme  = {
    rosewater: "#f4dbd6",
    flamingo: "#f0c6c6",
    pink: "#f5bde6",
    mauve: "#c6a0f6",
    red: "#ed8796",
    maroon: "#ee99a0",
    peach: "#f5a97f",
    yellow: "#eed49f",
    green: "#a6da95",
    teal: "#8bd5ca",
    sky: "#91d7e3",
    sapphire: "#7dc4e4",
    blue: "#8aadf4",
    lavender: "#b7bdf8",
    text: "#cad3f5",
    subtext1: "#b8c0e0",
    subtext0: "#a5adcb",
    overlay2: "#939ab7",
    overlay1: "#8087a2",
    overlay0: "#6e738d",
    surface2: "#5b6078",
    surface1: "#494d64",
    surface0: "#363a4f",
    base: "#24273a",
    mantle: "#1e2030",
    crust: "#181926"
}


$env.config.show_banner = false
let config = {
    color_config: {
        separator: $cat_theme.subtext1
        leading_trailing_space_bg: $cat_theme.sapphire
        header: {
        fg : $cat_theme.flamingo
        attr  : ub
        }
        date: wd
        row_index: $cat_theme.yellow
        bool : {|b| if $b { $cat_theme.green} else  {$cat_theme.red }}
        int: $cat_theme.teal
        duration: $cat_theme.blue
        float: $cat_theme.red
        string: $cat_theme.text
        nothing: $cat_theme.red
        binary: $cat_theme.rosewater
        cellpath: $cat_theme.sky
        hints: $cat_theme.overlay1
	    filesize : {|x| if $x == 0b { $cat_theme.overlay0 } else if $x < 1mb { $cat_theme.peach } else { $cat_theme.pink } }
	        shape_block: $cat_theme.blue,
            shape_bool: $cat_theme.sky,
            shape_custom: $cat_theme.yellow, # Using yellow for custom elements
            shape_external: $cat_theme.teal,
            shape_externalarg: $cat_theme.green,
            shape_filepath: $cat_theme.rosewater, # Using rosewater for filepaths
            shape_flag: $cat_theme.blue,
            shape_float: $cat_theme.mauve,
            shape_garbage: {bg : $cat_theme.red fg : $cat_theme.overlay1}, # Red will still look like errors.
            shape_globpattern: $cat_theme.teal,
            shape_int: $cat_theme.mauve,
            shape_internalcall: $cat_theme.teal,
            shape_list: $cat_theme.yellow, # Yellow for lists
            shape_literal: $cat_theme.blue,
            shape_nothing: $cat_theme.rosewater, # rosewater for nothing
            shape_operator: $cat_theme.yellow,
            shape_range: $cat_theme.yellow,
            shape_record: $cat_theme.teal,
            shape_signature: $cat_theme.green,
            shape_string: $cat_theme.green,
            shape_string_interpolation: $cat_theme.teal,
            shape_table: $cat_theme.blue,
            shape_variable: $cat_theme.mauve
    },
    table : {
        padding : {
            left: 3
            right :3
        }
        mode : "compact"
    }
}

alias sl = ls 
alias rmdir = rm -r -f 
# Used for opening the following editors from the CLI, (if installed)
# Idea IntelliJ for Jav
# Pycharm for Python 
# RustRover for Rust
# Android Studio for Andorid
# VS Code for anything else. 
# 
def code [
lang : string # the langauge to open the editor for, langauges : java, rust, python, android
 filepath : string # where to open the editor, . for this directory
] { 
match $lang { 
	"java" => {  `C:\Users\Aditya\AppData\Local\JetBrains\Toolbox\scripts\idea.cmd` $filepath} 
	"rust" => { `C:\Users\Aditya\AppData\Local\JetBrains\Toolbox\scripts\rustrover.cmd` $filepath } 
	"python" => { `C:\Users\Aditya\AppData\Local\JetBrains\Toolbox\scripts\pycharm.cmd` $filepath} 
	"android" => {`C:\Users\Aditya\AppData\Local\JetBrains\Toolbox\scripts\studio.cmd` $filepath}  
	_ => {`C:\Users\Aditya\AppData\Local\Programs\Microsoft VS Code\Code.exe` $filepath} 
} 
} 

$env.config = $config 