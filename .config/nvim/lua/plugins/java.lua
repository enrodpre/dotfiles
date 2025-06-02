return {
  {
    "nvim-java/nvim-java",
    pattern = "*.java",
    lazy = true,
    opts = { jdk = { auto_install = false, }, },
  },
  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec", },
    pattern = "*.java",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      executable = "/home/kike/.netbeans/dev/maven/bin/mvn",
      commands = {
        { cmd = { "spring-boot:run", },                           desc = "run spring", },
        { cmd = { "spring-boot:run", "-Dmaven.test.skip=true", }, desc = "run spring no tests", },

      },
    },
  },
}
