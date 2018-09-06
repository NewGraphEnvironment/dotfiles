# Sublime notes

## packages

{
    "auto_complete_triggers":
    [
        {
            "characters": "<",
            "selector": "text.html"
        },
        {
            "characters": ".",
            "selector": "source.sql"
        }
    ],
    "font_size": 13,
    "ignored_packages":
    [
        "Vintage"
    ],

    // Formatting
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,

    // Colors
    "theme": "SoDaReloaded Dark.sublime-theme",
    "show_full_path": true,

    // Cursor style - no blinking and slightly wider than default
    //    "caret_style": "solid",
    "wide_caret": true,

    // Editor behavior
    "scroll_past_end": false,
    "highlight_modified_tabs": true,
    "find_selected_text": true,

    // Word wrapping - follow PEP 8 recommendations
    "rulers": [ 79 ],
    "word_wrap": true,
    "wrap_width": 80,

    // Sidebar - exclude distracting files and folders
    "file_exclude_patterns":
    [
        ".DS_Store",
        "*.pid",
        "*.pyc"
    ],
    "folder_exclude_patterns":
    [
        ".git",
        "__pycache__",
        "env",
        "env3",
        ".pytest_cache",
        ".cache",
        ".ipynb_checkpoints"
    ]
}
- SQLTools
- SublimeFixMacPath (required for sqltools)
- OmniMarkupPreview
- SublimeLinter
- SublimeLinter Flake8
- SodaReloaded
- AllAutocomplete

## user config
```
{
    "auto_complete_triggers":
    [
        {
            "characters": "<",
            "selector": "text.html"
        },
        {
            "characters": ".",
            "selector": "source.sql"
        }
    ],
    "font_size": 13,
    "ignored_packages":
    [
        "Vintage"
    ],
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,
    "theme": "SoDaReloaded Dark.sublime-theme"
}
```