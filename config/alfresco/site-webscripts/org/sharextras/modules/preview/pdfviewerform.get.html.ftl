<#-- This file is part of the Share Extras PdfJs Viewer project -->
<#assign el=args.htmlid?html>
<!DOCTYPE html>
<html dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Share Preview</title>
<#include "/org/alfresco/components/component.head.inc">
<#-- This file is part of the Share Extras PdfJs Viewer project -->
<#-- Do not import pdfviewer.css with link directive, this ads media screen directive and breaks print css override -->
<style type="text/css">
   @import "${url.context}/res/extras/components/preview/pdfjs/viewer.css";
</style>
<@script type="text/javascript" src="${url.context}/res/js/yui-common.js"></@script>
<@script type="text/javascript" src="${url.context}/res/extras/components/preview/pdfjs/compatibility.js"></@script>
<link rel="resource" type="application/l10n" href="${url.context}/res/extras/components/preview/pdfjs/locale.properties"/>
<@script type="text/javascript" src="${url.context}/res/extras/components/preview/pdfjs/l10n.js"></@script>
<@script type="text/javascript" src="${url.context}/res/extras/components/preview/pdfjs/pdf.js"></@script>
<script type="text/javascript">PDFJS.workerSrc = '${url.context}/res/extras/components/preview/pdfjs/pdf<#if DEBUG==false>-min.js<#else>.js</#if>';</script> 
<@script type="text/javascript" src="${url.context}/res/extras/components/preview/pdfjs/viewer.js"></@script>


</head>
<body>
    <div id="outerContainer">

      <div id="sidebarContainer">
        <div id="toolbarSidebar">
          <div class="splitToolbarButton toggled">
            <button id="viewThumbnail" class="toolbarButton toggled" title="Show Thumbnails" onclick="PDFView.switchSidebarView('thumbs')" tabindex="1" data-l10n-id="thumbs">
               <span data-l10n-id="thumbs_label">Thumbnails</span>
            </button>
            <button id="viewOutline" class="toolbarButton" title="Show Document Outline" onclick="PDFView.switchSidebarView('outline')" tabindex="2" data-l10n-id="outline">
               <span data-l10n-id="outline_label">Document Outline</span>
            </button>
          </div>
        </div>
        <div id="sidebarContent">
          <div id="thumbnailView">
          </div>
          <div id="outlineView" class="hidden">
          </div>
        </div>
      </div>  <!-- sidebarContainer -->

      <div id="mainContainer">
        <div class="toolbar">
          <div id="toolbarContainer">

            <div id="toolbarViewer">
              <div id="toolbarViewerLeft">
                <button id="sidebarToggle" class="toolbarButton" title="Toggle Sidebar" tabindex="3" data-l10n-id="toggle_slider">
                  <span data-l10n-id="toggle_slider_label">Toggle Sidebar</span>
                </button>
                <div class="toolbarButtonSpacer"></div>
                <div class="splitToolbarButton">
                  <button class="toolbarButton pageUp" title="Previous Page" onclick="PDFView.page--" id="previous" tabindex="4" data-l10n-id="previous">
                    <span data-l10n-id="previous_label">Previous</span>
                  </button>
                  <div class="splitToolbarButtonSeparator"></div>
                  <button class="toolbarButton pageDown" title="Next Page" onclick="PDFView.page++" id="next" tabindex="5" data-l10n-id="next">
                    <span data-l10n-id="next_label">Next</span>
                  </button>
                </div>
                <label class="toolbarLabel" for="pageNumber" data-l10n-id="page_label">Page: </label>
                <input type="number" id="pageNumber" class="toolbarField pageNumber" onchange="PDFView.page = this.value;" value="1" size="4" min="1" tabindex="6">
                </input>
                <span id="numPages" class="toolbarLabel"></span>
              </div>
              <div id="toolbarViewerRight">
                <input id="fileInput" class="fileInput" type="file" oncontextmenu="return false;" tabindex="10" />

                <!--
                <input id="fileInput" class="fileInput" type="file" oncontextmenu="return false;" style="visibility: hidden; position: fixed; right: 0; top: 0" />
                <button id="openFile" class="toolbarButton print" title="Open File" tabindex="10" data-l10n-id="open_file" onclick="document.getElementById('fileInput').click()">
                   <span data-l10n-id="open_file_label">Open</span>
                </button>
                -->

                <!--
                <button id="print" class="toolbarButton print" title="Print" tabindex="11" data-l10n-id="print" onclick="window.print()">
                  <span data-l10n-id="print_label">Print</span>
                </button>
                -->

                <button id="download" class="toolbarButton download" title="Download" onclick="PDFView.download();" tabindex="12" data-l10n-id="download">
                  <span data-l10n-id="download_label">Download</span>
                </button>
                <!-- <div class="toolbarButtonSpacer"></div> -->
                <a href="#" id="viewBookmark" class="toolbarButton bookmark" title="Current view (copy or open in new window)" tabindex="13" data-l10n-id="bookmark"><span data-l10n-id="bookmark_label">Current View</span></a>
              </div>
              <div class="outerCenter">
                <div class="innerCenter" id="toolbarViewerMiddle">
                  <div class="splitToolbarButton">
                    <button class="toolbarButton zoomOut" title="Zoom Out" onclick="PDFView.zoomOut();" tabindex="7" data-l10n-id="zoom_out">
                      <span data-l10n-id="zoom_out_label">Zoom Out</span>
                    </button>
                    <div class="splitToolbarButtonSeparator"></div>
                    <button class="toolbarButton zoomIn" title="Zoom In" onclick="PDFView.zoomIn();" tabindex="8" data-l10n-id="zoom_in">
                      <span data-l10n-id="zoom_in_label">Zoom In</span>
                     </button>
                  </div>
                  <span class="dropdownToolbarButton">
                     <select id="scaleSelect" onchange="PDFView.parseScale(this.value);" title="Zoom" oncontextmenu="return false;" tabindex="9" data-l10n-id="zoom">
                      <option id="pageAutoOption" value="auto" selected="selected" data-l10n-id="page_scale_auto">Automatic Zoom</option>
                      <option id="pageActualOption" value="page-actual" data-l10n-id="page_scale_actual">Actual Size</option>
                      <option id="pageFitOption" value="page-fit" data-l10n-id="page_scale_fit">Fit Page</option>
                      <option id="pageWidthOption" value="page-width" data-l10n-id="page_scale_width">Full Width</option>
                      <option id="customScaleOption" value="custom"></option>
                      <option value="0.5">50%</option>
                      <option value="0.75">75%</option>
                      <option value="1">100%</option>
                      <option value="1.25">125%</option>
                      <option value="1.5">150%</option>
                      <option value="2">200%</option>
                    </select>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div id="viewerContainer">
          <div id="viewer"></div>
        </div>

        <div id="loadingBox">
            <div id="loading" data-l10n-id="loading" data-l10n-args='{"percent": 0}'>Loading... 0%</div>
            <div id="loadingBar"><div class="progress"></div></div>
        </div>

        <div id="errorWrapper" hidden='true'>
          <div id="errorMessageLeft">
            <span id="errorMessage"></span>
            <button id="errorShowMore" onclick="" oncontextmenu="return false;" data-l10n-id="error_more_info">
              More Information
            </button>
            <button id="errorShowLess" onclick="" oncontextmenu="return false;" data-l10n-id="error_less_info" hidden='true'>
              Less Information
            </button>
          </div>
          <div id="errorMessageRight">
            <button id="errorClose" oncontextmenu="return false;" data-l10n-id="error_close">
              Close
            </button>
          </div>
          <div class="clearBoth"></div>
          <textarea id="errorMoreInfo" hidden='true' readonly="readonly"></textarea>
        </div>
      </div> <!-- mainContainer -->

    </div> <!-- outerContainer -->
    
</body>
</html>