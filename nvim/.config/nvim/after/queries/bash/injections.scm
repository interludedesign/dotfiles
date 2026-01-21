; Inject SQL syntax highlighting into psql heredocs
((heredoc_redirect
  (heredoc_body) @injection.content)
  (#set! injection.language "sql"))

; Alternative: match heredoc_body directly
((heredoc_body) @injection.content
  (#set! injection.language "sql"))
