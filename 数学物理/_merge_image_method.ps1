$ErrorActionPreference = 'Stop'

$sourceFile = '镜像法.md'
$targetFile = '静态电磁场.md'

$sourceText = Get-Content -LiteralPath $sourceFile -Raw
$sourceBody = [regex]::Replace(
    $sourceText,
    '\A---\r?\n.*?\r?\n---\r?\n?',
    '',
    [System.Text.RegularExpressions.RegexOptions]::Singleline
)
$sourceBody = [regex]::Replace(
    $sourceBody,
    '(?m)^(#{1,4})(?= )',
    { param($match) '##' + $match.Value }
)

$targetText = Get-Content -LiteralPath $targetFile -Raw
$targetText = [regex]::Replace(
    $targetText,
    '(?m)^aliases:\s*\[\]\s*$',
    "aliases:`r`n  - 镜像法"
)
$targetText = [regex]::Replace(
    $targetText,
    '(?m)^updated:\s*.*$',
    'updated: 2026-10-13'
)

$marker = '## 无源静电场和恒定电流场'
if (-not $targetText.Contains($marker)) {
    throw "Insertion marker not found: $marker"
}
$section = "## 镜像法`r`n$($sourceBody.TrimEnd())`r`n"
$targetText = $targetText.Replace($marker, $section + $marker)

$pattern = '\[\[镜像法(?<anchor>#[^\]|]+)?(?<label>\|[^\]]+)?\]\]'
$targetText = [regex]::Replace($targetText, $pattern, {
    param($match)
    $anchor = $match.Groups['anchor'].Value
    $label = $match.Groups['label'].Value
    if ([string]::IsNullOrEmpty($anchor)) {
        return '[[静态电磁场#镜像法|镜像法]]'
    }
    return '[[静态电磁场' + $anchor + $label + ']]'
})
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $targetFile), $targetText, [System.Text.UTF8Encoding]::new($false))

$markdownFiles = Get-ChildItem -LiteralPath . -Filter '*.md' -File -Recurse | Where-Object {
    $_.Name -ne $sourceFile -and $_.Name -ne $targetFile
}
foreach ($file in $markdownFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw
    $updated = [regex]::Replace($text, $pattern, {
        param($match)
        $anchor = $match.Groups['anchor'].Value
        $label = $match.Groups['label'].Value
        if ([string]::IsNullOrEmpty($anchor)) {
            return '[[静态电磁场#镜像法|镜像法]]'
        }
        return '[[静态电磁场' + $anchor + $label + ']]'
    })
    if ($updated -ne $text) {
        [System.IO.File]::WriteAllText($file.FullName, $updated, [System.Text.UTF8Encoding]::new($false))
    }
}
