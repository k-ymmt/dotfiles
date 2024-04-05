function eight_build_dir() {
  build_dir=$(xcodebuild -showBuildSettings -scheme Eight -workspace Eight.xcworkspace -json 2>/dev/null | jq -r ".[0].buildSettings.BUILD_DIR")
  cd "$build_dir"
}
