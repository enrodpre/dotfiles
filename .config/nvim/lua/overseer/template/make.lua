return {
  name = "make",
  builder = function()
    local cmd = { "cmake", "--build", "--preset", "dev-test" }
    return {
      cmd = cmd,
      {
        "on_output_quickfix",
        set_diagnostics = true
      },
      "on_result_diagnostics",
      "default",
    }
  end
}
