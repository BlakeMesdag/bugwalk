class GithubHTML < Redcarpet::Render::HTML
  GITHUB_URL = "https://github.com/"

  def gfm(text)
    # Extract pre blocks
    extractions = {}
    text.gsub!(%r{<pre>.*?</pre>}m) do |match|
      md5 = Digest::MD5.hexdigest(match)
      extractions[md5] = match
      "{gfm-extraction-#{md5}}"
    end

    # prevent foo_bar_baz from ending up with an italic word in the middle
    text.gsub!(/(^(?! {4}|\t)\w+_\w+_\w[\w_]*)/) do |x|
      x.gsub('_', '\_') if x.split('').sort.to_s[0..1] == '__'
    end

    # in very clear cases, let newlines become <br /> tags
    text.gsub!(/^[\w\<][^\n]*\n+/) do |x|
      x =~ /\n{2}/ ? x : (x.strip!; x << "  \n")
    end

    # Insert pre block extractions
    text.gsub!(/\{gfm-extraction-([0-9a-f]{32})\}/) do
      "\n\n" + extractions[$1]
    end

    text
  end

  def link_repos(text)
    text.gsub!(/\w+\/\w+#\d+/i) do |match|
      parts = match.split("/")
      parts[1] = parts[1].split("#")
      "<a href=\"#{GITHUB_URL}#{parts[0]}/#{parts[1][0]}/issues/#{parts[1][1]}\">#{match}</a>"
    end

    text
  end

  def link_usernames(text)
    text.gsub!(/(^|\s)@{1}[a-z0-9\-]{1,}($|\s)/i) do |match|
      "<a href=\"#{GITHUB_URL}#{match.gsub(/@/, "")}\">#{match}</a>"
    end

    text
  end

  def preprocess(text)
    link_repos(text)
    link_usernames(text)

    text
  end

  def postprocess(text)
    gfm(text)

    test
  end
  
end