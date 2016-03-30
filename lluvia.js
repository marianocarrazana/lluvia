var grid, folderComp, folderThumbsComp, documentComp, imageComp, videoComp, genericComp,
        elementsSize, elementsSpacing;
// ^ DELETE THIS

function load()
{
    elementsSize = imageSizeSlider.value;

    folderThumbsComp = Qt.createComponent("folderThumbs.qml");
    imageComp = Qt.createComponent("image.qml");
    genericComp = Qt.createComponent("generic.qml");
    videoComp = Qt.createComponent("video.qml");
    documentComp = Qt.createComponent("document.qml");
    loadGrid();
    resize();
    win.widthChanged.connect(resize);
    imageSizeSlider.valueChanged.connect(reloadImages);
    files.filesListChanged.connect(reloadImages);

}

function loadGrid()
{
    var gridComp = Qt.createComponent("grid.qml");
    grid = gridComp.createObject(listContainer);
    grid.rowSpacing = 20;
    loadElements(grid,listContainer.listTypes);
}

function loadElements(container,typesEnabled,folderEnabled) // optimizar
{

    var fileName, thumbs, filePath, fileType, fileIndex, i;
    var list = files.foldersList;
    if(folderEnabled===undefined){
    var folderComp = Qt.createComponent("folder.qml");
        for(i=0;i<list.length;i+=3)
        {
            fileName = list[i];
            thumbs = list[i+1];
            filePath = list[i+2];
            if(thumbs==="none")
            folderComp.createObject(container,{"displayName":fileName,
                                            "path": filePath ,"width":elementsSize});
            else
                folderThumbsComp.createObject(container,{"displayName":fileName,
                                                "path": filePath ,"width":elementsSize,"thumbs":"file://" + thumbs});
        }
    }

    var listN = files.listNumber(typesEnabled);
    var get = files.getProperty;

    for(i=0;i<listN;i++)
    {
        fileName = get(i,"name", typesEnabled);
        fileType = get(i,"type", typesEnabled);
        filePath = get(i,"path", typesEnabled);
        thumbs = get(i,"thumbnail", typesEnabled);
        switch(typesEnabled)
        {
        //Windows: "file://d/folder/image1.jpg" is not a valid URL. It should be "file:///d:/folder/image1.jpg"
        case "images":imageComp.createObject(container,{"displayName":fileName,
                                       "source":  thumbs,"sourceWidth":elementsSize,
                                       "sourceHeight":elementsSize,"width":elementsSize, "index": i});
            break;
        case "all":genericComp.createObject(container,{"displayName":fileName,"sourceWidth":elementsSize,
                                              "path": filePath,"sourceHeight":elementsSize,"width":elementsSize});
            break;
        case "videos":videoComp.createObject(container,{"displayName":fileName,"sourceWidth":elementsSize,
                                              "path": filePath,"sourceHeight":elementsSize,"width":elementsSize});
            break;
        case "documents":documentComp.createObject(container,{"displayName":fileName,"sourceWidth":elementsSize,
                                              "path": filePath,"sourceHeight":elementsSize,"width":elementsSize});
            break;
        }
    }
    stats.text = "Images:"+(files.listNumber("images"));
    autoLoadPreview.isCompleted = false;
    timerPreview.restart();
}

function resize()
{
    var winWidth = win.width - 40;
    var columns = parseInt(winWidth / elementsSize);
    elementsSpacing = parseInt((winWidth % elementsSize) / columns);
    while(elementsSpacing < 20)
    {
        columns--;
        elementsSpacing = parseInt((winWidth / columns - elementsSize) );
    }
    grid.columnSpacing = elementsSpacing;
    grid.columns = columns;
}

function destroyGrid()
{
    grid.destroy();
    for(var i=grid.children.length-1;i>=0;i--)grid.children[i].destroy();
}

function reloadImages()
{
    elementsSize = imageSizeSlider.value;
    destroyGrid();
    loadGrid();
    resize();
}



function displayFullViewer(index)
{
    elementsSize = 96;
    var fullViewer = Qt.createComponent("fullviewer.qml");
    fullViewer.createObject(win,{"thumbSize":elementsSize,"activeIndex":index});

}
function loadFullViewer(index)
{
    elementsSize = 96;
    imageComp = Qt.createComponent("thumb.qml");
    loadElements(thumbs,"images","noFolders");
    setFullImage(index);
}
function setFullImage(index)
{
    var fullimage = Qt.createComponent("FullImage.qml");
    fullimage.createObject(imgContainer,{"source":files.getProperty(index,"thumbnail","images"),"index":index});
}

function changeIndex (img, index, oldIndex, timer) {
    var max=files.listNumber("images");
    if(index>=max)index=0;
    else if(index<0)index=max-1;
    scroll.state = "VISIBLE";
    var thumbsChild = thumbs.children;
// SLOW CODE
//    var i1=index-1;
//    var i2=index+1;
//    for(var i=thumbs.children.length-1;i>=0;i--)
//    {
//        if(i===i1)thumbs.children[i].state = "SEMISELECTED";
//        else if(i===i2)thumbs.children[i].state = "SEMISELECTED";
//        else if(i===index)thumbs.children[i].state = "SELECTED";
//        else thumbs.children[i].state = "UNSELECTED";
//    }
    var diff = index-oldIndex;
    if (diff > 1 || diff < -1){
        thumbsChild[oldIndex].state = "UNSELECTED";
        if(oldIndex<max-1)thumbsChild[oldIndex+1].state = "UNSELECTED";
        if(oldIndex>0)thumbsChild[oldIndex-1].state = "UNSELECTED";
    }
    if(index<max-1)thumbsChild[index+1].state = "SEMISELECTED";
    if(index<max-2)thumbsChild[index+2].state = "UNSELECTED";
    if(index>0)thumbsChild[index-1].state = "SEMISELECTED";
    if(index>1)thumbsChild[index-2].state = "UNSELECTED";
    thumbsChild[index].state = "SELECTED";
    moveAnim.to = thumbsChild[index].x - fullView.width / 2 + thumbsChild[index].width / 2;
    moveAnim.start();
    autoHideThumbs.restart();
    img.index = index;
    if (timer) {
        img.tmpSource = files.getProperty(index,"thumbnail","images");
        timer.restart();
    }
    else img.source = files.getProperty(index,"thumbnail","images");
}
function loadList(type)
{
    destroyGrid();
    if(type!=="allList")loadGrid();
    if(type==="allList" || type==="allGrid")type="all";
    typesEnabled=type;
    loadElements(grid);
}
