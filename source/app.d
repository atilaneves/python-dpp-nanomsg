import autowrap;
mixin(wrapDlang!(LibraryName("nanomsg"), Modules(Yes.alwaysExport, "nanomsg")));
