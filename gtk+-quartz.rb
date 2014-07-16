require 'formula'

class GtkxQuartz < Formula
  homepage 'http://www.gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.11.tar.xz'
  sha256 '328b4ea19a61040145e777e2ac49820968a382ac8581a380c9429897881812a9' 

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'jasper' => :optional
  depends_on 'atk'

  depends_on 'ryanhope/quartz/pango-quartz'

  keg_only 'This formula builds Gtk+ for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Undefined symbols when linking', :build => '2326' unless MacOS.lion?

  def install
    ENV.append 'LDFLAGS', '-framework Carbon -framework Cocoa'

    system './configure', "--prefix=#{prefix}",
                          '--disable-debug', '--disable-dependency-tracking',
                          '--disable-glibtest', '--with-gdktarget=quartz', '--disable-introspection'
    system 'make install'
  end

  def test
    system '#{bin}/gtk-demo'
  end
end
