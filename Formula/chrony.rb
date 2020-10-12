class Chrony < Formula
  desc "Versatile implementation of the Network Time Protocol (NTP)"
  homepage "https://chrony.tuxfamily.org"
  url "https://download.tuxfamily.org/chrony/chrony-4.0.tar.gz"
  sha256 "be27ea14c55e7a4434b2fa51d53018c7051c42fa6a3198c9aa6a1658bae0c625"
  license "GPL-2.0-only"

  bottle do
    cellar :any_skip_relocation
    sha256 "16e6a0020f088989b22e80f191718c41a98bc715718d29b0b3612ca5bdbb412c" => :catalina
    sha256 "30feb201dbe7b055636a862a497650c6331eecc06fcacdef22b605596339a236" => :mojave
    sha256 "ba4e1767836ab20111bc9502ff72d0adf4d436c154ff1464d9c1136905503ba6" => :high_sierra
  end

  depends_on "nettle"

  uses_from_macos "libedit"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--localstatedir=#{var}"
    system "make", "install"
  end

  test do
    (testpath/"test.conf").write "pool pool.ntp.org iburst\n"
    output = shell_output(sbin/"chronyd -Q -f #{testpath}/test.conf 2>&1")
    assert_match /System clock wrong by -?\d+\.\d+ seconds \(ignored\)/, output
  end
end
