



<!DOCTYPE html>
<html lang="en" class="">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>GlacierExtraction/Glacier_Extraction.m at master · ttsmith89/GlacierExtraction · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="ttsmith89/GlacierExtraction" name="twitter:title" /><meta content="GlacierExtraction - Scripts for Glacier Mapping as outlined in the paper: &amp;#39;Improving Semi-Automated Glacial Mapping with a Multi-Method Approach: Areal Changes in the Tien Shan" name="twitter:description" /><meta content="https://avatars3.githubusercontent.com/u/8735822?v=3&amp;s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars3.githubusercontent.com/u/8735822?v=3&amp;s=400" property="og:image" /><meta content="ttsmith89/GlacierExtraction" property="og:title" /><meta content="https://github.com/ttsmith89/GlacierExtraction" property="og:url" /><meta content="GlacierExtraction - Scripts for Glacier Mapping as outlined in the paper: &#39;Improving Semi-Automated Glacial Mapping with a Multi-Method Approach: Areal Changes in the Tien Shan" property="og:description" />

      <meta name="browser-stats-url" content="/_stats">
    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    
    <meta name="pjax-timeout" content="1000">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="8D596F5E:2BF1:9FE377D:54D340B7" name="octolytics-dimension-request_id" />
    
    <meta content="Rails, view, blob#show" name="analytics-event" />

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="Drl3gF+WGS1ez6ZJ0gil0J4FEm1gwm+/Fh8JhpkxpUpWUd37FBsQtRnckRByc2QmV/FhAUTmV0AjVShYzooDHQ==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-d4c82cdf29d116c0e3fc8d832c10ced6c486134ed6dd6a41a237f301c258795f.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-01ab4379ac7e65832a27b84517b46126d671f0dc3c2dce94c00e53866a617e26.css" media="all" rel="stylesheet" type="text/css" />
    
    


    <meta http-equiv="x-pjax-version" content="ce2010b592efa5c69b87ff72544a66dd">

      
  <meta name="description" content="GlacierExtraction - Scripts for Glacier Mapping as outlined in the paper: &#39;Improving Semi-Automated Glacial Mapping with a Multi-Method Approach: Areal Changes in the Tien Shan">
  <meta name="go-import" content="github.com/ttsmith89/GlacierExtraction git https://github.com/ttsmith89/GlacierExtraction.git">

  <meta content="8735822" name="octolytics-dimension-user_id" /><meta content="ttsmith89" name="octolytics-dimension-user_login" /><meta content="23915248" name="octolytics-dimension-repository_id" /><meta content="ttsmith89/GlacierExtraction" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="23915248" name="octolytics-dimension-repository_network_root_id" /><meta content="ttsmith89/GlacierExtraction" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/ttsmith89/GlacierExtraction/commits/master.atom" rel="alternate" title="Recent Commits to GlacierExtraction:master" type="application/atom+xml">

  </head>


  <body class="logged_out  env-production linux vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out" role="banner">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/" ga-data-click="(Logged out) Header, go to homepage, icon:logo-wordmark">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions" role="navigation">
        <a class="button primary" href="/join" data-ga-click="(Logged out) Header, clicked Sign up, text:sign-up">Sign up</a>
      <a class="button" href="/login?return_to=%2Fttsmith89%2FGlacierExtraction%2Fblob%2Fmaster%2FGlacier_Extraction.m" data-ga-click="(Logged out) Header, clicked Sign in, text:sign-in">Sign in</a>
    </div>

    <div class="site-search repo-scope js-site-search" role="search">
      <form accept-charset="UTF-8" action="/ttsmith89/GlacierExtraction/search" class="js-site-search-form" data-global-search-url="/search" data-repo-search-url="/ttsmith89/GlacierExtraction/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <input type="text"
    class="js-site-search-field is-clearable"
    data-hotkey="s"
    name="q"
    placeholder="Search"
    data-global-scope-placeholder="Search GitHub"
    data-repo-scope-placeholder="Search"
    tabindex="1"
    autocapitalize="off">
  <div class="scope-badge">This repository</div>
</form>
    </div>

      <ul class="header-nav left" role="navigation">
          <li class="header-nav-item">
            <a class="header-nav-link" href="/explore" data-ga-click="(Logged out) Header, go to explore, text:explore">Explore</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/features" data-ga-click="(Logged out) Header, go to features, text:features">Features</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="https://enterprise.github.com/" data-ga-click="(Logged out) Header, go to enterprise, text:enterprise">Enterprise</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/blog" data-ga-click="(Logged out) Header, go to blog, text:blog">Blog</a>
          </li>
      </ul>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">


  <li>
      <a href="/login?return_to=%2Fttsmith89%2FGlacierExtraction"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>
    Star
  </a>

    <a class="social-count js-social-count" href="/ttsmith89/GlacierExtraction/stargazers">
      0
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2Fttsmith89%2FGlacierExtraction"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>
        Fork
      </a>
      <a href="/ttsmith89/GlacierExtraction/network" class="social-count">
        0
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/ttsmith89" class="url fn" itemprop="url" rel="author"><span itemprop="title">ttsmith89</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/ttsmith89/GlacierExtraction" class="js-current-repository" data-pjax="#js-repo-pjax-container">GlacierExtraction</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<nav class="sunken-menu repo-nav js-repo-nav js-sidenav-container-pjax js-octicon-loaders"
     role="navigation"
     data-pjax="#js-repo-pjax-container"
     data-issue-count-url="/ttsmith89/GlacierExtraction/issues/counts">
  <ul class="sunken-menu-group">
    <li class="tooltipped tooltipped-w" aria-label="Code">
      <a href="/ttsmith89/GlacierExtraction" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /ttsmith89/GlacierExtraction">
        <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>

      <li class="tooltipped tooltipped-w" aria-label="Issues">
        <a href="/ttsmith89/GlacierExtraction/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /ttsmith89/GlacierExtraction/issues">
          <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
          <span class="js-issue-replace-counter"></span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

    <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
      <a href="/ttsmith89/GlacierExtraction/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item" data-hotkey="g p" data-selected-links="repo_pulls /ttsmith89/GlacierExtraction/pulls">
          <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
          <span class="js-pull-replace-counter"></span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>


  </ul>
  <div class="sunken-menu-separator"></div>
  <ul class="sunken-menu-group">

    <li class="tooltipped tooltipped-w" aria-label="Pulse">
      <a href="/ttsmith89/GlacierExtraction/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-selected-links="pulse /ttsmith89/GlacierExtraction/pulse">
        <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>

    <li class="tooltipped tooltipped-w" aria-label="Graphs">
      <a href="/ttsmith89/GlacierExtraction/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-selected-links="repo_graphs repo_contributors /ttsmith89/GlacierExtraction/graphs">
        <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>    </li>
  </ul>


</nav>

              <div class="only-with-full-nav">
                  
<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><span class="text-emphasized">HTTPS</span> clone URL</h3>
  <div class="input-group js-zeroclipboard-container">
    <input type="text" class="input-mini input-monospace js-url-field js-zeroclipboard-target"
           value="https://github.com/ttsmith89/GlacierExtraction.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><span class="text-emphasized">Subversion</span> checkout URL</h3>
  <div class="input-group js-zeroclipboard-container">
    <input type="text" class="input-mini input-monospace js-url-field js-zeroclipboard-target"
           value="https://github.com/ttsmith89/GlacierExtraction" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>



<p class="clone-options">You can clone with
  <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a> or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>



                <a href="/ttsmith89/GlacierExtraction/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download the contents of ttsmith89/GlacierExtraction as a zip file"
                   title="Download the contents of ttsmith89/GlacierExtraction as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/ttsmith89/GlacierExtraction/blob/bd9d5ca8bfa6ca255ee8c5ba0fe84f7278093955/Glacier_Extraction.m" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:c7e23d90de29e6ea4a7a9f61ec0c89a4 -->

<div class="file-navigation js-zeroclipboard-container">
  
<div class="select-menu js-menu-container js-select-menu left">
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div>

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/ttsmith89/GlacierExtraction/blob/master/Glacier_Extraction.m"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div>
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div>

    </div>
  </div>
</div>

  <div class="button-group right">
    <a href="/ttsmith89/GlacierExtraction/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button aria-label="Copy file path to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
  </div>

  <div class="breadcrumb js-zeroclipboard-target">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/ttsmith89/GlacierExtraction" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">GlacierExtraction</span></a></span></span><span class="separator">/</span><strong class="final-path">Glacier_Extraction.m</strong>
  </div>
</div>


  <div class="commit file-history-tease">
    <div class="file-history-tease-header">
        <img alt="" class="avatar" height="24" src="https://0.gravatar.com/avatar/0c747c12dc11a95e6e80008968eabbdc?d=https%3A%2F%2Fassets-cdn.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&amp;r=x&amp;s=140" width="24" />
        <span class="author"><span>ttsmith89</span></span>
        <time datetime="2014-09-11T14:59:57Z" is="relative-time">Sep 11, 2014</time>
        <div class="commit-title">
            <a href="/ttsmith89/GlacierExtraction/commit/bd9d5ca8bfa6ca255ee8c5ba0fe84f7278093955" class="message" data-pjax="true" title="Glacier Scripts V0.1

All scripts and config file templates needed to run Glacier Extraction">Glacier Scripts V0.1</a>
        </div>
    </div>

    <div class="participation">
      <p class="quickstat">
        <a href="#blob_contributors_box" rel="facebox">
          <strong>0</strong>
           contributors
        </a>
      </p>
      
    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
          <span>293 lines (246 sloc)</span>
          <span class="meta-divider"></span>
        <span>10.305 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
          <a href="/ttsmith89/GlacierExtraction/raw/master/Glacier_Extraction.m" class="minibutton " id="raw-url">Raw</a>
            <a href="/ttsmith89/GlacierExtraction/blame/master/Glacier_Extraction.m" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/ttsmith89/GlacierExtraction/commits/master/Glacier_Extraction.m" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->


            <a class="octicon-button disabled tooltipped tooltipped-w" href="#"
               aria-label="You must be signed in to make or propose changes"><span class="octicon octicon-pencil"></span></a>

          <a class="octicon-button danger disabled tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          <span class="octicon octicon-trashcan"></span>
        </a>
      </div><!-- /.actions -->
    </div>
    

  <div class="blob-wrapper data type-matlab">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code js-file-line"><span class="pl-st">function</span> <span class="pl-en">Glacier_Extraction</span>(csvfile)</td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code js-file-line"><span class="pl-c">%GlacExtract(csvfile)</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code js-file-line"><span class="pl-c">%   This function performs glacier extraction via Landsat Band comparisons. </span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code js-file-line"><span class="pl-c">%   It requires an extensive set of input datasets, read from a CSV. These</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code js-file-line"><span class="pl-c">%   are TM1, TM3, TM4, TM5, TM7, Shadow Mask, Base Export Path, Lakes from </span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code js-file-line"><span class="pl-c">%   Lake_Extraction, Slope, Elevation, River Network, Manual Debris, Velocity, </span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code js-file-line"><span class="pl-c">%   and a CSV containing thresholds for the region.</span></td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code js-file-line"><span class="pl-c">%Created by Taylor Smith, June 2014, V 0.1</span></td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code js-file-line"><span class="pl-c">%% Data read-in</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code js-file-line">fid = <span class="pl-s">fopen</span>(csvfile, <span class="pl-s1"><span class="pl-pds">&#39;</span>r<span class="pl-pds">&#39;</span></span>); <span class="pl-c">%Read attributes from a csv</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code js-file-line">nextLine = <span class="pl-s">fgetl</span>(fid);</td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code js-file-line">Cells = strsplit(nextLine, <span class="pl-s1"><span class="pl-pds">&#39;</span>,<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code js-file-line">TM1_r = Cells{<span class="pl-c1">1</span>};</td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code js-file-line">TM3_r = Cells{<span class="pl-c1">2</span>};</td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code js-file-line">TM4_r = Cells{<span class="pl-c1">3</span>};</td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code js-file-line">TM5_r = Cells{<span class="pl-c1">4</span>};</td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code js-file-line">TM7_r = Cells{<span class="pl-c1">5</span>};</td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code js-file-line">Mask_r = Cells{<span class="pl-c1">6</span>};</td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code js-file-line">Glac_Base = Cells{<span class="pl-c1">7</span>};</td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code js-file-line">Out_Lakes = Cells{<span class="pl-c1">8</span>};</td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code js-file-line">Slope_r = Cells{<span class="pl-c1">9</span>};</td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code js-file-line">Elev_r = Cells{<span class="pl-c1">10</span>};</td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code js-file-line">Riv_r = Cells{<span class="pl-c1">11</span>};</td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code js-file-line">TraceDebris_r = Cells{<span class="pl-c1">12</span>};</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code js-file-line">Vel_r = Cells{<span class="pl-c1">13</span>};</td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code js-file-line">Attscsv = Cells{<span class="pl-c1">14</span>};</td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code js-file-line"><span class="pl-s">fclose</span>(fid);</td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code js-file-line">fid = <span class="pl-s">fopen</span>(Attscsv, <span class="pl-s1"><span class="pl-pds">&#39;</span>r<span class="pl-pds">&#39;</span></span>); <span class="pl-c">%Pull elevation, min and max velocity, and NDVI threshold for each individual Landsat scene</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code js-file-line">nextLine = <span class="pl-s">fgetl</span>(fid);</td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code js-file-line">Cells = strsplit(nextLine, <span class="pl-s1"><span class="pl-pds">&#39;</span>,<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code js-file-line">ElevThreshold = <span class="pl-s">str2double</span>(Cells{<span class="pl-c1">1</span>});</td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code js-file-line">MinVelocity = <span class="pl-s">str2double</span>(Cells{<span class="pl-c1">2</span>});</td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code js-file-line">MaxVelocity = <span class="pl-s">str2double</span>(Cells{<span class="pl-c1">3</span>});</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code js-file-line">NDVIThreshold = <span class="pl-s">str2double</span>(Cells{<span class="pl-c1">4</span>});</td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code js-file-line"><span class="pl-s">fclose</span>(fid);</td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code js-file-line"><span class="pl-c">%% Pure Glacial Delineation</span></td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code js-file-line">[TM3, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM3_r);</td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code js-file-line">TM3 = <span class="pl-st">single</span>(TM3); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM3<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM3(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code js-file-line">[TM5, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM5_r);</td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code js-file-line">TM5 = <span class="pl-st">single</span>(TM5); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM5<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM5(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code js-file-line">Ratio = TM3<span class="pl-k">./</span>TM5; <span class="pl-c">%Create the ratio of TM3/TM5</span></td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Bands Ratiod<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code js-file-line"><span class="pl-k">clear</span> TM5 bbox idx0 TM3</td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code js-file-line">TMinfo = <span class="pl-s3">geotiffinfo</span>(TM1_r);</td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L54" class="blob-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-code js-file-line">[TM1, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM1_r);</td>
      </tr>
      <tr>
        <td id="L55" class="blob-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-code js-file-line">TMinfo = <span class="pl-s3">geotiffinfo</span>(TM1_r);</td>
      </tr>
      <tr>
        <td id="L56" class="blob-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-code js-file-line">TM1 = <span class="pl-st">single</span>(TM1); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L57" class="blob-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-code js-file-line">idx01 = <span class="pl-k">find</span>(TM1<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM1(idx01) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L58" class="blob-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L59" class="blob-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-code js-file-line">ratioidx = <span class="pl-k">find</span>(Ratio<span class="pl-k"> &gt;</span>= <span class="pl-c1">2</span><span class="pl-k"> &amp; </span>TM1<span class="pl-k"> &gt; </span><span class="pl-c1">250</span>); <span class="pl-c">%Use both the ratio and TM band 1 to pull out glaciated areas. </span></td>
      </tr>
      <tr>
        <td id="L60" class="blob-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-code js-file-line"><span class="pl-c">% This calculation is very bad at pulling thick debris cover, so the rest of this script works to identify debris cover</span></td>
      </tr>
      <tr>
        <td id="L61" class="blob-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-code js-file-line">TM1(ratioidx) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L62" class="blob-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-code js-file-line"><span class="pl-k">clear</span> ratioidx bbox idx01 Ratio</td>
      </tr>
      <tr>
        <td id="L63" class="blob-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L64" class="blob-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-code js-file-line">[Mask, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Mask_r); <span class="pl-c">%Mask out shadows</span></td>
      </tr>
      <tr>
        <td id="L65" class="blob-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-code js-file-line">Mask = <span class="pl-st">single</span>(Mask); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Mask<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); Mask(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L67" class="blob-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Mask Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L68" class="blob-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L69" class="blob-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-code js-file-line">Maskidx = <span class="pl-k">find</span>(Mask<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>);</td>
      </tr>
      <tr>
        <td id="L70" class="blob-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-code js-file-line">TM1(Maskidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L71" class="blob-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-code js-file-line"><span class="pl-k">clear</span> Maskidx Mask bbox idx0</td>
      </tr>
      <tr>
        <td id="L72" class="blob-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L73" class="blob-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-code js-file-line">[Lake, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Out_Lakes); <span class="pl-c">%Mask out lakes</span></td>
      </tr>
      <tr>
        <td id="L74" class="blob-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-code js-file-line">Lake = <span class="pl-st">single</span>(Lake); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L75" class="blob-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Lake<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); Lake(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L76" class="blob-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-code js-file-line"><span class="pl-k">clear</span> bbox idx0</td>
      </tr>
      <tr>
        <td id="L77" class="blob-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L78" class="blob-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-code js-file-line">Lakeidx = <span class="pl-k">find</span>(Lake<span class="pl-k"> == </span><span class="pl-c1">1</span>); <span class="pl-c">%Create an index of just lakes</span></td>
      </tr>
      <tr>
        <td id="L79" class="blob-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-code js-file-line">TM1(Lakeidx) = <span class="pl-c1">1</span>; <span class="pl-c">%Temporarily add lakes to glacier dataset for processing</span></td>
      </tr>
      <tr>
        <td id="L80" class="blob-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-code js-file-line"><span class="pl-k">clear</span> Lake </td>
      </tr>
      <tr>
        <td id="L81" class="blob-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L82" class="blob-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-code js-file-line">restidx2 = <span class="pl-k">find</span>(TM1<span class="pl-k"> &gt; </span><span class="pl-c1">1</span>);</td>
      </tr>
      <tr>
        <td id="L83" class="blob-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-code js-file-line">TM1(restidx2) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L84" class="blob-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-code js-file-line">restidx = <span class="pl-k">find</span>(TM1<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>);</td>
      </tr>
      <tr>
        <td id="L85" class="blob-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L86" class="blob-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-code js-file-line">Ttmp = TM1;</td>
      </tr>
      <tr>
        <td id="L87" class="blob-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-code js-file-line">Ttmp(Lakeidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L88" class="blob-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L89" class="blob-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_35.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L90" class="blob-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(Ttmp), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the spectral-only outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L91" class="blob-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-code js-file-line"><span class="pl-k">clear</span> Ttmp</td>
      </tr>
      <tr>
        <td id="L92" class="blob-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L93" class="blob-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-code js-file-line">[Seeds, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TraceDebris_r); <span class="pl-c">%Add manual seed points to index of glaciers</span></td>
      </tr>
      <tr>
        <td id="L94" class="blob-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-code js-file-line">Seeds = <span class="pl-st">single</span>(Seeds);</td>
      </tr>
      <tr>
        <td id="L95" class="blob-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-code js-file-line">Sidx = <span class="pl-k">find</span>(Seeds<span class="pl-k"> == </span><span class="pl-c1">1</span>); <span class="pl-k">clear</span> Seeds</td>
      </tr>
      <tr>
        <td id="L96" class="blob-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-code js-file-line">TM1(Sidx) = <span class="pl-c1">1</span>; <span class="pl-k">clear</span> Sidx</td>
      </tr>
      <tr>
        <td id="L97" class="blob-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-code js-file-line">testseed = <span class="pl-k">find</span>(TM1<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>);</td>
      </tr>
      <tr>
        <td id="L98" class="blob-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-code js-file-line"><span class="pl-k">clear</span> TM1 restidx2</td>
      </tr>
      <tr>
        <td id="L99" class="blob-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L100" class="blob-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-code js-file-line"><span class="pl-c">%% Examine Debris Areas</span></td>
      </tr>
      <tr>
        <td id="L101" class="blob-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-code js-file-line"><span class="pl-c">% At this point, these are pure glacier outlines. Next find debris</span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L103" class="blob-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-code js-file-line">[Slope, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Slope_r);</td>
      </tr>
      <tr>
        <td id="L104" class="blob-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-code js-file-line">Slope = <span class="pl-st">single</span>(Slope); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Slope<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); Slope(idx0) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L106" class="blob-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Slope Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L107" class="blob-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-code js-file-line"><span class="pl-k">clear</span> idx0 </td>
      </tr>
      <tr>
        <td id="L108" class="blob-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L109" class="blob-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-code js-file-line">Slopeidx = <span class="pl-k">find</span>(Slope<span class="pl-k"> &gt; </span><span class="pl-c1">24</span>); <span class="pl-c">%Identify slopes between 1 and 24 degris (After Paul et al., 2004)</span></td>
      </tr>
      <tr>
        <td id="L110" class="blob-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-code js-file-line">Slope(Slopeidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L111" class="blob-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-code js-file-line">Slope2idx = <span class="pl-k">find</span>(Slope<span class="pl-k"> &lt; </span><span class="pl-c1">1</span>);</td>
      </tr>
      <tr>
        <td id="L112" class="blob-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-code js-file-line">Slope(Slope2idx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L113" class="blob-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-code js-file-line">S = <span class="pl-s3">stdfilt</span>(Slope, <span class="pl-k">ones</span>(<span class="pl-c1">9</span>)); <span class="pl-c">%Identify and remove areas of low slope variability (plains, riverbeds, etc)</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-code js-file-line">Stdidx = <span class="pl-k">find</span>(S<span class="pl-k"> &gt; </span><span class="pl-c1">2</span>);</td>
      </tr>
      <tr>
        <td id="L115" class="blob-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-code js-file-line">Slope(Stdidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L116" class="blob-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-code js-file-line"><span class="pl-k">clear</span> S Stdidx</td>
      </tr>
      <tr>
        <td id="L117" class="blob-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-code js-file-line">Slopeidxr = <span class="pl-k">find</span>(Slope<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>);</td>
      </tr>
      <tr>
        <td id="L118" class="blob-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-code js-file-line">Slope(Slopeidxr) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L119" class="blob-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-code js-file-line"><span class="pl-k">clear</span> Slope2idx Slopeidx Slopeidxr</td>
      </tr>
      <tr>
        <td id="L120" class="blob-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L121" class="blob-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L122" class="blob-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L123" class="blob-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L124" class="blob-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_SlopeThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L125" class="blob-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the Slope Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L126" class="blob-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L127" class="blob-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L128" class="blob-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-code js-file-line">[Elev, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Elev_r); <span class="pl-c">%Filter for elevation. This can be set dependent on lowest glacier elevation in study region</span></td>
      </tr>
      <tr>
        <td id="L129" class="blob-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-code js-file-line">Elev = <span class="pl-st">single</span>(Elev); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L130" class="blob-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Elev<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); Elev(idx0) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L131" class="blob-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Elev Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L132" class="blob-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-code js-file-line"><span class="pl-k">clear</span> idx0 </td>
      </tr>
      <tr>
        <td id="L133" class="blob-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-code js-file-line">elevmask = <span class="pl-k">find</span>(Elev<span class="pl-k"> &lt; </span>ElevThreshold); <span class="pl-c">%Low elev, not glacier</span></td>
      </tr>
      <tr>
        <td id="L134" class="blob-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-code js-file-line">Slope(elevmask) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L135" class="blob-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-code js-file-line"><span class="pl-k">clear</span> Elev refmat bbox </td>
      </tr>
      <tr>
        <td id="L136" class="blob-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L137" class="blob-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L138" class="blob-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L139" class="blob-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L140" class="blob-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_ElevThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L141" class="blob-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the Elevation Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L142" class="blob-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L143" class="blob-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L144" class="blob-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-code js-file-line">[Riv, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Riv_r); <span class="pl-c">%Read in rivers to remove mis-identified areas of wet soil</span></td>
      </tr>
      <tr>
        <td id="L145" class="blob-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-code js-file-line">Riv = <span class="pl-st">single</span>(Riv); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L146" class="blob-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Riv<span class="pl-k"> &gt; </span><span class="pl-c1">1</span>); Riv(idx0) = <span class="pl-c1">NaN</span>; </td>
      </tr>
      <tr>
        <td id="L147" class="blob-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-code js-file-line">Riv(elevmask) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L148" class="blob-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-code js-file-line">rivseed = <span class="pl-k">find</span>(Riv<span class="pl-k"> == </span><span class="pl-c1">1</span>); </td>
      </tr>
      <tr>
        <td id="L149" class="blob-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-code js-file-line"><span class="pl-k">clear</span> Riv refmat bbox</td>
      </tr>
      <tr>
        <td id="L150" class="blob-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L151" class="blob-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-code js-file-line">[Vel, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Vel_r); <span class="pl-c">%Read velocity data</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-code js-file-line">Vel = <span class="pl-st">single</span>(Vel);</td>
      </tr>
      <tr>
        <td id="L153" class="blob-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Vel<span class="pl-k"> &lt; </span><span class="pl-c1">0</span>); Vel(idx0) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L154" class="blob-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-code js-file-line">idx1 = <span class="pl-k">find</span>(Vel<span class="pl-k"> &gt; </span>MaxVelocity); Vel(idx1) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L155" class="blob-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Velocity Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L156" class="blob-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-code js-file-line">velmask = <span class="pl-k">find</span>(Vel<span class="pl-k"> &lt; </span>MinVelocity); </td>
      </tr>
      <tr>
        <td id="L157" class="blob-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-code js-file-line">Slope(velmask) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L158" class="blob-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-code js-file-line"><span class="pl-k">clear</span> Vel refmat bbox idx0 idx1</td>
      </tr>
      <tr>
        <td id="L159" class="blob-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L160" class="blob-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L161" class="blob-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L162" class="blob-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L163" class="blob-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_VelThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L164" class="blob-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the Velocity Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L165" class="blob-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L166" class="blob-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L167" class="blob-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-code js-file-line"><span class="pl-c">%Use a distance weighting metric based on distance from rivers (center of valleys) to identify debris areas</span></td>
      </tr>
      <tr>
        <td id="L168" class="blob-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-code js-file-line">T = graydist(Slope, rivseed); </td>
      </tr>
      <tr>
        <td id="L169" class="blob-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-code js-file-line">Tidx = <span class="pl-k">find</span>(T<span class="pl-k"> &gt; </span><span class="pl-c1">90</span>); </td>
      </tr>
      <tr>
        <td id="L170" class="blob-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-code js-file-line">Slope(Tidx) = <span class="pl-c1">NaN</span>; Slope(elevmask) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L171" class="blob-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-code js-file-line"><span class="pl-k">clear</span> Tidx T elevmask</td>
      </tr>
      <tr>
        <td id="L172" class="blob-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L173" class="blob-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L174" class="blob-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L175" class="blob-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L176" class="blob-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_DistThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L177" class="blob-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the Distance Weighted Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L178" class="blob-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L179" class="blob-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L180" class="blob-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-code js-file-line">seed2idx = <span class="pl-k">find</span>(Slope<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>);</td>
      </tr>
      <tr>
        <td id="L181" class="blob-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-code js-file-line">Slope(seed2idx) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L182" class="blob-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-code js-file-line">Slope(restidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L183" class="blob-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-code js-file-line"><span class="pl-k">clear</span> seed2idx rivseed</td>
      </tr>
      <tr>
        <td id="L184" class="blob-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-code js-file-line">maskidx = <span class="pl-k">isnan</span>(Slope);</td>
      </tr>
      <tr>
        <td id="L185" class="blob-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L186" class="blob-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-code js-file-line"><span class="pl-c">%% Filter Overclassifications</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-code js-file-line"><span class="pl-c">%Debris maximum extent is now identified. The next steps try to remove misclassified areas</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L189" class="blob-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-code js-file-line"><span class="pl-c">%% NDWI Masking</span></td>
      </tr>
      <tr>
        <td id="L190" class="blob-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-code js-file-line">[TM1, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM1_r);</td>
      </tr>
      <tr>
        <td id="L191" class="blob-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-code js-file-line">TM1 = <span class="pl-st">single</span>(TM1); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM1<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM1(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>TM1 Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L194" class="blob-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L195" class="blob-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-code js-file-line">[TM4, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM4_r);</td>
      </tr>
      <tr>
        <td id="L196" class="blob-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-code js-file-line">TM4 = <span class="pl-st">single</span>(TM4); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L197" class="blob-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM4<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM4(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L198" class="blob-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>TM4 Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L199" class="blob-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L200" class="blob-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-code js-file-line">Ratio = (TM4<span class="pl-k"> - </span>TM1)<span class="pl-k">./</span>(TM4<span class="pl-k"> + </span>TM1); <span class="pl-c">%NDWI Calculation</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-code js-file-line"><span class="pl-k">clear</span> TM4 TM1</td>
      </tr>
      <tr>
        <td id="L202" class="blob-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-code js-file-line">Ratio(maskidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L203" class="blob-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-code js-file-line">RadIdx = <span class="pl-k">find</span>(Ratio<span class="pl-k"> &gt; </span><span class="pl-c1">0</span>); <span class="pl-c">% Remove positive water areas</span></td>
      </tr>
      <tr>
        <td id="L204" class="blob-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-code js-file-line">Slope(RadIdx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L205" class="blob-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-code js-file-line"><span class="pl-k">clear</span> RadIdx Ratio</td>
      </tr>
      <tr>
        <td id="L206" class="blob-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L207" class="blob-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L209" class="blob-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L210" class="blob-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_NDWIThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L211" class="blob-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the NDWI Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L212" class="blob-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L213" class="blob-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L214" class="blob-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-code js-file-line"><span class="pl-c">%% NDVI Masking</span></td>
      </tr>
      <tr>
        <td id="L215" class="blob-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-code js-file-line">maskidx = <span class="pl-k">isnan</span>(Slope);</td>
      </tr>
      <tr>
        <td id="L216" class="blob-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-code js-file-line">[TM3, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM3_r);</td>
      </tr>
      <tr>
        <td id="L217" class="blob-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-code js-file-line">TM3 = <span class="pl-st">single</span>(TM3); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L218" class="blob-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM3<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM3(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L220" class="blob-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-code js-file-line">[TM4, refmat, bbox] = <span class="pl-s3">geotiffread</span>(TM4_r);</td>
      </tr>
      <tr>
        <td id="L221" class="blob-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-code js-file-line">TM4 = <span class="pl-st">single</span>(TM4); <span class="pl-c">%Integerize</span></td>
      </tr>
      <tr>
        <td id="L222" class="blob-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(TM4<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); TM4(idx0) = <span class="pl-c1">NaN</span>; <span class="pl-c">%Recast nodata as NaN</span></td>
      </tr>
      <tr>
        <td id="L223" class="blob-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L224" class="blob-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-code js-file-line">NDVI = (TM4<span class="pl-k"> - </span>TM3)<span class="pl-k">./</span>(TM4<span class="pl-k"> + </span>TM3); <span class="pl-k">clear</span> TM4 TM3 idx0 bbox refmat</td>
      </tr>
      <tr>
        <td id="L225" class="blob-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-code js-file-line">NDVI(maskidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L226" class="blob-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-code js-file-line">NDVIdx = <span class="pl-k">find</span>(NDVI<span class="pl-k"> &gt; </span>NDVIThreshold); <span class="pl-c">%Remove vegetated areas</span></td>
      </tr>
      <tr>
        <td id="L227" class="blob-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-code js-file-line">Slope(NDVIdx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L228" class="blob-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-code js-file-line"><span class="pl-k">clear</span> NDVI NDVIdx</td>
      </tr>
      <tr>
        <td id="L229" class="blob-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L230" class="blob-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L232" class="blob-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L233" class="blob-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_NDVIThresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L234" class="blob-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the NDVI Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L235" class="blob-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L236" class="blob-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L237" class="blob-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-code js-file-line">S2 = Slope; <span class="pl-c">% Do a second distance weighting from only manual seed points and lakes</span></td>
      </tr>
      <tr>
        <td id="L238" class="blob-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-code js-file-line">S2(restidx) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L239" class="blob-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-code js-file-line">T2 = graydist(S2,testseed); </td>
      </tr>
      <tr>
        <td id="L240" class="blob-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-code js-file-line">T2idx = <span class="pl-k">find</span>(T2<span class="pl-k"> &gt; </span><span class="pl-c1">400</span>); </td>
      </tr>
      <tr>
        <td id="L241" class="blob-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-code js-file-line">Slope(T2idx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L242" class="blob-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-code js-file-line"><span class="pl-k">clear</span> S2 T2 T2idx</td>
      </tr>
      <tr>
        <td id="L243" class="blob-num js-line-number" data-line-number="243"></td>
        <td id="LC243" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L244" class="blob-num js-line-number" data-line-number="244"></td>
        <td id="LC244" class="blob-code js-file-line">outproc = Slope; <span class="pl-c">%Make a temporary copy to add the spectral glaciers to for consistent/comparable outputs</span></td>
      </tr>
      <tr>
        <td id="L245" class="blob-num js-line-number" data-line-number="245"></td>
        <td id="LC245" class="blob-code js-file-line">outproc(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L246" class="blob-num js-line-number" data-line-number="246"></td>
        <td id="LC246" class="blob-code js-file-line">outproc(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L247" class="blob-num js-line-number" data-line-number="247"></td>
        <td id="LC247" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>_Dist2Thresh.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L248" class="blob-num js-line-number" data-line-number="248"></td>
        <td id="LC248" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(outproc), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Write out the Second Distance Thresholded outlines for future processing</span></td>
      </tr>
      <tr>
        <td id="L249" class="blob-num js-line-number" data-line-number="249"></td>
        <td id="LC249" class="blob-code js-file-line"><span class="pl-k">clear</span> outproc</td>
      </tr>
      <tr>
        <td id="L250" class="blob-num js-line-number" data-line-number="250"></td>
        <td id="LC250" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L251" class="blob-num js-line-number" data-line-number="251"></td>
        <td id="LC251" class="blob-code js-file-line"><span class="pl-c">%% Statistical Filtering</span></td>
      </tr>
      <tr>
        <td id="L252" class="blob-num js-line-number" data-line-number="252"></td>
        <td id="LC252" class="blob-code js-file-line">slopeidx = <span class="pl-k">isnan</span>(Slope); </td>
      </tr>
      <tr>
        <td id="L253" class="blob-num js-line-number" data-line-number="253"></td>
        <td id="LC253" class="blob-code js-file-line">Slope(slopeidx) = <span class="pl-c1">0</span>; <span class="pl-k">clear</span> slopeidx</td>
      </tr>
      <tr>
        <td id="L254" class="blob-num js-line-number" data-line-number="254"></td>
        <td id="LC254" class="blob-code js-file-line">B = <span class="pl-s3">medfilt2</span>(Slope, [<span class="pl-c1">3</span> <span class="pl-c1">3</span>]);</td>
      </tr>
      <tr>
        <td id="L255" class="blob-num js-line-number" data-line-number="255"></td>
        <td id="LC255" class="blob-code js-file-line">new = ~<span class="pl-s3">bwareaopen</span>(~B, <span class="pl-c1">100000</span>); </td>
      </tr>
      <tr>
        <td id="L256" class="blob-num js-line-number" data-line-number="256"></td>
        <td id="LC256" class="blob-code js-file-line"><span class="pl-k">clear</span> B Slope</td>
      </tr>
      <tr>
        <td id="L257" class="blob-num js-line-number" data-line-number="257"></td>
        <td id="LC257" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L258" class="blob-num js-line-number" data-line-number="258"></td>
        <td id="LC258" class="blob-code js-file-line">new(restidx) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L259" class="blob-num js-line-number" data-line-number="259"></td>
        <td id="LC259" class="blob-code js-file-line">new(testseed) = <span class="pl-c1">1</span>;</td>
      </tr>
      <tr>
        <td id="L260" class="blob-num js-line-number" data-line-number="260"></td>
        <td id="LC260" class="blob-code js-file-line">new(Lakeidx) = <span class="pl-c1">0</span>;</td>
      </tr>
      <tr>
        <td id="L261" class="blob-num js-line-number" data-line-number="261"></td>
        <td id="LC261" class="blob-code js-file-line"><span class="pl-k">clear</span> TM1 restidx Lakeidx testseed</td>
      </tr>
      <tr>
        <td id="L262" class="blob-num js-line-number" data-line-number="262"></td>
        <td id="LC262" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L263" class="blob-num js-line-number" data-line-number="263"></td>
        <td id="LC263" class="blob-code js-file-line">B2 = <span class="pl-s3">medfilt2</span>(new, [<span class="pl-c1">3</span> <span class="pl-c1">3</span>]); <span class="pl-c">%Single median filter pass</span></td>
      </tr>
      <tr>
        <td id="L264" class="blob-num js-line-number" data-line-number="264"></td>
        <td id="LC264" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Pass 2 Done. Saving...<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L265" class="blob-num js-line-number" data-line-number="265"></td>
        <td id="LC265" class="blob-code js-file-line">new2 = <span class="pl-s3">bwareaopen</span>(B2, <span class="pl-c1">1000</span>);  <span class="pl-c">% Was 1500</span></td>
      </tr>
      <tr>
        <td id="L266" class="blob-num js-line-number" data-line-number="266"></td>
        <td id="LC266" class="blob-code js-file-line"><span class="pl-k">clear</span> B2</td>
      </tr>
      <tr>
        <td id="L267" class="blob-num js-line-number" data-line-number="267"></td>
        <td id="LC267" class="blob-code js-file-line">new4 = <span class="pl-s3">bwmorph</span>(new2,<span class="pl-s1"><span class="pl-pds">&#39;</span>open<span class="pl-pds">&#39;</span></span>); <span class="pl-c">%Perform an image opening to remove more edge effects</span></td>
      </tr>
      <tr>
        <td id="L268" class="blob-num js-line-number" data-line-number="268"></td>
        <td id="LC268" class="blob-code js-file-line">new4 = <span class="pl-st">single</span>(new4);</td>
      </tr>
      <tr>
        <td id="L269" class="blob-num js-line-number" data-line-number="269"></td>
        <td id="LC269" class="blob-code js-file-line"><span class="pl-k">clear</span> new2</td>
      </tr>
      <tr>
        <td id="L270" class="blob-num js-line-number" data-line-number="270"></td>
        <td id="LC270" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L271" class="blob-num js-line-number" data-line-number="271"></td>
        <td id="LC271" class="blob-code js-file-line">[Slope, refmat, bbox] = <span class="pl-s3">geotiffread</span>(Slope_r);</td>
      </tr>
      <tr>
        <td id="L272" class="blob-num js-line-number" data-line-number="272"></td>
        <td id="LC272" class="blob-code js-file-line">Slope = <span class="pl-st">single</span>(Slope); </td>
      </tr>
      <tr>
        <td id="L273" class="blob-num js-line-number" data-line-number="273"></td>
        <td id="LC273" class="blob-code js-file-line">idx0 = <span class="pl-k">find</span>(Slope<span class="pl-k"> &lt;</span>= <span class="pl-c1">0</span>); Slope(idx0) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L274" class="blob-num js-line-number" data-line-number="274"></td>
        <td id="LC274" class="blob-code js-file-line"><span class="pl-k">disp</span>(<span class="pl-s1"><span class="pl-pds">&#39;</span>Slope Loaded<span class="pl-pds">&#39;</span></span>)</td>
      </tr>
      <tr>
        <td id="L275" class="blob-num js-line-number" data-line-number="275"></td>
        <td id="LC275" class="blob-code js-file-line"><span class="pl-k">clear</span> idx0 </td>
      </tr>
      <tr>
        <td id="L276" class="blob-num js-line-number" data-line-number="276"></td>
        <td id="LC276" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L277" class="blob-num js-line-number" data-line-number="277"></td>
        <td id="LC277" class="blob-code js-file-line">Slopeidx = <span class="pl-k">find</span>(Slope<span class="pl-k"> &gt; </span><span class="pl-c1">60</span>); <span class="pl-c">%Make sure that no new high-slope areas have been added during distance weighting/statistical filtering</span></td>
      </tr>
      <tr>
        <td id="L278" class="blob-num js-line-number" data-line-number="278"></td>
        <td id="LC278" class="blob-code js-file-line">new4(Slopeidx) = <span class="pl-c1">NaN</span>;</td>
      </tr>
      <tr>
        <td id="L279" class="blob-num js-line-number" data-line-number="279"></td>
        <td id="LC279" class="blob-code js-file-line"><span class="pl-k">clear</span> Slope Slopeidx</td>
      </tr>
      <tr>
        <td id="L280" class="blob-num js-line-number" data-line-number="280"></td>
        <td id="LC280" class="blob-code js-file-line">new5 = <span class="pl-s3">medfilt2</span>(new4, [<span class="pl-c1">5</span> <span class="pl-c1">5</span>]);</td>
      </tr>
      <tr>
        <td id="L281" class="blob-num js-line-number" data-line-number="281"></td>
        <td id="LC281" class="blob-code js-file-line"><span class="pl-k">clear</span> new4</td>
      </tr>
      <tr>
        <td id="L282" class="blob-num js-line-number" data-line-number="282"></td>
        <td id="LC282" class="blob-code js-file-line">new5(<span class="pl-k">find</span>(new5<span class="pl-k"> == </span><span class="pl-c1">0</span>)) = <span class="pl-c1">NaN</span>; </td>
      </tr>
      <tr>
        <td id="L283" class="blob-num js-line-number" data-line-number="283"></td>
        <td id="LC283" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L284" class="blob-num js-line-number" data-line-number="284"></td>
        <td id="LC284" class="blob-code js-file-line">BW = <span class="pl-s3">im2bw</span>(new5, <span class="pl-c1">0.1</span>);</td>
      </tr>
      <tr>
        <td id="L285" class="blob-num js-line-number" data-line-number="285"></td>
        <td id="LC285" class="blob-code js-file-line">new6 = <span class="pl-s3">bwmorph</span>(BW, <span class="pl-s1"><span class="pl-pds">&#39;</span>bridge<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L286" class="blob-num js-line-number" data-line-number="286"></td>
        <td id="LC286" class="blob-code js-file-line"><span class="pl-k">clear</span> BW</td>
      </tr>
      <tr>
        <td id="L287" class="blob-num js-line-number" data-line-number="287"></td>
        <td id="LC287" class="blob-code js-file-line"><span class="pl-k">clear</span> maskidx new new5 velmask</td>
      </tr>
      <tr>
        <td id="L288" class="blob-num js-line-number" data-line-number="288"></td>
        <td id="LC288" class="blob-code js-file-line">new8 =<span class="pl-k"> +</span>new6;</td>
      </tr>
      <tr>
        <td id="L289" class="blob-num js-line-number" data-line-number="289"></td>
        <td id="LC289" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L290" class="blob-num js-line-number" data-line-number="290"></td>
        <td id="LC290" class="blob-code js-file-line">outpath = <span class="pl-k">strcat</span>(Glac_Base, <span class="pl-s1"><span class="pl-pds">&#39;</span>.tif<span class="pl-pds">&#39;</span></span>);</td>
      </tr>
      <tr>
        <td id="L291" class="blob-num js-line-number" data-line-number="291"></td>
        <td id="LC291" class="blob-code js-file-line">geotiffwrite(outpath, <span class="pl-st">int16</span>(new8), TMinfo.SpatialRef, <span class="pl-s1"><span class="pl-pds">&#39;</span>CoordRefSysCode<span class="pl-pds">&#39;</span></span>, TMinfo.GeoTIFFCodes.PCS); <span class="pl-c">%Save out the glaciated areas</span></td>
      </tr>
      <tr>
        <td id="L292" class="blob-num js-line-number" data-line-number="292"></td>
        <td id="LC292" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L293" class="blob-num js-line-number" data-line-number="293"></td>
        <td id="LC293" class="blob-code js-file-line"><span class="pl-k">exit</span></td>
      </tr>
</table>

  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer" role="contentinfo">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="https://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2015 <span title="0.03407s from github-fe137-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder=""></textarea>
      <div class="suggester-container">
        <div class="suggester fullscreen-suggester js-suggester js-navigation-container"></div>
      </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x flash-close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-2badd09f690fc93e95552ba0ecf64200a0019057d5f5c329827f78f98ea76a1c.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-13bba24e79c4d7b0c13fba399d17d39ae14c6fd536a93339819ceb490e78424b.js" type="text/javascript"></script>
      
      
  </body>
</html>

