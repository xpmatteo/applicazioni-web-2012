import java.io.*;
import java.util.*;

public class HelloServer extends NanoHTTPD {
	public HelloServer() throws IOException {
		super(8080, new File("."));
	}

	public Response serve(String uri, String method, Properties headers, Properties parameters, Properties files) {
		String body = "<em>Hello, <strong>world!</strong></em>";
		return new NanoHTTPD.Response(HTTP_OK, "text/plain", body);
	}

	public static void main(String[] args) {
		try {
			new HelloServer();
		} catch (IOException exception) {
			System.err.println("Couldn't start server:\n" + exception);
			System.exit(-1);
		}
		System.out.println("Listening on port 8080. Hit Enter to stop.\n");
		try {
			System.in.read();
		} catch (Throwable t) {};
	}
}
