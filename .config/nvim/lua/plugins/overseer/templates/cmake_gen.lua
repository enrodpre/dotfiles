return {
  name = "generate cmake",
  builder = function()
    local cmd = { "cmake", "--preset", "dev-test" }
    return {
      cmd = cmd,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end
}
