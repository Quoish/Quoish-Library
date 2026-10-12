$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path
$utf8 = [Text.UTF8Encoding]::new($false)
$tagPattern = '(?<![#\\\p{L}\p{N}_])#[\p{L}\p{N}_/-]+'
$pureTagLinePattern = '^\s*(?:#[\p{L}\p{N}_/-]+\s*)+$'
$filesChanged = 0
$tagsRemoved = 0
$pureLinesRemoved = 0

foreach ($file in Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md') {
    $text = [IO.File]::ReadAllText($file.FullName, $utf8)
    $frontMatch = [regex]::Match(
        $text,
        '\A---\r?\n(?<yaml>.*?)\r?\n---\r?\n',
        [Text.RegularExpressions.RegexOptions]::Singleline
    )
    if (-not $frontMatch.Success) {
        throw "缺少属性区：$($file.FullName)"
    }

    $front = $frontMatch.Value
    $body = $text.Substring($frontMatch.Length)
    $headingCountBefore = [regex]::Matches($body, '(?m)^#{1,6}\s+').Count

    $newBody = [regex]::Replace(
        $body,
        '(?m)^(?<content>[^\r\n]*)(?<eol>\r?\n|$)',
        {
            param($lineMatch)
            $content = $lineMatch.Groups['content'].Value
            $eol = $lineMatch.Groups['eol'].Value
            $hits = [regex]::Matches($content, $tagPattern)
            if ($hits.Count -eq 0) {
                return $lineMatch.Value
            }

            $script:tagsRemoved += $hits.Count
            if ([regex]::IsMatch($content, $pureTagLinePattern)) {
                $script:pureLinesRemoved++
                return ''
            }

            $cleaned = [regex]::Replace($content, $tagPattern, '')
            $cleaned = [regex]::Replace($cleaned, '[ \t]+$', '')
            $cleaned = [regex]::Replace($cleaned, '^[ \t]+(?=\S)', '')
            return $cleaned + $eol
        }
    )

    if ($newBody -cne $body) {
        $headingCountAfter = [regex]::Matches($newBody, '(?m)^#{1,6}\s+').Count
        if ($headingCountAfter -ne $headingCountBefore) {
            throw "Markdown 标题数量发生变化：$($file.FullName)"
        }

        $created = $file.CreationTime
        $updated = $file.LastWriteTime
        [IO.File]::WriteAllText($file.FullName, $front + $newBody, $utf8)
        $file.CreationTime = $created
        $file.LastWriteTime = $updated
        $filesChanged++

        $check = [IO.File]::ReadAllText($file.FullName, $utf8)
        if (-not $check.StartsWith($front, [StringComparison]::Ordinal)) {
            throw "属性区发生变化：$($file.FullName)"
        }
    }
}

"Changed $filesChanged files; removed $tagsRemoved tags and $pureLinesRemoved tag-only lines."
