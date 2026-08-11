{
  plugins = {
    jdtls.enable = true;
    typst-preview = {
      enable = true;
      settings.dependencies_bin.tinymist = "tinymist";
    };
    vimtex = {
      enable = true;
      settings = {
        view_method = "zathura";
        compiler_method = "latexmk";
        compiler_latexmk.aux_dir = ".build";
      };
    };
    texpresso.enable = true;
  };
}
