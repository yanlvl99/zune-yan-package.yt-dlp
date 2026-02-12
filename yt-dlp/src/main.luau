-- yt-dlp.luau
-- A complete, strongly typed wrapper for the yt-dlp command-line tool.
-- Provides video/audio downloading, metadata extraction, format selection,
-- playlist handling, subtitle management, and auto-installation via multiple package managers.
-- Author: yanlvl99 (GitHub)
-- Version: 1.0
-- License: MIT

--[=[
    Result of a yt-dlp command execution.
    Contains the exit status and captured output.
]=]
export type ExecResult = {
    --[=[
        Whether the command executed successfully (exit code 0).
    ]=]
    ok: boolean,

    --[=[
        Standard output captured from the command.
    ]=]
    stdout: string,

    --[=[
        Standard error output captured from the command.
    ]=]
    stderr: string,

    --[=[
        Process exit code. 0 means success.
    ]=]
    code: number,
}

--[=[
    Video/audio format information returned by yt-dlp.
]=]
export type FormatInfo = {
    --[=[
        Format identifier used for selection (e.g., "137", "bestaudio").
    ]=]
    format_id: string?,

    --[=[
        Human-readable format description.
    ]=]
    format: string?,

    --[=[
        File extension (e.g., "mp4", "webm", "m4a").
    ]=]
    ext: string?,

    --[=[
        Video resolution string (e.g., "1920x1080").
    ]=]
    resolution: string?,

    --[=[
        Video bitrate in kbps.
    ]=]
    vbr: number?,

    --[=[
        Audio bitrate in kbps.
    ]=]
    abr: number?,

    --[=[
        Total bitrate in kbps.
    ]=]
    tbr: number?,

    --[=[
        Frames per second.
    ]=]
    fps: number?,

    --[=[
        Video codec name (e.g., "h264", "vp9", "av01").
    ]=]
    vcodec: string?,

    --[=[
        Audio codec name (e.g., "aac", "opus", "mp3").
    ]=]
    acodec: string?,

    --[=[
        File size in bytes (if known).
    ]=]
    filesize: number?,

    --[=[
        Approximate file size in bytes (estimated).
    ]=]
    filesize_approx: number?,

    --[=[
        Audio sample rate in Hz.
    ]=]
    asr: number?,

    --[=[
        Video width in pixels.
    ]=]
    width: number?,

    --[=[
        Video height in pixels.
    ]=]
    height: number?,

    --[=[
        Protocol used for downloading (e.g., "https", "m3u8").
    ]=]
    protocol: string?,

    --[=[
        Format note (e.g., "DASH video", "Premium").
    ]=]
    format_note: string?,
}

--[=[
    Thumbnail information for a video.
]=]
export type ThumbnailInfo = {
    --[=[
        URL of the thumbnail image.
    ]=]
    url: string?,

    --[=[
        Thumbnail width in pixels.
    ]=]
    width: number?,

    --[=[
        Thumbnail height in pixels.
    ]=]
    height: number?,

    --[=[
        Thumbnail identifier.
    ]=]
    id: string?,
}

--[=[
    Subtitle track information.
]=]
export type SubtitleInfo = {
    --[=[
        Subtitle format extension (e.g., "vtt", "srt", "ass").
    ]=]
    ext: string?,

    --[=[
        URL to download the subtitle file.
    ]=]
    url: string?,

    --[=[
        Subtitle language name (e.g., "English", "Portuguese").
    ]=]
    name: string?,
}

--[=[
    Chapter/segment information for a video.
]=]
export type ChapterInfo = {
    --[=[
        Chapter start time in seconds.
    ]=]
    start_time: number?,

    --[=[
        Chapter end time in seconds.
    ]=]
    end_time: number?,

    --[=[
        Chapter title.
    ]=]
    title: string?,
}

--[=[
    Complete video/media metadata returned by getInfo().
    Contains all information yt-dlp can extract about a video.
]=]
export type MediaInfo = {
    --[=[
        Unique video identifier on the platform.
    ]=]
    id: string?,

    --[=[
        Video title.
    ]=]
    title: string?,

    --[=[
        Full video description text.
    ]=]
    description: string?,

    --[=[
        Direct URL of the media page.
    ]=]
    webpage_url: string?,

    --[=[
        Video duration in seconds.
    ]=]
    duration: number?,

    --[=[
        Human-readable duration string (e.g., "5:30").
    ]=]
    duration_string: string?,

    --[=[
        Upload date in YYYYMMDD format.
    ]=]
    upload_date: string?,

    --[=[
        Name of the uploader/channel.
    ]=]
    uploader: string?,

    --[=[
        Uploader's channel URL.
    ]=]
    uploader_url: string?,

    --[=[
        Channel name.
    ]=]
    channel: string?,

    --[=[
        Channel unique identifier.
    ]=]
    channel_id: string?,

    --[=[
        Channel page URL.
    ]=]
    channel_url: string?,

    --[=[
        Number of views.
    ]=]
    view_count: number?,

    --[=[
        Number of likes.
    ]=]
    like_count: number?,

    --[=[
        Number of comments.
    ]=]
    comment_count: number?,

    --[=[
        Average user rating.
    ]=]
    average_rating: number?,

    --[=[
        Age restriction limit (e.g., 18).
    ]=]
    age_limit: number?,

    --[=[
        Whether the video is a live stream.
    ]=]
    is_live: boolean?,

    --[=[
        Whether the video was a live stream (now archived).
    ]=]
    was_live: boolean?,

    --[=[
        Video thumbnail URL.
    ]=]
    thumbnail: string?,

    --[=[
        All available thumbnails.
    ]=]
    thumbnails: {ThumbnailInfo}?,

    --[=[
        Video categories/tags.
    ]=]
    categories: {string}?,

    --[=[
        Video tags.
    ]=]
    tags: {string}?,

    --[=[
        All available download formats.
    ]=]
    formats: {FormatInfo}?,

    --[=[
        Available subtitles keyed by language code.
    ]=]
    subtitles: {[string]: {SubtitleInfo}}?,

    --[=[
        Auto-generated subtitles keyed by language code.
    ]=]
    automatic_captions: {[string]: {SubtitleInfo}}?,

    --[=[
        Video chapters.
    ]=]
    chapters: {ChapterInfo}?,

    --[=[
        Playlist title (if part of a playlist).
    ]=]
    playlist_title: string?,

    --[=[
        Index in playlist (1-based).
    ]=]
    playlist_index: number?,

    --[=[
        Total number of entries in playlist.
    ]=]
    playlist_count: number?,

    --[=[
        Name of the extractor/platform (e.g., "youtube", "twitch").
    ]=]
    extractor: string?,

    --[=[
        File extension of the selected format.
    ]=]
    ext: string?,

    --[=[
        Selected format string.
    ]=]
    format: string?,

    --[=[
        Selected format identifier.
    ]=]
    format_id: string?,

    --[=[
        Video width in pixels.
    ]=]
    width: number?,

    --[=[
        Video height in pixels.
    ]=]
    height: number?,

    --[=[
        Frames per second.
    ]=]
    fps: number?,

    --[=[
        Video codec.
    ]=]
    vcodec: string?,

    --[=[
        Audio codec.
    ]=]
    acodec: string?,

    --[=[
        File size in bytes.
    ]=]
    filesize: number?,

    --[=[
        Approximate file size in bytes.
    ]=]
    filesize_approx: number?,
}

--[=[
    Options for downloading media with yt-dlp.
    All fields are optional. Unset fields use yt-dlp defaults.
]=]
export type DownloadOptions = {
    --[=[
        Format selection string (e.g., "bestvideo+bestaudio/best", "bestaudio", "137+140").
        See yt-dlp format selection docs for full syntax.
    ]=]
    format: string?,

    --[=[
        Output filename template. Supports yt-dlp template variables:
        `%(title)s`, `%(id)s`, `%(ext)s`, `%(upload_date)s`, etc.
    ]=]
    output: string?,

    --[=[
        Output directory path. Files will be saved here.
    ]=]
    outputDir: string?,

    --[=[
        Merge output container format (e.g., "mp4", "mkv", "webm").
        Used when downloading separate video+audio streams.
    ]=]
    mergeFormat: string?,

    --[=[
        Recode video to this format after download (e.g., "mp4", "mkv", "avi", "flv").
    ]=]
    recodeVideo: string?,

    --[=[
        Post-processing: extract audio only and convert to this format.
        Values: "mp3", "aac", "flac", "m4a", "opus", "vorbis", "wav", "alac".
    ]=]
    audioFormat: string?,

    --[=[
        Audio quality (0 = best, 10 = worst) or specific bitrate (e.g., "192K").
        Used with audioFormat.
    ]=]
    audioQuality: string?,

    --[=[
        Embed thumbnail into the output file (requires mutagen/AtomicParsley).
    ]=]
    embedThumbnail: boolean?,

    --[=[
        Embed metadata/tags into the output file.
    ]=]
    embedMetadata: boolean?,

    --[=[
        Embed subtitles into the output file (only for mp4, mkv, webm).
    ]=]
    embedSubs: boolean?,

    --[=[
        Embed chapters into the output file.
    ]=]
    embedChapters: boolean?,

    --[=[
        Write subtitle files. Use with subtitleLangs.
    ]=]
    writeSubs: boolean?,

    --[=[
        Write auto-generated subtitles.
    ]=]
    writeAutoSubs: boolean?,

    --[=[
        Subtitle languages to download (e.g., "en,pt,es" or "all").
    ]=]
    subtitleLangs: string?,

    --[=[
        Subtitle format preference (e.g., "srt", "vtt", "ass", "best").
    ]=]
    subtitleFormat: string?,

    --[=[
        Write video thumbnail to disk.
    ]=]
    writeThumbnail: boolean?,

    --[=[
        Convert thumbnails to this format (e.g., "png", "jpg").
    ]=]
    convertThumbnails: string?,

    --[=[
        Write video description to a .description file.
    ]=]
    writeDescription: boolean?,

    --[=[
        Write video metadata to a .info.json file.
    ]=]
    writeInfoJson: boolean?,

    --[=[
        Write video comments to the info.json file.
    ]=]
    writeComments: boolean?,

    --[=[
        Download entire playlist (true) or single video (false).
        Default: false (noPlaylist).
    ]=]
    playlist: boolean?,

    --[=[
        Playlist item range to download (e.g., "1:3", "2:5", "1:10:2").
    ]=]
    playlistItems: string?,

    --[=[
        Maximum number of downloads. Stops after this many.
    ]=]
    maxDownloads: number?,

    --[=[
        Limit download speed in bytes per second (e.g., "500K", "4M").
    ]=]
    rateLimit: string?,

    --[=[
        Number of retries for failed downloads.
    ]=]
    retries: number?,

    --[=[
        Number of concurrent fragment downloads (default: 1).
    ]=]
    concurrentFragments: number?,

    --[=[
        Download only videos shorter than this duration in seconds.
    ]=]
    matchFilterDuration: number?,

    --[=[
        Custom match filter expression (e.g., "duration < 600 & view_count > 1000").
    ]=]
    matchFilter: string?,

    --[=[
        Filter to download within a specific date range (YYYYMMDD format).
    ]=]
    dateAfter: string?,

    --[=[
        Filter to download before a specific date (YYYYMMDD format).
    ]=]
    dateBefore: string?,

    --[=[
        Download specific chapters by regex (e.g., "intro", "*]").
    ]=]
    downloadSections: string?,

    --[=[
        Use SponsorBlock to remove/mark segments.
        Categories: "sponsor", "selfpromo", "interaction", "intro", "outro", "preview", "music_offtopic", "filler", "all".
    ]=]
    sponsorBlockRemove: string?,

    --[=[
        Mark SponsorBlock segments as chapters instead of removing.
    ]=]
    sponsorBlockMark: string?,

    --[=[
        Cookies file path (Netscape format) for authenticated downloads.
    ]=]
    cookiesFile: string?,

    --[=[
        Browser to extract cookies from (e.g., "chrome", "firefox", "edge", "brave", "opera", "safari").
    ]=]
    cookiesFromBrowser: string?,

    --[=[
        Username for authentication.
    ]=]
    username: string?,

    --[=[
        Password for authentication.
    ]=]
    password: string?,

    --[=[
        Two-factor authentication code.
    ]=]
    twoFactor: string?,

    --[=[
        Use .netrc file for authentication.
    ]=]
    netrc: boolean?,

    --[=[
        Video password (for password-protected videos like Vimeo).
    ]=]
    videoPassword: string?,

    --[=[
        Proxy URL (e.g., "socks5://127.0.0.1:1080", "http://proxy:8080").
    ]=]
    proxy: string?,

    --[=[
        Source IP address to bind to.
    ]=]
    sourceAddress: string?,

    --[=[
        Force using IPv4 connections.
    ]=]
    forceIPv4: boolean?,

    --[=[
        Force using IPv6 connections.
    ]=]
    forceIPv6: boolean?,

    --[=[
        Geo verification proxy URL.
    ]=]
    geoVerificationProxy: string?,

    --[=[
        Sleep interval between downloads in seconds.
    ]=]
    sleepInterval: number?,

    --[=[
        Maximum sleep interval for randomized delays.
    ]=]
    maxSleepInterval: number?,

    --[=[
        Restrict filenames to ASCII characters only.
    ]=]
    restrictFilenames: boolean?,

    --[=[
        Do not overwrite existing files.
    ]=]
    noOverwrites: boolean?,

    --[=[
        Continue partially downloaded files.
    ]=]
    continue: boolean?,

    --[=[
        Use an archive file to track downloaded videos and skip them.
        Path to the archive text file.
    ]=]
    downloadArchive: string?,

    --[=[
        Prefer free formats (ogg, opus, webm).
    ]=]
    preferFreeFormats: boolean?,

    --[=[
        Do not use the .part file extension for partial downloads.
    ]=]
    noPart: boolean?,

    --[=[
        Custom User-Agent string.
    ]=]
    userAgent: string?,

    --[=[
        Custom Referer URL.
    ]=]
    referer: string?,

    --[=[
        Custom HTTP headers as key:value string (e.g., "Authorization:Bearer TOKEN").
    ]=]
    headers: {string}?,

    --[=[
        Post-processors to run after download.
        List of post-processor strings.
    ]=]
    postProcessors: {string}?,

    --[=[
        Execute a command after each download.
        Template variables available: %(filepath)s, %(title)s, etc.
    ]=]
    execAfterDownload: string?,

    --[=[
        Use aria2c as external downloader for faster downloads.
    ]=]
    useAria2c: boolean?,

    --[=[
        External downloader to use (e.g., "aria2c", "curl", "wget", "axel").
    ]=]
    externalDownloader: string?,

    --[=[
        Arguments to pass to the external downloader.
    ]=]
    externalDownloaderArgs: string?,

    --[=[
        FFmpeg location path (if not in PATH).
    ]=]
    ffmpegLocation: string?,

    --[=[
        Print output to stdout instead of downloading (for piping).
        Show progress on console during download.
        Default: true.
    ]=]
    showProgress: boolean?,

    --[=[
        Quiet mode — suppress all output.
    ]=]
    quiet: boolean?,

    --[=[
        Verbose debug output.
    ]=]
    verbose: boolean?,

    --[=[
        Additional raw arguments to pass directly to yt-dlp.
        These are appended as-is to the command.
    ]=]
    extraArgs: {string}?,
}

--[=[
    Available methods to install yt-dlp on the system.
]=]
export type InstallMethod = "winget" | "scoop" | "choco" | "pip" | "pipx" | "brew" | "pacman" | "apt" | "dnf" | "snap" | "download"

--[=[
    Result of an installation attempt.
]=]
export type InstallResult = {
    --[=[
        Whether the installation succeeded.
    ]=]
    ok: boolean,

    --[=[
        The method that was used to install.
    ]=]
    method: InstallMethod,

    --[=[
        Output or error message from the installation.
    ]=]
    message: string,
}

--[=[
    Options for searching/listing videos.
]=]
export type SearchOptions = {
    --[=[
        Maximum number of results to return.
    ]=]
    maxResults: number?,

    --[=[
        Sort order (e.g., "date", "views", "rating").
    ]=]
    sortBy: string?,

    --[=[
        Flat playlist — do not extract videos from playlists, just list them.
    ]=]
    flatPlaylist: boolean?,
}

--[=[
    @class YtDlp

    A complete wrapper for the yt-dlp command-line tool.
    Provides video/audio downloading, metadata extraction, format listing,
    playlist handling, subtitle management, post-processing, and auto-installation
    via multiple package managers (winget, scoop, choco, pip, brew, apt, etc.).

    Uses `zune.process` for CLI execution and `zune.serde.json` for parsing metadata.
    Automatically detects the operating system via `zune.process.os` to select
    the appropriate installation method.

    ### Quick Start
    ```lua
    local YtDlp = require("./Packages/yt-dlp")

    -- Check if yt-dlp is available
    if not YtDlp.isInstalled() then
        YtDlp.install()
    end

    -- Download a video
    YtDlp.download("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        format = "bestvideo+bestaudio/best",
        output = "%(title)s.%(ext)s",
        mergeFormat = "mp4",
    })
    ```

    ### Download Audio Only
    ```lua
    YtDlp.downloadAudio("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        audioFormat = "mp3",
        audioQuality = "0",
        embedThumbnail = true,
        embedMetadata = true,
    })
    ```

    ### Get Video Info
    ```lua
    local info = YtDlp.getInfo("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    if info then
        print("Title:", info.title)
        print("Duration:", info.duration_string)
        print("Views:", info.view_count)
    end
    ```

    ### List Formats
    ```lua
    local formats = YtDlp.getFormats("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    for _, fmt in ipairs(formats) do
        print(fmt.format_id, fmt.ext, fmt.resolution, fmt.format_note)
    end
    ```

    ### Playlist Download
    ```lua
    YtDlp.download("https://www.youtube.com/playlist?list=PLrAXtmErZgOeiKm4sgNOknGvNjby9efdf", {
        playlist = true,
        output = "%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s",
        format = "bestvideo[height<=1080]+bestaudio/best",
    })
    ```

    ### Search Videos
    ```lua
    local results = YtDlp.search("luau programming tutorial", { maxResults = 5 })
    for _, entry in ipairs(results) do
        print(entry.title, entry.webpage_url)
    end
    ```

    ### Auto-Install
    ```lua
    local result = YtDlp.install("winget")
    print(result.ok, result.method, result.message)

    -- Or auto-detect best method:
    local result = YtDlp.install()
    ```
]=]
local YtDlp = {}

local function buildArgs(url: string, opts: DownloadOptions?): {string}
    local args: {string} = {}

    if opts then
        if opts.format then 
            table.insert(args, "-f")
            table.insert(args, opts.format) 
        end
        if opts.output then 
            table.insert(args, "-o")
            table.insert(args, opts.output) 
        end
        if opts.outputDir then 
            table.insert(args, "-P")
            table.insert(args, opts.outputDir) 
        end
        if opts.mergeFormat then 
            table.insert(args, "--merge-output-format")
            table.insert(args, opts.mergeFormat) 
        end
        if opts.recodeVideo then 
            table.insert(args, "--recode-video")
            table.insert(args, opts.recodeVideo) 
        end
        if opts.audioFormat then 
            table.insert(args, "-x")
            table.insert(args, "--audio-format")
            table.insert(args, opts.audioFormat) 
        end
        if opts.audioQuality then 
            table.insert(args, "--audio-quality") 
            table.insert(args, opts.audioQuality) 
        end
        if opts.embedThumbnail then 
            table.insert(args, "--embed-thumbnail") 
        end
        if opts.embedMetadata then 
            table.insert(args, "--embed-metadata") 
        end
        if opts.embedSubs then 
            table.insert(args, "--embed-subs") 
        end
        if opts.embedChapters then 
            table.insert(args, "--embed-chapters") 
        end
        if opts.writeSubs then 
            table.insert(args, "--write-subs") 
        end
        if opts.writeAutoSubs then 
            table.insert(args, "--write-auto-subs") 
        end
        if opts.subtitleLangs then 
            table.insert(args, "--sub-langs") 
            table.insert(args, opts.subtitleLangs) 
        end
        if opts.subtitleFormat then 
            table.insert(args, "--sub-format") 
            table.insert(args, opts.subtitleFormat) 
        end
        if opts.writeThumbnail then 
            table.insert(args, "--write-thumbnail") 
        end
        if opts.convertThumbnails then 
            table.insert(args, "--convert-thumbnails") 
            table.insert(args, opts.convertThumbnails) 
        end
        if opts.writeDescription then 
            table.insert(args, "--write-description") 
        end
        if opts.writeInfoJson then 
            table.insert(args, "--write-info-json") 
        end
        if opts.writeComments then 
            table.insert(args, "--write-comments") 
        end
        if opts.playlist == false or opts.playlist == nil then 
            table.insert(args, "--no-playlist") 
        end
        if opts.playlistItems then 
            table.insert(args, "--playlist-items") 
            table.insert(args, opts.playlistItems) 
        end
        if opts.maxDownloads then 
            table.insert(args, "--max-downloads") 
            table.insert(args, tostring(opts.maxDownloads)) 
        end
        if opts.rateLimit then 
            table.insert(args, "-r")
            table.insert(args, opts.rateLimit) 
        end
        if opts.retries then 
            table.insert(args, "-R")
            table.insert(args, tostring(opts.retries)) 
        end
        if opts.concurrentFragments then 
            table.insert(args, "--concurrent-fragments") 
            table.insert(args, tostring(opts.concurrentFragments)) 
        end
        if opts.matchFilter then 
            table.insert(args, "--match-filter") 
            table.insert(args, opts.matchFilter) 
        end
        if opts.dateAfter then 
            table.insert(args, "--dateafter")
            table.insert(args, opts.dateAfter) 
        end
        if opts.dateBefore then 
            table.insert(args, "--datebefore") 
            table.insert(args, opts.dateBefore) 
        end
        if opts.downloadSections then 
            table.insert(args, "--download-sections") 
            table.insert(args, opts.downloadSections) 
        end
        if opts.sponsorBlockRemove then 
            table.insert(args, "--sponsorblock-remove") 
            table.insert(args, opts.sponsorBlockRemove) 
        end
        if opts.sponsorBlockMark then 
            table.insert(args, "--sponsorblock-mark") 
            table.insert(args, opts.sponsorBlockMark) 
        end
        if opts.cookiesFile then 
            table.insert(args, "--cookies")
            table.insert(args, opts.cookiesFile) 
        end
        if opts.cookiesFromBrowser then 
            table.insert(args, "--cookies-from-browser") 
            table.insert(args, opts.cookiesFromBrowser) 
        end
        if opts.username then 
            table.insert(args, "-u")
            table.insert(args, opts.username) 
        end
        if opts.password then 
            table.insert(args, "-p")
            table.insert(args, opts.password) 
        end
        if opts.twoFactor then 
            table.insert(args, "--2fa")
            table.insert(args, opts.twoFactor) 
        end
        if opts.netrc then 
            table.insert(args, "--netrc") 
        end
        if opts.videoPassword then 
            table.insert(args, "--video-password") 
            table.insert(args, opts.videoPassword) 
        end
        if opts.proxy then 
            table.insert(args, "--proxy") 
            table.insert(args, opts.proxy) 
        end
        if opts.sourceAddress then 
            table.insert(args, "--source-address") 
            table.insert(args, opts.sourceAddress) 
        end
        if opts.forceIPv4 then 
            table.insert(args, "-4") 
        end
        if opts.forceIPv6 then 
            table.insert(args, "-6") 
        end
        if opts.geoVerificationProxy then 
            table.insert(args, "--geo-verification-proxy") 
            table.insert(args, opts.geoVerificationProxy) 
        end
        if opts.sleepInterval then 
            table.insert(args, "--sleep-interval") 
            table.insert(args, tostring(opts.sleepInterval)) 
        end
        if opts.maxSleepInterval then 
            table.insert(args, "--max-sleep-interval") 
            table.insert(args, tostring(opts.maxSleepInterval)) 
        end
        if opts.restrictFilenames then 
            table.insert(args, "--restrict-filenames") 
        end
        if opts.noOverwrites then 
            table.insert(args, "--no-overwrites") 
        end
        if opts.continue then 
            table.insert(args, "--continue") 
        end
        if opts.downloadArchive then 
            table.insert(args, "--download-archive") 
            table.insert(args, opts.downloadArchive) 
        end
        if opts.preferFreeFormats then 
            table.insert(args, "--prefer-free-formats") 
        end
        if opts.noPart then 
            table.insert(args, "--no-part") 
        end
        if opts.userAgent then 
            table.insert(args, "--user-agent") 
            table.insert(args, opts.userAgent) 
        end
        if opts.referer then 
            table.insert(args, "--referer") 
            table.insert(args, opts.referer) 
        end
        if opts.headers then
            for _, header in ipairs(opts.headers) do
                table.insert(args, "--add-header")
                table.insert(args, header)
            end
        end
        if opts.execAfterDownload then 
            table.insert(args, "--exec") 
            table.insert(args, opts.execAfterDownload) 
        end
        if opts.useAria2c then 
            table.insert(args, "--downloader") 
            table.insert(args, "aria2c") 
        end
        if opts.externalDownloader then 
            table.insert(args, "--downloader") 
            table.insert(args, opts.externalDownloader) 
        end
        if opts.externalDownloaderArgs then 
            table.insert(args, "--downloader-args") 
            table.insert(args, opts.externalDownloaderArgs) 
        end
        if opts.ffmpegLocation then 
            table.insert(args, "--ffmpeg-location") 
            table.insert(args, opts.ffmpegLocation) 
        end
        if opts.quiet then 
            table.insert(args, "-q")
            table.insert(args, "--no-warnings")
        end
        if opts.verbose then 
            table.insert(args, "-v") 
        end
        if opts.extraArgs then
            for _, arg in ipairs(opts.extraArgs) do
                table.insert(args, arg)
            end
        end
    end

    table.insert(args, url)
    return args
end

local function runCmd(exec: string, args: {string}, inherit: boolean?, quiet: boolean?): ExecResult
    local stdoutMode: string
    local stderrMode: string
    if quiet then
        stdoutMode = "ignore"
        stderrMode = "ignore"
    elseif inherit then
        stdoutMode = "inherit"
        stderrMode = "inherit"
    else
        stdoutMode = "pipe"
        stderrMode = "pipe"
    end
    local success, result = pcall(function()
        return zune.process.run(exec, args, {
            stdout = stdoutMode,
            stderr = stderrMode,
        })
    end)
    if not success then
        return {
            ok = false,
            stdout = "",
            stderr = tostring(result),
            code = -1,
        }
    end
    return {
        ok = result.ok,
        stdout = if inherit or quiet then "" else (result.stdout :: string),
        stderr = if inherit or quiet then "" else (result.stderr :: string),
        code = result.code,
    }
end

local function cmdExists(cmd: string): boolean
    local os = zune.platform.os
    local success, check = pcall(function()
        if os == "windows" then
            return zune.process.run("where", {cmd}, { stdout = "pipe", stderr = "pipe" })
        else
            return zune.process.run("which", {cmd}, { stdout = "pipe", stderr = "pipe" })
        end
    end)
    if not success then
        return false
    end
    return check.ok
end

--[=[
    Checks if yt-dlp is installed and available in the system PATH.
    Uses `where` on Windows and `which` on Unix systems.

    @return true if yt-dlp is found, false otherwise.
]=]
function YtDlp.isInstalled(): boolean
    return cmdExists("yt-dlp")
end

--[=[
    Returns the installed yt-dlp version string.
    Returns nil if yt-dlp is not installed.

    @return Version string (e.g., "2024.12.23") or nil.
]=]
function YtDlp.version(): string?
    local result = runCmd("yt-dlp", {"--version"})
    if result.ok then
        return string.gsub(result.stdout, "%s+$", "")
    end
    return nil
end

--[=[
    Updates yt-dlp to the latest version using its built-in updater.

    @return ExecResult with the update output.
]=]
function YtDlp.update(): ExecResult
    return runCmd("yt-dlp", {"-U"}, true)
end

--[=[
    Installs yt-dlp using the specified or best available package manager.
    If no method is specified, automatically detects the best installation method
    for the current operating system and tries each one until success.

    Supported methods:
    - Windows: `winget`, `scoop`, `choco`, `pip`, `pipx`
    - macOS: `brew`, `pip`, `pipx`
    - Linux: `pacman`, `apt`, `dnf`, `snap`, `brew`, `pip`, `pipx`
    - Fallback: `download` (direct binary from GitHub Releases)

    @param method Optional specific install method to use.
    @return InstallResult with success status, method used, and message.
]=]
function YtDlp.install(method: InstallMethod?): InstallResult
    local os = zune.platform.os

    local installCommands: {[string]: {exec: string, args: {string}}} = {
        winget = { exec = "winget", args = {"install", "--id", "yt-dlp.yt-dlp", "-e", "--accept-source-agreements", "--accept-package-agreements"} },
        scoop = { exec = "scoop", args = {"install", "yt-dlp"} },
        choco = { exec = "choco", args = {"install", "yt-dlp", "-y"} },
        pip = { exec = "pip", args = {"install", "--upgrade", "yt-dlp"} },
        pipx = { exec = "pipx", args = {"install", "yt-dlp"} },
        brew = { exec = "brew", args = {"install", "yt-dlp"} },
        pacman = { exec = "sudo", args = {"pacman", "-S", "--noconfirm", "yt-dlp"} },
        apt = { exec = "sudo", args = {"apt", "install", "-y", "yt-dlp"} },
        dnf = { exec = "sudo", args = {"dnf", "install", "-y", "yt-dlp"} },
        snap = { exec = "sudo", args = {"snap", "install", "yt-dlp"} },
    }

    local function tryInstall(m: string): InstallResult
        if m == "download" then
            local dlUrl
            local dlOut
            if os == "windows" then
                dlUrl = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
                local userProfile = zune.process.env.USERPROFILE or "C:\\Users\\Public"
                dlOut = userProfile .. "\\.local\\bin\\yt-dlp.exe"
                local _mkdirResult = zune.process.run("cmd", {"/c", "mkdir", userProfile .. "\\.local\\bin"}, { stdout = "pipe", stderr = "pipe" })
                local result = zune.process.run("curl", {"-L", "-o", dlOut, dlUrl}, { stdout = "pipe", stderr = "pipe" })
                if result.ok then
                    return { ok = true, method = "download", message = "Downloaded to " .. dlOut .. ". Add to PATH if needed." }
                end
                return { ok = false, method = "download", message = "Download failed: " .. (result.stderr :: string) }
            else
                dlUrl = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp"
                dlOut = "/usr/local/bin/yt-dlp"
                local result = zune.process.run("sudo", {"curl", "-L", "-o", dlOut, dlUrl}, { stdout = "pipe", stderr = "pipe" })
                if result.ok then
                    zune.process.run("sudo", {"chmod", "a+rx", dlOut}, { stdout = "pipe", stderr = "pipe" })
                    return { ok = true, method = "download", message = "Downloaded to " .. dlOut }
                end
                return { ok = false, method = "download", message = "Download failed: " .. (result.stderr :: string) }
            end
        end

        local cmd = installCommands[m]
        if not cmd then
            return { ok = false, method = m :: InstallMethod, message = "Unknown install method: " .. m }
        end

        if not cmdExists(cmd.exec) then
            return { ok = false, method = m :: InstallMethod, message = cmd.exec .. " not found on system" }
        end

        local result = runCmd(cmd.exec, cmd.args, true)
        return {
            ok = result.ok,
            method = m :: InstallMethod,
            message = if result.ok then "Successfully installed via " .. m else result.stderr,
        }
    end

    if method then
        return tryInstall(method)
    end

    local order: {string}
    if os == "windows" then
        order = {"winget", "scoop", "choco", "pip", "pipx", "download"}
    elseif os == "macos" then
        order = {"brew", "pip", "pipx", "download"}
    else
        order = {"pacman", "apt", "dnf", "brew", "snap", "pip", "pipx", "download"}
    end

    for _, m in ipairs(order) do
        local result = tryInstall(m)
        if result.ok then
            return result
        end
    end

    return { ok = false, method = "download", message = "All installation methods failed" }
end

--[=[
    Executes a raw yt-dlp command with the given arguments.
    This is the low-level method used by all other functions.
    Use this for advanced usage not covered by the high-level API.

    Example:
    ```lua
    local result = YtDlp.exec({"--list-extractors"})
    print(result.stdout)
    ```

    @param args Array of command-line arguments to pass to yt-dlp.
    @param inherit If true, output is shown directly on the console. Default: false.
    @return ExecResult with stdout, stderr, and exit status.
]=]
function YtDlp.exec(args: {string}, inherit: boolean?): ExecResult
    return runCmd("yt-dlp", args, inherit)
end

--[=[
    Downloads media from the given URL with optional configuration.
    Supports any URL supported by yt-dlp (YouTube, Twitch, Twitter, TikTok, etc.).
    Progress is shown on console by default.

    Example:
    ```lua
    YtDlp.download("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        format = "bestvideo[height<=1080]+bestaudio/best",
        mergeFormat = "mp4",
        output = "%(title)s.%(ext)s",
        embedMetadata = true,
        embedThumbnail = true,
    })
    ```

    @param url URL of the video/media to download.
    @param opts Download options (format, output, quality, etc.).
    @return ExecResult with download output.
]=]
function YtDlp.download(url: string, opts: DownloadOptions?): ExecResult
    local isQuiet = opts and opts.quiet or false
    local showProgress = true
    if opts and (opts.showProgress == false or isQuiet) then
        showProgress = false
    end
    local args = buildArgs(url, opts)
    return runCmd("yt-dlp", args, showProgress, isQuiet)
end

--[=[
    Downloads only the audio track from the given URL.
    Shorthand for download() with extract-audio enabled.
    Default audio format is "mp3" with best quality.

    Example:
    ```lua
    YtDlp.downloadAudio("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        audioFormat = "opus",
        audioQuality = "0",
        embedThumbnail = true,
        embedMetadata = true,
        output = "%(title)s.%(ext)s",
    })
    ```

    @param url URL of the video to extract audio from.
    @param opts Download options. audioFormat defaults to "mp3" if not specified.
    @return ExecResult with download output.
]=]
function YtDlp.downloadAudio(url: string, opts: DownloadOptions?): ExecResult
    local finalOpts: DownloadOptions = if opts then table.clone(opts) else {}
    if not finalOpts.audioFormat then
        finalOpts.audioFormat = "mp3"
    end
    if not finalOpts.audioQuality then
        finalOpts.audioQuality = "0"
    end
    local isQuiet = finalOpts.quiet or false
    local showProgress = true
    if finalOpts.showProgress == false or isQuiet then
        showProgress = false
    end
    local args = buildArgs(url, finalOpts)
    return runCmd("yt-dlp", args, showProgress, isQuiet)
end

--[=[
    Downloads video with a specific maximum resolution.
    Shorthand for download() with format set to limit video height.

    Example:
    ```lua
    YtDlp.downloadVideo("https://www.youtube.com/watch?v=dQw4w9WgXcQ", 1080, {
        mergeFormat = "mp4",
        embedSubs = true,
        subtitleLangs = "en,pt",
    })
    ```

    @param url URL of the video to download.
    @param maxHeight Maximum video height in pixels (e.g., 720, 1080, 1440, 2160).
    @param opts Additional download options.
    @return ExecResult with download output.
]=]
function YtDlp.downloadVideo(url: string, maxHeight: number?, opts: DownloadOptions?): ExecResult
    local finalOpts: DownloadOptions = if opts then table.clone(opts) else {}
    if not finalOpts.format then
        local h = maxHeight or 1080
        finalOpts.format = string.format("bestvideo[height<=%d]+bestaudio/best[height<=%d]", h, h)
    end
    if not finalOpts.mergeFormat then
        finalOpts.mergeFormat = "mp4"
    end
    local isQuiet = finalOpts.quiet or false
    local showProgress = true
    if finalOpts.showProgress == false or isQuiet then
        showProgress = false
    end
    local args = buildArgs(url, finalOpts)
    return runCmd("yt-dlp", args, showProgress, isQuiet)
end

--[=[
    Extracts complete metadata/information about a video without downloading it.
    Returns a parsed MediaInfo table from yt-dlp's JSON output.

    Example:
    ```lua
    local info = YtDlp.getInfo("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    if info then
        print("Title:", info.title)
        print("Duration:", info.duration_string)
        print("Channel:", info.channel)
        print("Views:", info.view_count)
        print("Formats:", info.formats and #info.formats or 0)
    end
    ```

    @param url URL of the video to get info from.
    @return MediaInfo table or nil if extraction failed.
]=]
function YtDlp.getInfo(url: string): MediaInfo?
    local result = runCmd("yt-dlp", {"-j", "--no-playlist", url})
    if not result.ok then
        return nil
    end
    local ok, data = pcall(function()
        return zune.serde.json.decode(result.stdout)
    end)
    if ok then
        return data :: MediaInfo
    end
    return nil
end

--[=[
    Extracts metadata for all videos in a playlist.
    Returns an array of MediaInfo tables.

    Example:
    ```lua
    local entries = YtDlp.getPlaylistInfo("https://www.youtube.com/playlist?list=PLrAXtmErZgOe...")
    for _, entry in ipairs(entries) do
        print(entry.title, entry.duration_string)
    end
    ```

    @param url URL of the playlist.
    @return Array of MediaInfo tables.
]=]
function YtDlp.getPlaylistInfo(url: string): {MediaInfo}
    local result = runCmd("yt-dlp", {"-j", "--flat-playlist", url})
    if not result.ok then
        return {}
    end
    local entries: {MediaInfo} = {}
    for line in string.gmatch(result.stdout, "[^\n]+") do
        local ok, data = pcall(function()
            return zune.serde.json.decode(line)
        end)
        if ok and data then
            table.insert(entries, data :: MediaInfo)
        end
    end
    return entries
end

--[=[
    Lists all available download formats for a video.
    Returns an array of FormatInfo tables with details about each format.

    Example:
    ```lua
    local formats = YtDlp.getFormats("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    for _, fmt in ipairs(formats) do
        print(fmt.format_id, fmt.ext, fmt.resolution, fmt.vcodec, fmt.acodec)
    end
    ```

    @param url URL of the video.
    @return Array of FormatInfo tables, empty if extraction failed.
]=]
function YtDlp.getFormats(url: string): {FormatInfo}
    local info = YtDlp.getInfo(url)
    if info and info.formats then
        return info.formats
    end
    return {}
end

--[=[
    Lists available subtitle languages for a video.
    Returns a table keyed by language code, each containing an array of SubtitleInfo.

    Example:
    ```lua
    local subs = YtDlp.getSubtitles("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    for lang, tracks in pairs(subs) do
        print(lang, #tracks, "tracks")
    end
    ```

    @param url URL of the video.
    @param includeAuto Include auto-generated subtitles (default: false).
    @return Table of subtitle tracks keyed by language code.
]=]
function YtDlp.getSubtitles(url: string, includeAuto: boolean?): {[string]: {SubtitleInfo}}
    local info = YtDlp.getInfo(url)
    if not info then return {} end

    local result: {[string]: {SubtitleInfo}} = {}
    if info.subtitles then
        for lang, tracks in pairs(info.subtitles) do
            result[lang] = tracks
        end
    end
    if includeAuto and info.automatic_captions then
        for lang, tracks in pairs(info.automatic_captions) do
            if not result[lang] then
                result[lang] = tracks
            end
        end
    end
    return result
end

--[=[
    Gets the direct download URL(s) for a video without downloading.
    Useful for streaming or passing to another downloader.

    Example:
    ```lua
    local url = YtDlp.getDirectUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    if url then
        print("Direct URL:", url)
    end
    ```

    @param url URL of the video.
    @param format Optional format selector (default: "best").
    @return Direct URL string or nil.
]=]
function YtDlp.getDirectUrl(url: string, format: string?): string?
    local args = {"-g", "--no-playlist"}
    if format then
        table.insert(args, "-f")
        table.insert(args, format)
    end
    table.insert(args, url)
    local result = runCmd("yt-dlp", args)
    if result.ok then
        return string.gsub(result.stdout, "%s+$", "")
    end
    return nil
end

--[=[
    Gets the filename that yt-dlp would use for a download without actually downloading.
    Useful for checking what the output file will be named.

    Example:
    ```lua
    local filename = YtDlp.getFilename("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        output = "%(title)s.%(ext)s",
    })
    print("Would save as:", filename)
    ```

    @param url URL of the video.
    @param opts Options that affect filename (output template, format, etc.).
    @return Filename string or nil.
]=]
function YtDlp.getFilename(url: string, opts: DownloadOptions?): string?
    local args = {"--get-filename", "--no-playlist"}
    if opts and opts.output then
        table.insert(args, "-o")
        table.insert(args, opts.output)
    end
    if opts and opts.format then
        table.insert(args, "-f")
        table.insert(args, opts.format)
    end
    table.insert(args, url)
    local result = runCmd("yt-dlp", args)
    if result.ok then
        return string.gsub(result.stdout, "%s+$", "")
    end
    return nil
end

--[=[
    Gets the title of a video without downloading.

    @param url URL of the video.
    @return Title string or nil.
]=]
function YtDlp.getTitle(url: string): string?
    local result = runCmd("yt-dlp", {"--get-title", "--no-playlist", url})
    if result.ok then
        return string.gsub(result.stdout, "%s+$", "")
    end
    return nil
end

--[=[
    Gets the duration of a video in seconds without downloading.

    @param url URL of the video.
    @return Duration in seconds or nil.
]=]
function YtDlp.getDuration(url: string): number?
    local result = runCmd("yt-dlp", {"--get-duration", "--no-playlist", url})
    if result.ok then
        local text = string.gsub(result.stdout, "%s+$", "")
        local parts = string.split(text, ":")
        if #parts == 3 then
            return (tonumber(parts[1]) or 0) * 3600 + (tonumber(parts[2]) or 0) * 60 + (tonumber(parts[3]) or 0)
        elseif #parts == 2 then
            return (tonumber(parts[1]) or 0) * 60 + (tonumber(parts[2]) or 0)
        end
        return tonumber(text)
    end
    return nil
end

--[=[
    Gets the thumbnail URL of a video without downloading.

    @param url URL of the video.
    @return Thumbnail URL string or nil.
]=]
function YtDlp.getThumbnailUrl(url: string): string?
    local result = runCmd("yt-dlp", {"--get-thumbnail", "--no-playlist", url})
    if result.ok then
        return string.gsub(result.stdout, "%s+$", "")
    end
    return nil
end

--[=[
    Searches for videos using yt-dlp's search feature.
    Supports YouTube search by default (ytsearch:).

    Example:
    ```lua
    local results = YtDlp.search("luau tutorial", { maxResults = 10 })
    for _, entry in ipairs(results) do
        print(entry.title, entry.webpage_url)
    end
    ```

    @param query Search query string.
    @param opts Search options (maxResults, flatPlaylist).
    @return Array of MediaInfo tables.
]=]
function YtDlp.search(query: string, opts: SearchOptions?): {MediaInfo}
    local maxResults = (opts and opts.maxResults) or 5
    local searchUrl = string.format("ytsearch%d:%s", maxResults, query)
    local args = {"-j", "--flat-playlist", searchUrl}
    if opts and opts.sortBy then
        table.insert(args, 1, "--playlist-sort")
        table.insert(args, 2, opts.sortBy)
    end
    local result = runCmd("yt-dlp", args)
    if not result.ok then
        return {}
    end
    local entries: {MediaInfo} = {}
    for line in string.gmatch(result.stdout, "[^\n]+") do
        local ok, data = pcall(function()
            return zune.serde.json.decode(line)
        end)
        if ok and data then
            table.insert(entries, data :: MediaInfo)
        end
    end
    return entries
end

--[=[
    Lists all supported extractors/sites by yt-dlp.
    Returns an array of extractor names.

    @return Array of extractor name strings.
]=]
function YtDlp.listExtractors(): {string}
    local result = runCmd("yt-dlp", {"--list-extractors"})
    if not result.ok then
        return {}
    end
    local extractors: {string} = {}
    for line in string.gmatch(result.stdout, "[^\n]+") do
        local trimmed = string.gsub(line, "%s+$", "")
        if #trimmed > 0 then
            table.insert(extractors, trimmed)
        end
    end
    return extractors
end

--[=[
    Prints the format list for a URL directly to the console.
    Equivalent to running `yt-dlp -F <url>`.

    @param url URL of the video.
    @return ExecResult with the format list output.
]=]
function YtDlp.listFormats(url: string): ExecResult
    return runCmd("yt-dlp", {"-F", "--no-playlist", url}, true)
end

--[=[
    Downloads and extracts only subtitles without downloading the video.

    Example:
    ```lua
    YtDlp.downloadSubtitles("https://www.youtube.com/watch?v=dQw4w9WgXcQ", {
        subtitleLangs = "en,pt",
        subtitleFormat = "srt",
        output = "%(title)s.%(ext)s",
    })
    ```

    @param url URL of the video.
    @param opts Options (subtitleLangs, subtitleFormat, output, outputDir, writeAutoSubs).
    @return ExecResult with output.
]=]
function YtDlp.downloadSubtitles(url: string, opts: DownloadOptions?): ExecResult
    local args: {string} = {"--skip-download", "--write-subs"}
    if opts then
        if opts.writeAutoSubs then table.insert(args, "--write-auto-subs") end
        if opts.subtitleLangs then
            table.insert(args, "--sub-langs")
            table.insert(args, opts.subtitleLangs)
        end
        if opts.subtitleFormat then
            table.insert(args, "--sub-format")
            table.insert(args, opts.subtitleFormat)
        end
        if opts.output then
            table.insert(args, "-o")
            table.insert(args, opts.output)
        end
        if opts.outputDir then
            table.insert(args, "-P")
            table.insert(args, opts.outputDir)
        end
    end
    table.insert(args, "--no-playlist")
    table.insert(args, url)
    return runCmd("yt-dlp", args, true)
end

--[=[
    Downloads only the thumbnail image without downloading the video.

    @param url URL of the video.
    @param opts Options (output, outputDir, convertThumbnails).
    @return ExecResult with output.
]=]
function YtDlp.downloadThumbnail(url: string, opts: DownloadOptions?): ExecResult
    local args: {string} = {"--skip-download", "--write-thumbnail"}
    if opts then
        if opts.convertThumbnails then
            table.insert(args, "--convert-thumbnails")
            table.insert(args, opts.convertThumbnails)
        end
        if opts.output then
            table.insert(args, "-o")
            table.insert(args, opts.output)
        end
        if opts.outputDir then
            table.insert(args, "-P")
            table.insert(args, opts.outputDir)
        end
    end
    table.insert(args, "--no-playlist")
    table.insert(args, url)
    return runCmd("yt-dlp", args, true)
end

--[=[
    Checks if ffmpeg is available on the system.
    ffmpeg is required for merging formats, converting audio, embedding thumbnails, etc.

    @return true if ffmpeg is found.
]=]
function YtDlp.isFfmpegInstalled(): boolean
    return cmdExists("ffmpeg")
end

--[=[
    Checks if aria2c is available on the system.
    aria2c can be used as an external downloader for faster multi-connection downloads.

    @return true if aria2c is found.
]=]
function YtDlp.isAria2cInstalled(): boolean
    return cmdExists("aria2c")
end

--[=[
    Downloads multiple URLs sequentially with logs visible.
    Each URL is downloaded one-by-one.

    Example:
    ```lua
    local results = YtDlp.downloadBatch(urls, {
        outputDir = "D:\\",
        output = "%(title)s.%(ext)s",
        format = "bestaudio/best",
    }, function(i, total, result)
        print(string.format("[%d/%d] %s", i, total, result.ok and "✓" or "✗"))
    end)
    ```

    @param urls Array of URLs to download.
    @param opts Download options applied to all URLs.
    @param onProgress Optional callback called when each download finishes.
    @return Array of ExecResult, one per URL, in the same order.
]=]
function YtDlp.downloadBatch(urls: {string}, opts: DownloadOptions?, onProgress: ((index: number, total: number, result: ExecResult) -> ())?): {ExecResult}
    local total = #urls
    local results: {ExecResult} = table.create(total)

    for i, url in ipairs(urls) do
        local result = YtDlp.download(url, opts)
        results[i] = result
        if onProgress then
            onProgress(i, total, result)
        end
    end

    return results
end

--[=[
    Downloads multiple URLs as audio sequentially.
    Each URL is downloaded one-by-one with logs visible.

    Example:
    ```lua
    local results = YtDlp.downloadAudioBatch(urls, {
        outputDir = "D:\\",
        output = "%(title)s.%(ext)s",
        audioQuality = "320K",
        embedThumbnail = true,
    }, function(i, total, result)
        print(string.format("[%d/%d] %s", i, total, result.ok and "✓" or "✗"))
    end)
    ```

    @param urls Array of URLs to download audio from.
    @param opts Download options applied to all URLs. audioFormat defaults to "mp3".
    @param onProgress Optional callback called when each download finishes.
    @return Array of ExecResult, one per URL, in the same order.
]=]
function YtDlp.downloadAudioBatch(urls: {string}, opts: DownloadOptions?, onProgress: ((index: number, total: number, result: ExecResult) -> ())?): {ExecResult}
    local total = #urls
    local results: {ExecResult} = table.create(total)

    for i, url in ipairs(urls) do
        local result = YtDlp.downloadAudio(url, opts)
        results[i] = result
        if onProgress then
            onProgress(i, total, result)
        end
    end

    return results
end

return YtDlp
