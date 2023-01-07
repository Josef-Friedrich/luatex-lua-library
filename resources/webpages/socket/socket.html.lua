---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
---    "http://www.w3.org/TR/html4/strict.dtd">
---
---
---
---
---
---LuaSocket: The socket namespace
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---Network support for the Lua language
---
---
---
---home&middot;
---download&middot;
---installation&middot;
---introduction&middot;
---reference
---
---
---
---
---
---
---
---The socket namespace
---
---
---The `socket` namespace contains the core functionality of LuaSocket.
---
---
---
---To obtain the `socket` namespace, run:
---
---
---```
----- loads the socket module
---local socket = require("socket")
---```
---
---
---
---
---socket.headers.canonic
---
---The `socket.headers.canonic` table
---is used by the HTTP and SMTP modules to translate from
---lowercase field names back into their canonic
---capitalization. When a lowercase field name exists as a key
---in this table, the associated value is substituted in
---whenever the field name is sent out.
---
---
---
---You can obtain the `headers` namespace if case run-time
---modifications are required by running:
---
---
---```
----- loads the headers module
---local headers = require("headers")
---```
---
---
---
---
---
---socket.bind(address, port [, backlog])
---
---
---
---This function is a shortcut that creates and returns a TCP server object
---bound to a local `address` and `port`, ready to
---accept client connections. Optionally,
---user can also specify the `backlog` argument to the
---`listen`method (defaults to 32).
---
---
---
---Note: The server object returned will have the option "`reuseaddr`"
---set to `true`.
---
---
---
---
---
---socket.connect[46](address, port [, locaddr] [, locport] [, family])
---
---
---
---This function is a shortcut that creates and returns a TCP client object
---connected to a remote `address` at a given `port`. Optionally,
---the user can also specify the local address and port to bind
---(`locaddr` and `locport`), or restrict the socket family
---to "`inet`" or "`inet6`".
---Without specifying `family` to `connect`, whether a tcp or tcp6
---connection is created depends on your system configuration. Two variations
---of connect are defined as simple helper functions that restrict the
---`family`, `socket.connect4` and `socket.connect6`.
---
---
---
---
---
---socket._DEBUG
---
---
---
---This constant is set to `true` if the library was compiled
---with debug support.
---
---
---
---
---
---socket._DATAGRAMSIZE
---
---
---
---Default datagram size used by calls to
---`receive`and
---`receivefrom`.
---(Unless changed in compile time, the value is 8192.)
---
---
---
---
---
---socket.gettime()
---
---
---
---Returns the UNIX time in seconds. You should subtract the values returned by this function
---to get meaningful values.
---
---
---```
---t = socket.gettime()
----- do stuff
---print(socket.gettime() - t .. " seconds elapsed")
---```
---
---
---
---
---socket.newtry(finalizer)
---
---
---
---Creates and returns a clean
---`try`
---function that allows for cleanup before the exception
---is  raised.
---
---
---
---`Finalizer` is a function that will be called before
---`try` throws the exception.
---
---
---
---The function returns your customized `try` function.
---
---
---
---Note: This idea saved a lotof work with the
---implementation of protocols in LuaSocket:
---
---
---```
---foo = socket.protect(function()
---    -- connect somewhere
---    local c = socket.try(socket.connect("somewhere", 42))
---    -- create a try function that closes 'c' on error
---    local try = socket.newtry(function() c:close() end)
---    -- do everything reassured c will be closed
---    try(c:send("hello there?\r\n"))
---    local answer = try(c:receive())
---    ...
---    try(c:send("good bye\r\n"))
---    c:close()
---end)
---```
---
---
---
---
---
---socket.protect(func)
---
---
---
---Converts a function that throws exceptions into a safe function. This
---function only catches exceptions thrown by the `try`
---and `newtry`functions. It does not catch normal
---Lua errors.
---
---
---
---`Func` is a function that calls
---`try`(or `assert`, or `error`)
---to throw exceptions.
---
---
---
---Returns an equivalent function that instead of throwing exceptions in case of
---a failed `try`call, returns `nil`
---followed by an error message.
---
---
---
---
---
---socket.select(recvt, sendt [, timeout])
---
---
---
---Waits for a number of sockets to change status.
---
---
---
---`Recvt` is an array with the sockets to test for characters
---available for reading. Sockets in the `sendt` array are watched to
---see if it is OK to immediately write on them.  `Timeout` is the
---maximum amount of time (in seconds) to wait for a change in status.  A
---`nil`, negative or omitted `timeout` value allows the
---function to block indefinitely. `Recvt` and `sendt` can also
---be empty tables or `nil`. Non-socket values (or values with
---non-numeric indices) in the arrays will be silently ignored.
---
---
---The function returns a list with the sockets ready for
---reading, a list with the sockets ready for writing and an error message.
---The error message is "`timeout`" if a timeout
---condition was met, "`select failed`" if the call
---to `select` failed, and
---`nil` otherwise. The returned tables are
---doubly keyed both by integers and also by the sockets
---themselves, to simplify the test if a specific socket has
---changed status.
---
---
---
---Note:`select` can monitor a limited number
---of sockets, as defined by the constant 
---`socket._SETSIZE`. This
---number may be as high as 1024 or as low as 64 by default,
---depending on the system. It is usually possible to change this
---at compile time. Invoking `select` with a larger
---number of sockets will raise an error.
---
---
---
---Important note: a known bug in WinSock causes `select` to fail
---on non-blocking TCP sockets. The function may return a socket as
---writable even though the socket is notready for sending.
---
---
---
---Another important note: calling select with a server socket in the receive parameter before a call to accept does notguarantee
---`accept`will return immediately.
---Use the `settimeout`
---method or `accept` might block forever.
---
---
---
---Yet another note: If you close a socket and pass
---it to `select`, it will be ignored.
---
---
---
---Using select with non-socket objects: Any object that implements `getfd` and `dirty` can be used with `select`, allowing objects from other libraries to be used within a `socket.select` driven loop.
---
---
---
---
---
---socket._SETSIZE
---
---
---
---The maximum number of sockets that the <a
---href="#select">`select`function can handle.
---
---
---
---
---
---
---socket.sink(mode, socket)
---
---
---
---Creates an
---LTN12
---sink from a stream socket object.
---
---
---
---`Mode` defines the behavior of the sink. The following
---options are available:
---
---
---* `"http-chunked"`: sends data through socket after applying the
---chunked transfer coding, closing the socket when done;
---* `"close-when-done"`: sends all received data through the
---socket, closing the socket when done;
---* `"keep-open"`: sends all received data through the
---socket, leaving it open when done.
---
---
---`Socket` is the stream socket object used to send the data.
---
---
---
---The function returns a sink with the appropriate behavior.
---
---
---
---
---
---socket.skip(d [, ret1, ret2...  retN])
---
---
---
---Drops a number of arguments and returns the remaining.
---
---
---
---`D` is the number of arguments to drop. `Ret1` to
---`retN` are the arguments.
---
---
---
---The function returns `retd+1` to `retN`.
---
---
---
---Note: This function is useful to avoid creation of dummy variables:
---
---
---```
----- get the status code and separator from SMTP server reply
---local code, sep = socket.skip(2, string.find(line, "^(%d%d%d)(.?)"))
---```
---
---
---
---
---socket.sleep(time)
---
---
---
---Freezes the program execution during a given amount of time.
---
---
---
---`Time` is the number of seconds to sleep for. If
---`time` is negative, the function returns immediately.
---
---
---
---
---
---socket.source(mode, socket [, length])
---
---
---
---Creates an
---LTN12
---source from a stream socket object.
---
---
---
---`Mode` defines the behavior of the source. The following
---options are available:
---
---
---* `"http-chunked"`: receives data from socket and removes the
---chunked transfer codingbefore returning the data;
---* `"by-length"`: receives a fixed number of bytes from the
---socket. This mode requires the extra argument `length`;
---* `"until-closed"`: receives data from a socket until the other
---side closes the connection.
---
---
---`Socket` is the stream socket object used to receive the data.
---
---
---
---The function returns a source with the appropriate behavior.
---
---
---
---
---
---socket._SOCKETINVALID
---
---
---
---The OS value for an invalid socket. This can be used with 
---`tcp:getfd`and `tcp:setfd`methods.
---
---
---
---
---
---socket.try(ret1[, ret2... retN])
---
---
---
---Throws an exception in case `ret1` is falsy, using
---`ret2` as the error message. The exception is supposed to be caught
---by a `protect`ed function only.
---
---
---
---`Ret1` to `retN` can be arbitrary
---arguments, but are usually the return values of a function call
---nested with `try`.
---
---
---
---The function returns `ret`1to `ret`Nif
---`ret`1is not `nil` or `false`.
---Otherwise, it calls `error` passing `ret`2wrapped
---in a table with metatable used by `protect`to
---distinguish exceptions from runtime errors.
---
---
---```
----- connects or throws an exception with the appropriate error message
---c = socket.try(socket.connect("localhost", 80))
---```
---
---
---
---
---socket._VERSION
---
---
---
---This constant has a string describing the current LuaSocket version.
---
---
---
---
---
---
---
---
---home&middot;
---download&middot;
---installation&middot;
---introduction&middot;
---reference
---
---
---
---Last modified by Diego Nehab on 
---Thu Apr 20 00:25:54 EDT 2006
---
---
---
---
---
---
---
---