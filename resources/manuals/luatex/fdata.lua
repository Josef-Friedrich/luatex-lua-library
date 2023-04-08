-- https://raw.githubusercontent.com/TeX-Live/luatex/f52b099f3e01d53dc03b315e1909245c3d5418d3/manual/old/fdata.lua
-- $Id: fdata.lua 4106 2011-04-10 12:51:54Z hhenkel $
local fdata = {
    ["callback"] = {
        ["functions"] = {
            ["buildpage_filter"] = {
                ["arguments"] = {
                    {
                        ["name"] = "info",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Process objects as they are added to the main vertical list. The string argument gives some context.",
                ["type"] = "callback"
            },
            ["close"] = {
                ["arguments"] = {
                    {["name"] = "env", ["optional"] = false, ["type"] = "table"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Close a file opened with the `open_read_file` callback. The argument is the return value from the `open_read_file`",
                ["type"] = "callback"
            },
            ["define_font"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "font",
                        ["optional"] = false,
                        ["type"] = "metrics"
                    }
                },
                ["shortdesc"] = "Define a font from within lua code. The arguments are the user-supplied information, with negative numbers indicating `scaled`, positive numbers `at`",
                ["type"] = "callback"
            },
            ["find"] = {
                ["arguments"] = {
                    {
                        ["name"] = "callback_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "f",
                        ["optional"] = false,
                        ["type"] = "function"
                    }
                },
                ["shortdesc"] = "Returns the function currently associated with a callback, or `nil`",
                ["type"] = "function"
            },
            ["find_data_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find an input data file for PDF attachment.",
                ["type"] = "callback"
            },
            ["find_enc_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a font encoding file.",
                ["type"] = "callback"
            },
            ["find_font_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a font metrics file.",
                ["type"] = "callback"
            },
            ["find_format_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find the format file.",
                ["type"] = "callback"
            },
            ["find_image_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find an image file for inclusion.",
                ["type"] = "callback"
            },
            ["find_map_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a font map file.",
                ["type"] = "callback"
            },
            ["find_opentype_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find an OpenType font file.",
                ["type"] = "callback"
            },
            ["find_output_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find the output (PDF or DVI) file.",
                ["type"] = "callback"
            },
            ["find_pk_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a PK font bitmap file.",
                ["type"] = "callback"
            },
            ["find_read_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "id_number",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a file for `input` (0) or `openin` (higher integers).",
                ["type"] = "callback"
            },
            ["find_subfont_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a subfont definition file.",
                ["type"] = "callback"
            },
            ["find_truetype_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find an TrueType font file.",
                ["type"] = "callback"
            },
            ["find_type1_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find an Type1 (PostScript) font file.",
                ["type"] = "callback"
            },
            ["find_vf_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a VF file.",
                ["type"] = "callback"
            },
            ["find_write_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "id_number",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "asked_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "actual_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Find a file for writing to the log file (0) or with `write` (higher integers).",
                ["type"] = "callback"
            },
            ["finish_pdffile"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions just before the PDF closing takes place.",
                ["type"] = "callback"
            },
            ["hpack_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "groupcode",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "size",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "packtype",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "direction",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Alter a node list before horizontal packing takes place. The first string gives some context,\
	 the number is the desired size, the second string is either `exact` or `additional` (modifies the first string),\
	 the third string is the desired direction",
                ["type"] = "callback"
            },
            ["hyphenate"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "tail", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Apply hyphenation to a node list.",
                ["type"] = "callback"
            },
            ["kerning"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "tail", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Apply kerning to a node list.",
                ["type"] = "callback"
            },
            ["ligaturing"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "tail", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Apply ligaturing to a node list.",
                ["type"] = "callback"
            },
            ["linebreak_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "is_display",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Override the linebreaking algorithm. The boolean is `true` if this is a pre-display break.",
                ["type"] = "callback"
            },
            ["list"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "info",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Produce a list of all known callback names.",
                ["type"] = "function"
            },
            ["mlist_to_hlist"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "displaytype",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "need_penalties",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Convert a math node list into a horizontal node list.",
                ["type"] = "callback"
            },
            ["open_read_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "file_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "env", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Open a file for reading. The returned table should define key functions for  `reader` and `close`.",
                ["type"] = "callback"
            },
            ["post_linebreak_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "groupcode",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Alter a node list afer linebreaking has taken place. The string argument gives some context.",
                ["type"] = "callback"
            },
            ["pre_dump"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions just before format dumping takes place.",
                ["type"] = "callback"
            },
            ["pre_linebreak_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "groupcode",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Alter a node list before linebreaking takes place. The string argument gives some context.",
                ["type"] = "callback"
            },
            ["pre_output_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "groupcode",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "size",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "packtype",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "maxdepth",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "direction",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Alter a node list before boxing to `outputbox` takes place. See `vpack_filter` for the arguments.",
                ["type"] = "callback"
            },
            ["process_input_buffer"] = {
                ["arguments"] = {
                    {
                        ["name"] = "buffer",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "adjusted_buffer",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Modify the encoding of the input buffer.",
                ["type"] = "callback"
            },
            ["process_output_buffer"] = {
                ["arguments"] = {
                    {
                        ["name"] = "buffer",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "adjusted_buffer",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Modify the encoding of the output buffer.",
                ["type"] = "callback"
            },
            ["read_data_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a data file.",
                ["type"] = "callback"
            },
            ["read_enc_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a font encoding file.",
                ["type"] = "callback"
            },
            ["read_font_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a TFM metrics file. Return `true},  the data, and the data length for success, `false` otherwise",
                ["type"] = "callback"
            },
            ["read_map_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a font map file.",
                ["type"] = "callback"
            },
            ["read_opentype_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read an OpenType font.",
                ["type"] = "callback"
            },
            ["read_pk_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a font bitmap PK file.",
                ["type"] = "callback"
            },
            ["read_sfd_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a subfont definition file.",
                ["type"] = "callback"
            },
            ["read_truetype_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a TrueType font.",
                ["type"] = "callback"
            },
            ["read_type1_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a Type1 font.",
                ["type"] = "callback"
            },
            ["read_vf_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "data_size",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Read a VF metrics file.",
                ["type"] = "callback"
            },
            ["reader"] = {
                ["arguments"] = {
                    {["name"] = "env", ["optional"] = false, ["type"] = "table"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "line",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Read a line from a file opened with the `open_read_file` callback. The argument is the return value from `open_read_file}",
                ["type"] = "callback"
            },
            ["register"] = {
                ["arguments"] = {
                    {
                        ["name"] = "callback_name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "callback_func",
                        ["optional"] = false,
                        ["type"] = "function"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "error",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Register a callback. Passing `nil` removes an existing callback. Returns `nil}, `error` on failure.",
                ["type"] = "function"
            },
            ["show_error_hook"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run action at error reporting time.",
                ["type"] = "callback"
            },
            ["start_page_number"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions at the start of typeset page number message reporting.",
                ["type"] = "callback"
            },
            ["start_run"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions at the start of the typesetting run.",
                ["type"] = "callback"
            },
            ["stop_page_number"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions at the end of typeset page number message reporting.",
                ["type"] = "callback"
            },
            ["stop_run"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Run actions just before the end of the typesetting run.",
                ["type"] = "callback"
            },
            ["token_filter"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "token",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Override the tokenization process. Return value is a `token` or an array of tokens",
                ["type"] = "callback"
            },
            ["vpack_filter"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "groupcode",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "size",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "packtype",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "maxdepth",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "direction",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "newhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Alter a node list before vertical packing takes place. The second number is the desired max depth. See `hpack_filter` for the arguments.",
                ["type"] = "callback"
            }
        },
        ["methods"] = {}
    },
    ["epdf"] = require "fdata_epdf",
    ["font"] = {
        ["functions"] = {
            ["current"] = {
                ["arguments"] = {
                    {["name"] = "i", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = true, ["type"] = "number"}
                },
                ["shortdesc"] = "Get or set the currently active font",
                ["type"] = "function"
            },
            ["define"] = {
                ["arguments"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "metrics"}
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Process a font metrics table and stores it in the internal font table, returning its internal id.",
                ["type"] = "function"
            },
            ["each"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "v", ["optional"] = false, ["type"] = "metrics"}
                },
                ["shortdesc"] = "Iterate over all the defined fonts.",
                ["type"] = "function"
            },
            ["frozen"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "True if the font is frozen and can no longer be altered.",
                ["type"] = "function"
            },
            ["getfont"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "metrics"}
                },
                ["shortdesc"] = "Fetch an internal font id as a lua table.",
                ["type"] = "function"
            },
            ["id"] = {
                ["arguments"] = {
                    {
                        ["name"] = "csname",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the font id of the font accessed by the csname given.",
                ["type"] = "function"
            },
            ["max"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the highest used font id at this moment.",
                ["type"] = "function"
            },
            ["nextid"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the next free font id number.",
                ["type"] = "function"
            },
            ["read_tfm"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "fnt",
                        ["optional"] = false,
                        ["type"] = "metrics"
                    }
                },
                ["shortdesc"] = "Parse a font metrics file, at the size indicated by the number.",
                ["type"] = "function"
            },
            ["read_vf"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "vf_fnt",
                        ["optional"] = false,
                        ["type"] = "metrics"
                    }
                },
                ["shortdesc"] = "Parse a virtual font metrics file, at the size indicated by the number.",
                ["type"] = "function"
            },
            ["setfont"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "f", ["optional"] = false, ["type"] = "metrics"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an internal font id from a lua table.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["fontloader"] = {
        ["functions"] = {
            ["apply_afmfile"] = {
                ["arguments"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "luafont"},
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Apply an AFM file to a fontloader table.",
                ["type"] = "function"
            },
            ["apply_featurefile"] = {
                ["arguments"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "luafont"},
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Apply a feature file to a fontloader table.",
                ["type"] = "function"
            },
            ["info"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "info",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Get various information fields from an font file.",
                ["type"] = "function"
            },
            ["open"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "fontname",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "luafont"},
                    {["name"] = "w", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Parse a font file and return a table representing its contents. The optional argument\
	 is the name of the desired font in case of font collection files. The optional return\
	 value contains any parser error strings.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["img"] = require "fdata_img",
    ["kpse"] = {
        ["functions"] = {
            ["expand_braces"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Expand the braces in a variable.",
                ["type"] = "function"
            },
            ["expand_path"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Expand a path.",
                ["type"] = "function"
            },
            ["expand_var"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Expand a variable.",
                ["type"] = "function"
            },
            ["find_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "ftype",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "mustexist",
                        ["optional"] = true,
                        ["type"] = "boolean"
                    },
                    {["name"] = "dpi", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Find a file. The optional string is the file type as supported by the\
      standalone `kpsewhich` program (default is `{tex}}, no autodiscovery takes place).\
      The optional boolean indicates wether the file must exist.\
      The optional number is the dpi value for PK files.\
      ",
                ["type"] = "function"
            },
            ["init_prog"] = {
                ["arguments"] = {
                    {
                        ["name"] = "prefix",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "base_dpi",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "mfmode",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "fallback",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Initialize a PK generation program. The optional string is the metafont mode fallback name",
                ["type"] = "function"
            },
            ["lookup"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "options",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Find a file (extended interface).",
                ["type"] = "function"
            },
            ["new"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "progname",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "kpathsea",
                        ["optional"] = false,
                        ["type"] = "kpathsea"
                    }
                },
                ["shortdesc"] = "Create a new kpathsea library instance. The optional string allows explicit `progname` setting.",
                ["type"] = "function"
            },
            ["readable_file"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Returns true if a file exists and is readable.",
                ["type"] = "function"
            },
            ["set_program_name"] = {
                ["arguments"] = {
                    {
                        ["name"] = "name",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "progname",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Initialize the kpathsea library by setting the program name. The optional string allows explicit `progname` setting.",
                ["type"] = "function"
            },
            ["show_path"] = {
                ["arguments"] = {
                    {
                        ["name"] = "ftype",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "List the search path for a specific file type.",
                ["type"] = "function"
            },
            ["var_value"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Return the value of a variable.",
                ["type"] = "function"
            },
            ["version"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "r", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Return the kpathsea version.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["lang"] = {
        ["functions"] = {
            ["clean"] = {
                ["arguments"] = {
                    {["name"] = "o", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Creates a hyphenation key from the supplied hyphenation exception.",
                ["type"] = "function"
            },
            ["clear_hyphenation"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Clear the set of hyphenation exceptions.",
                ["type"] = "function"
            },
            ["clear_patterns"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Clear the set of hyphenation patterns.",
                ["type"] = "function"
            },
            ["hyphenate"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "tail", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Hyphenate a node list.",
                ["type"] = "function"
            },
            ["hyphenation"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "string"}
                },
                ["shortdesc"] = "Get or set hyphenation exceptions.",
                ["type"] = "function"
            },
            ["id"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Returns the current internal `language` id number.",
                ["type"] = "function"
            },
            ["new"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    }
                },
                ["shortdesc"] = "Create a new language object, with an optional fixed id number.",
                ["type"] = "function"
            },
            ["patterns"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "string"}
                },
                ["shortdesc"] = "Get or set hyphenation patterns.",
                ["type"] = "function"
            },
            ["postexhyphenchar"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["shortdesc"] = "Set the post-hyphenchar for explicit hyphenation.",
                ["type"] = "function"
            },
            ["posthyphenchar"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["shortdesc"] = "Set the post-hyphenchar for implicit hyphenation.",
                ["type"] = "function"
            },
            ["preexhyphenchar"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["shortdesc"] = "Set the pre-hyphenchar for explicit hyphenation.",
                ["type"] = "function"
            },
            ["prehyphenchar"] = {
                ["arguments"] = {
                    {
                        ["name"] = "l",
                        ["optional"] = false,
                        ["type"] = "language"
                    },
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"}
                },
                ["shortdesc"] = "Set the pre-hyphenchar for implicit hyphenation.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["lfs"] = {
        ["functions"] = {
            ["isdir"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "Return true if the string is a directory.",
                ["type"] = "function"
            },
            ["isfile"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "Return true if the string is a file.",
                ["type"] = "function"
            },
            ["readlink"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Return the contents of a symlink (Unix only).",
                ["type"] = "function"
            },
            ["shortname"] = {
                ["arguments"] = {
                    {
                        ["name"] = "filename",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "fat",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Return the FAT name of a file (Windows only).",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["lua"] = {
        ["functions"] = {
            ["getbytecode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "f",
                        ["optional"] = false,
                        ["type"] = "function"
                    }
                },
                ["shortdesc"] = "Return a previously stored function from a bytecode register.",
                ["type"] = "function"
            },
            ["setbytecode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "f",
                        ["optional"] = false,
                        ["type"] = "function"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Save a function in a bytecode register.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["mp"] = {
        ["functions"] = {
            ["char_depth"] = {
                ["arguments"] = {
                    {
                        ["name"] = "fontname",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "char",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "w", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Report a character's depth.",
                ["type"] = "method"
            },
            ["char_height"] = {
                ["arguments"] = {
                    {
                        ["name"] = "fontname",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "char",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "w", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Report a character's height.",
                ["type"] = "method"
            },
            ["char_width"] = {
                ["arguments"] = {
                    {
                        ["name"] = "fontname",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "char",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "w", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Report a character's width.",
                ["type"] = "method"
            },
            ["execute"] = {
                ["arguments"] = {
                    {
                        ["name"] = "chunk",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "rettable",
                        ["optional"] = false,
                        ["type"] = "mpdata"
                    }
                },
                ["shortdesc"] = "Execute metapost code in the instance.",
                ["type"] = "method"
            },
            ["finish"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "rettable",
                        ["optional"] = false,
                        ["type"] = "mpdata"
                    }
                },
                ["shortdesc"] = "Finish a metapost instance.",
                ["type"] = "method"
            },
            ["statistics"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "stats",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Returns some statistics for this metapost instance.",
                ["type"] = "method"
            }
        },
        ["methods"] = {}
    },
    ["mplib"] = {
        ["functions"] = {
            ["new"] = {
                ["arguments"] = {
                    {
                        ["name"] = "options",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "mp",
                        ["optional"] = false,
                        ["type"] = "mpinstance"
                    }
                },
                ["shortdesc"] = "Create a new metapost instance.",
                ["type"] = "function"
            },
            ["version"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "v", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Returns the mplib version.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["node"] = {
        ["functions"] = {
            ["copy"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Copy a node.",
                ["type"] = "function"
            },
            ["copy_list"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Copy a node list.",
                ["type"] = "function"
            },
            ["count"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the count of nodes with a specific id in a node list. Processing stops just before the optional node.",
                ["type"] = "function"
            },
            ["dimensions"] = {
                ["arguments"] = {
                    {
                        ["name"] = "glue_set",
                        ["optional"] = true,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "glue_sign",
                        ["optional"] = true,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "glue_order",
                        ["optional"] = true,
                        ["type"] = "number"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "t", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "w", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "h", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "d", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the natural dimensions of a (horizontal) node list. The 3 optional numbers represent \
      glue_set, glue_sign, and glue_order. The calculation stops just before the optional node (default end of list)",
                ["type"] = "function"
            },
            ["fields"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "subid",
                        ["optional"] = true,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Report the fields a node type understands. The optional argument is needed for whatsits.",
                ["type"] = "function"
            },
            ["first_glyph"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Return the first character node in a list. Processing stops just before the optional node.",
                ["type"] = "function"
            },
            ["flush_list"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Release a list of nodes.",
                ["type"] = "function"
            },
            ["free"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Release a node.",
                ["type"] = "function"
            },
            ["has_attribute"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "val", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "v", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return an attribute value for a node, if it has one. The optional number tests for a specific value",
                ["type"] = "function"
            },
            ["has_field"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "field",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "Return true if the node understands the named field.",
                ["type"] = "function"
            },
            ["hpack"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "w", ["optional"] = true, ["type"] = "number"},
                    {
                        ["name"] = "info",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "dir", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "h", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "b", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Pack a node list into a horizontal list. The number is the desired size, the first string is either `exact` or `additional` (modifies the first string),\
      the second string is the desired direction",
                ["type"] = "function"
            },
            ["id"] = {
                ["arguments"] = {
                    {
                        ["name"] = "type",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Convert a node type string into a node id number.",
                ["type"] = "function"
            },
            ["insert_after"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "current",
                        ["optional"] = false,
                        ["type"] = "node"
                    },
                    {["name"] = "new", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "new", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Insert the third node just after the second node in the list that starts at the first node.",
                ["type"] = "function"
            },
            ["insert_before"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "current",
                        ["optional"] = false,
                        ["type"] = "node"
                    },
                    {["name"] = "new", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "new", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Insert the third node just before the second node in the list that starts at the first node.",
                ["type"] = "function"
            },
            ["is_node"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "any"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "yes",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Return true if the object is a <node>.",
                ["type"] = "function"
            },
            ["kerning"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "h", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "t", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Apply the internal kerning routine to a node list. Processing stops just before the optional node.",
                ["type"] = "function"
            },
            ["last_node"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Pops and returns the last node on the current output list.",
                ["type"] = "function"
            },
            ["length"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the length of a node list. Processing stops just before the optional node.",
                ["type"] = "function"
            },
            ["ligaturing"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "m", ["optional"] = true, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "h", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "t", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "success",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Apply the internal ligaturing routine to a node list. Processing stops just before the optional node.",
                ["type"] = "function"
            },
            ["mlist_to_hlist"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "displaytype",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "penalties",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "h", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Recursively convert a math list into a horizontal list. The string differentiates display and inline, the boolean\
      whether penalties are inserted",
                ["type"] = "function"
            },
            ["new"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "subid",
                        ["optional"] = true,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Create a new node with id and (optional) subtype.",
                ["type"] = "function"
            },
            ["protect_glyphs"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Mark all processed glyphs in a node list as being characters.",
                ["type"] = "function"
            },
            ["protrusion_skippable"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "yes",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Return true if the node could be skipped for protrusion purposes.",
                ["type"] = "function"
            },
            ["remove"] = {
                ["arguments"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "current",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "head", ["optional"] = false, ["type"] = "node"},
                    {
                        ["name"] = "current",
                        ["optional"] = false,
                        ["type"] = "node"
                    }
                },
                ["shortdesc"] = "Extract and remove a second node from the list that starts in the first node.",
                ["type"] = "function"
            },
            ["set_attribute"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "val",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an attribute value for a node.",
                ["type"] = "function"
            },
            ["slide"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Move to the last node of a list while fixing next and prev pointers.",
                ["type"] = "function"
            },
            ["next"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Returns the next node.",
                ["type"] = "function"
            },
            ["prev"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Returns the previous node.",
                ["type"] = "function"
            },
            ["subtype"] = {
                ["arguments"] = {
                    {
                        ["name"] = "type",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "subtype",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Convert a whatsit type string into  a node subtype number.",
                ["type"] = "function"
            },
            ["tail"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "m", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Return the last node in a list.",
                ["type"] = "function"
            },
            ["traverse"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Iterate over a node list.",
                ["type"] = "function"
            },
            ["traverse_id"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Iterate over nodes with id matching the number in a node list.",
                ["type"] = "function"
            },
            ["type"] = {
                ["arguments"] = {
                    {["name"] = "id", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "type",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "convert a node id number into a node type string.",
                ["type"] = "function"
            },
            ["types"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Return the list of node types.",
                ["type"] = "function"
            },
            ["unprotect_glyphs"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Mark all characters in a node list as being processed glyphs.",
                ["type"] = "function"
            },
            ["unset_attribute"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "val", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "v", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Unset an attribute value for a node. The optional number tests for a specific value",
                ["type"] = "function"
            },
            ["vpack"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "w", ["optional"] = true, ["type"] = "number"},
                    {
                        ["name"] = "info",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "dir", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "h", ["optional"] = false, ["type"] = "node"},
                    {["name"] = "b", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Pack a node list into a vertical list. Arguments as for node.hpack",
                ["type"] = "function"
            },
            ["whatsits"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Return the list of whatsit types.",
                ["type"] = "function"
            },
            ["write"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Appends a node to the current output list.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["os"] = {
        ["functions"] = {
            ["exec"] = {
                ["arguments"] = {
                    {
                        ["name"] = "command",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "      Run an external command and exit. The table is an array of arguments, with an optional `argv[0]` in index 0.",
                ["type"] = "function"
            },
            ["gettimeofday"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "time",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Get the time as a floating point number (Unix only).",
                ["type"] = "function"
            },
            ["setenv"] = {
                ["arguments"] = {
                    {
                        ["name"] = "key",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "value",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an environment variable.",
                ["type"] = "function"
            },
            ["spawn"] = {
                ["arguments"] = {
                    {
                        ["name"] = "command",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "succ",
                        ["optional"] = false,
                        ["type"] = "boolean"
                    }
                },
                ["shortdesc"] = "Run an external command and return its exit code. The table is an array of arguments, with an optional `argv[0]` in index 0.",
                ["type"] = "function"
            },
            ["times"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "times",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Return process times.",
                ["type"] = "function"
            },
            ["tmpdir"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "d", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Create a temporary directory inside the current directory.",
                ["type"] = "function"
            },
            ["selfdir"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "d", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Return the directory path of argv[0].",
                ["type"] = "function"
            },
            ["uname"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "data",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Return various information strings about the computer.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["pdf"] = {
        ["functions"] = {
            ["immediateobj"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"},
                    {
                        ["name"] = "type",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "objtext",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "extradata",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Write an object to the PDF file immediately. The optional number is an object id,\
      the first optional string is `{file}}, `{stream}}, or `{filestream}}.\
      the second optional string contains stream attributes for the latter two cases.\
      ",
                ["type"] = "function"
            },
            ["obj"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"},
                    {
                        ["name"] = "type",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "objtext",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "extradata",
                        ["optional"] = true,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Write an object to the PDF file. See `pdf.immediateobj` for arguments.",
                ["type"] = "function"
            },
            ["refobj"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Reference an object, so that it will be written out.",
                ["type"] = "function"
            },
            ["print"] = {
                ["arguments"] = {
                    {
                        ["name"] = "type",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Write directly to the PDF file (use in `latelua}). The optional string is\
      one of `{direct}` or `{page}}",
                ["type"] = "function"
            },
            ["registerannot"] = {
                ["arguments"] = {
                    {
                        ["name"] = "objnum",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Register an annotation in the PDF backend.",
                ["type"] = "function"
            },
            ["pageref"] = {
                ["arguments"] = {
                    {
                        ["name"] = "objnum",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "page",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["shortdesc"] = "Return the pageref object number.",
                ["type"] = "function"
            },

            ["mapfile"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Register a font map file.",
                ["type"] = "function"
            },

            ["mapline"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Register a font map line.",
                ["type"] = "function"
            },

            ["reserveobj"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Reserve an object number in the PDF backend.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["status"] = {
        ["functions"] = {
            ["list"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {
                        ["name"] = "info",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["shortdesc"] = "Returns a table with various status items.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["string"] = {
        ["functions"] = {
            ["bytepairs"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "m", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Iterator that returns two values representing two single 8-byte tokens.",
                ["type"] = "function"
            },
            ["bytes"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Iterator that returns a value representing a single 8-byte token.",
                ["type"] = "function"
            },
            ["characterpairs"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "t", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Iterator that returns two strings representing two single \\UTF-8 tokens.",
                ["type"] = "function"
            },
            ["characters"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Iterator that returns a string representing a single 8-byte token.",
                ["type"] = "function"
            },
            ["explode"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "sep", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Break a string into pieces. The optional argument is a character possibly followed by a plus sign (default `{ +}})",
                ["type"] = "function"
            },
            ["utfcharacters"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Iterator that returns a string representing a single \\UTF-8 token.",
                ["type"] = "function"
            },
            ["utfvalues"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Iterator that returns a value representing a single \\UTF-8 token.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["tex"] = {
        ["functions"] = {
            ["badness"] = {
                ["arguments"] = {
                    {["name"] = "f", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "b", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Compute a badness value.",
                ["type"] = "function"
            },
            ["definefont"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "boolean"
                    },
                    {
                        ["name"] = "csname",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "fontid",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Define a font csname. The optional boolean indicates for global definition, the string is the csname, the number is a font id.",
                ["type"] = "function"
            },
            ["enableprimitives"] = {
                ["arguments"] = {
                    {
                        ["name"] = "prefix",
                        ["optional"] = false,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "names",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Enable the all primitives in the array using the string as prefix.",
                ["type"] = "function"
            },
            ["error"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"},
                    {
                        ["name"] = "helptext",
                        ["optional"] = true,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Create an error that is presented to the user. The optional table is an array of help message strings.",
                ["type"] = "function"
            },
            ["extraprimitives"] = {
                ["arguments"] = {
                    {["name"] = "s1", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "s2", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Return all primitives in a (set of) extension identifiers. Valid identifiers are: \
      `tex}, `core}, `etex}, `pdftex}, `omega}, `aleph}, and `luatex}.",
                ["type"] = "function"
            },
            ["get"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "v", ["optional"] = false, ["type"] = "value"}
                },
                ["shortdesc"] = "Get a named internal register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["getattribute"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get an attribute register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["getbox"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Get a box register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["getcount"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get a count register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["getdimen"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get a dimen register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["getmath"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "t", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get an internal math parameter. The first string is like the csname but without the `Umath` prefix, the second string is a style name minus the `style` suffix.",
                ["type"] = "function"
            },
            ["getskip"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "node"}
                },
                ["shortdesc"] = "Get a skip register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["gettoks"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["shortdesc"] = "Get a toks register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },

            ["getlccode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get a lowercase code.",
                ["type"] = "function"
            },

            ["setlccode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "lc", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "uc", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a lowercase code.",
                ["type"] = "function"
            },

            ["getuccode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get an uppercase code.",
                ["type"] = "function"
            },
            ["setuccode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "uc", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "lc", ["optional"] = true, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an uppercase code.",
                ["type"] = "function"
            },
            ["getsfcode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get a space factor.",
                ["type"] = "function"
            },
            ["setsfcode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "sf", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a space factor.",
                ["type"] = "function"
            },

            ["getcatcode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "cattable",
                        ["optional"] = true,
                        ["type"] = "number"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "c", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Get a category code.",
                ["type"] = "function"
            },

            ["setcatcode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {
                        ["name"] = "cattable",
                        ["optional"] = true,
                        ["type"] = "number"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "c", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a category code.",
                ["type"] = "function"
            },

            ["getmathcode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Get a math code.",
                ["type"] = "function"
            },

            ["setmathcode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "mval",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a math code.",
                ["type"] = "function"
            },

            ["getdelcode"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Get a delimiter code.",
                ["type"] = "function"
            },

            ["setdelcode"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "mval",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a delimiter code.",
                ["type"] = "function"
            },

            ["linebreak"] = {
                ["arguments"] = {
                    {
                        ["name"] = "listhead",
                        ["optional"] = false,
                        ["type"] = "node"
                    },
                    {
                        ["name"] = "parameters",
                        ["optional"] = false,
                        ["type"] = "table"
                    }
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Run the line breaker on a node list. The table lists settings.",
                ["type"] = "function"
            },
            ["primitives"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "table"}
                },
                ["shortdesc"] = "Returns a table of all currently active primitives, with their meaning.",
                ["type"] = "function"
            },
            ["print"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"},
                    {["name"] = "s1", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "s2", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "      Print a sequence of strings (not just two) as lines. The optional argument is a catcode table id.",
                ["type"] = "function"
            },
            ["round"] = {
                ["arguments"] = {
                    {["name"] = "o", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Round a number.",
                ["type"] = "function"
            },
            ["scale"] = {
                ["arguments"] = {
                    {["name"] = "o", ["optional"] = false, ["type"] = "number"},
                    {
                        ["name"] = "delta",
                        ["optional"] = false,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Multiplies the first number (or all fields in a table) with the second argument (if the first argument is a table, so is the return value).",
                ["type"] = "function"
            },
            ["set"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "v", ["optional"] = false, ["type"] = "value"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a named internal register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["setattribute"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an attribute register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["setbox"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a box register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["setcount"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a count register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["setdimen"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a dimen register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["setmath"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "t", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set an internal math parameter. The first string is like the csname but without the `Umath` prefix, the second string is a style name minus the `style` suffix.",
                ["type"] = "function"
            },
            ["setskip"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "node"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a skip register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["settoks"] = {
                ["arguments"] = {
                    {
                        ["name"] = "global",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"},
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Set a toks register. Also accepts a predefined csname string.",
                ["type"] = "function"
            },
            ["shipout"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Ships the box to the output file and clears the box.",
                ["type"] = "function"
            },
            ["sp"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {
                    {["name"] = "n", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Convert a dimension string to scaled points.",
                ["type"] = "function"
            },
            ["sprint"] = {
                ["arguments"] = {
                    {["name"] = "n", ["optional"] = true, ["type"] = "number"},
                    {["name"] = "s1", ["optional"] = false, ["type"] = "string"},
                    {["name"] = "s2", ["optional"] = true, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "      Print a sequence of strings (not just two) as partial lines. The optional argument is a catcode table id.",
                ["type"] = "function"
            },
            ["tprint"] = {
                ["arguments"] = {
                    {["name"] = "a1", ["optional"] = false, ["type"] = "table"},
                    {["name"] = "a2", ["optional"] = true, ["type"] = "table"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Combine any number of `tex.sprint}'s into a single function call.",
                ["type"] = "function"
            },
            ["write"] = {
                ["arguments"] = {
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "      Print a sequence of strings (not just two) as detokenized data.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["texio"] = {
        ["functions"] = {
            ["write"] = {
                ["arguments"] = {
                    {
                        ["name"] = "target",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Write a string to the log and/or terminal. The optional argument is\
      `{term}}, `{term and log}}, or `{log}}.",
                ["type"] = "function"
            },
            ["write_nl"] = {
                ["arguments"] = {
                    {
                        ["name"] = "target",
                        ["optional"] = true,
                        ["type"] = "string"
                    },
                    {["name"] = "s", ["optional"] = false, ["type"] = "string"}
                },
                ["returnvalues"] = {},
                ["shortdesc"] = "Write a string to the log and/or terminal, starting on a new line. \
      The optional argument is \
      `{term}}, `{term and log}}, or `{log}}.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    },
    ["token"] = {
        ["functions"] = {
            ["command_id"] = {
                ["arguments"] = {
                    {
                        ["name"] = "commandname",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Return the internal number representing a command code.",
                ["type"] = "function"
            },
            ["command_name"] = {
                ["arguments"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "commandname",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Return the internal string representing a command code.",
                ["type"] = "function"
            },
            ["create"] = {
                ["arguments"] = {
                    {
                        ["name"] = "char",
                        ["optional"] = false,
                        ["type"] = "number"
                    },
                    {
                        ["name"] = "catcode",
                        ["optional"] = true,
                        ["type"] = "number"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["shortdesc"] = "Create a token from scratch, the optional argument is a category code. Also accepts strings, in which case a token matching that csname is created.",
                ["type"] = "function"
            },
            ["csname_id"] = {
                ["arguments"] = {
                    {
                        ["name"] = "csname",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["returnvalues"] = {
                    {["name"] = "i", ["optional"] = false, ["type"] = "number"}
                },
                ["shortdesc"] = "Returns the value for a csname string.",
                ["type"] = "function"
            },
            ["csname_name"] = {
                ["arguments"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["returnvalues"] = {
                    {
                        ["name"] = "csname",
                        ["optional"] = false,
                        ["type"] = "string"
                    }
                },
                ["shortdesc"] = "Return the csname associated with a token.",
                ["type"] = "function"
            },
            ["expand"] = {
                ["arguments"] = {},
                ["returnvalues"] = {},
                ["shortdesc"] = "Expand a token the tokenb waiting in the input stream.",
                ["type"] = "function"
            },
            ["get_next"] = {
                ["arguments"] = {},
                ["returnvalues"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["shortdesc"] = "Fetch the next token from the input stream.",
                ["type"] = "function"
            },
            ["is_activechar"] = {
                ["arguments"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["returnvalues"] = {
                    {["name"] = "b", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "True if the token represents and active character.",
                ["type"] = "function"
            },
            ["is_expandable"] = {
                ["arguments"] = {
                    {["name"] = "t", ["optional"] = false, ["type"] = "token"}
                },
                ["returnvalues"] = {
                    {["name"] = "b", ["optional"] = false, ["type"] = "boolean"}
                },
                ["shortdesc"] = "True if the token is expandable.",
                ["type"] = "function"
            }
        },
        ["methods"] = {}
    }
}

return fdata;
