let _timestamp = new Date().getTime();
let _flag = false;
let _MIN_DATE_ = '';
let _MAX_DATE_ = '';
let _MIN_INFO_ = '';
let _MAX_INFO_ = '';
let _arrayImage = [];

// 예측 파일 생성 로그
function getFileLogInfo() {
    console.log("로그조회시작! _flag=" + _flag);
    if (_flag) { //_flag==true
        $.ajax({
            url: "http://192.168.1.237:9000/kmappApi/pred/log/" + _timestamp,
            type: 'get',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                let intLogStatus = data.data.intLogStatus;
                let ncCnt = data.data.ncCnt;
                let imgCnt = data.data.imgCnt;
                let realPath = data.data.imgPath;

                console.log("intLogStatus="+intLogStatus);
                console.log("ncCnt="+ncCnt);
                console.log("imgCnt="+imgCnt);
                console.log("realPath="+realPath);

                switch (intLogStatus) {
                    case 19:
                        $('#load').children(":eq(0)").text('요청자료 생성 완료!!');
                        $('#load').children(":eq(1)").attr('class', 'img img-complete');
                        break;

                    case 30:
                        $('#vismaster').children(":eq(0)").text('예측자료 생성중...(' + ncCnt + '/49)');
                        break;

                    case 39:
                        $('#vismaster').children(":eq(0)").text('예측자료 생성 완료!!!(' + ncCnt + '/49)');
                        $('#vismaster').children(":eq(1)").attr('class', 'img img-complete');
                        break;

                    case 40:
                        $('#load').children(":eq(0)").text('요청자료 생성 완료!!');
                        $('#load').children(":eq(1)").attr('class', 'img img-complete');
                        $('#vismaster').children(":eq(0)").text('예측자료 생성 완료!!!(' + ncCnt + '/49)');
                        $('#vismaster').children(":eq(1)").attr('class', 'img img-complete');
                        $('#img1').children(":eq(0)").text('예측자료 이미지 생산중...(' + imgCnt + '/' + ncCnt + ')');
                        //_arrayImage.push(imgPath);
                        console.log(_arrayImage);
                        break;

                    case 49:
                        $('#img1').children(":eq(0)").text('예측자료 이미지 생산 완료!!!');
                        $('#img1').children(":eq(1)").attr('class', 'img img-complete');
                        break;

                    case 99:
                        _flag = false;
                        //setImage();
                        $('#logModal').modal('hide');
                }
            }
        });
    }
}

// 결과 이미지 셋팅
function setImage() {
    for (i=0; i<_arrayImage.length; i++){
        $('#resultImage').empty();
        $('#resultImage').append('<div class="map-thumb img-dnsc" style="display:none;"><img src="'+ _arrayImage[i] +'" onclick="javascript:imgPopup(this);"></div>');
    }
}

// 예측 자료 생산
function search() {
    let vstep = $('#vstep').val();
    let vmin = $('#vmin').val();
    let vmax = $('#vmax').val();

    if (!isEmpty(vstep) || !isEmpty(vmin) || !isEmpty(vmax)) {
        if (isEmpty(vstep)) {
            alert('[간격] 값이 없습니다.');
            $('#vstep').focus();
            return;
        }

        if (isEmpty(vmin)) {
            alert('[최소]값이 없습니다.');
            $('#vmin').focus();
            return;
        }

        if (isEmpty(vmax)) {
            alert('[최대]값이 없습니다.');
            $('#vmax').focus();
            return;
        }
    }

    if (!isEmpty(vstep) && !isEmpty(vmin) && !isEmpty(vmax)) { //모든 값이 비어 있지 않다면
        if (!$.isNumeric(vstep)) {
            alert('[간격] 값이 숫자가 아닙니다.');
            $('#vstep').focus();
            return;
        }

        if (!$.isNumeric(vmin)) {
            alert('[최소] 값이 숫자가 아닙니다.');
            $('#vmin').focus();
            return;
        }

        if (!$.isNumeric(vmax)) {
            alert('[최대] 값이 숫자가 아닙니다.');
            $('vmax').focus();
            return;
        }
    }

    let param ={
        sno: _timestamp,
        dataPath: "",
        predLevel: $('#predLevel').val(),
        predItem: $('#predItem').val(),
        periodType: "days",
        predTime: $('#predDate').val().split("-").join("") + $('#predTime').val(),
        predType: $('#predType').val(),
        predArea: $('#predArea').val(),
        drawOption: {
            color:$('#color').val(),
            vstep:parseInt($('#vstep').val()),
            vmin:parseInt($('#vmin').val()),
            vmax:parseInt($('#vmax').val()),
            legendSize:parseInt($('#legendSize').val()),
            legendPosition:$('#legendPosition').val()
        }
    }
    console.log(JSON.stringify(param));

    //로그모달 표출
    $('#logModal').modal({backdrop: 'static', keyboard: false});

    $.ajax({
        type: 'post',
        url: 'http://192.168.1.237:9000/kmappApi/pred/produce/surf',
        contentType: 'application/json',
        data: JSON.stringify(param),
        dataType: 'json',
        success : function (data) {
            console.log(data);
        },
        error: function (error) {
            alert(error);
        }
    });

    _flag = true;
}

// 자료 생성 가능 날짜 범위 조회
function predDateInfo() {
    $.ajax({
        type: 'get',
        url: "http://192.168.1.237:9000/kmappApi/common/analDateInfo/pred",
        dataType: 'json',
        success: function (res) {
            console.log(res);
            _MIN_DATE_ = res.data.minDate;
            _MAX_DATE_ = res.data.maxDate;
            _MIN_INFO_ = _MIN_DATE_.split(':');
            _MAX_INFO_ = _MAX_DATE_.split(':');
            console.log(_MIN_INFO_);
            console.log(_MAX_INFO_);

            $('#predDate').datetimepicker({
                format: 'YYYY-MM-DD',
                allowInputToggle: true,
                minDate: _MIN_INFO_[0],
                maxDate: _MAX_INFO_[0]
            }).on('dp.change', function (event) { //날짜에 따른 시간 설정
                let temp = event.date.format('YYYY-MM-DD');
                let minDate = _MIN_INFO_[0];
                let maxDate = _MAX_INFO_[0];

                $('#predTime')[0].options.length = 0;
                $('#predTime').append('<option value="00">00</option><option value="06">06</option><option value="12">12</option><option value="18">18</option>');

                if (temp == minDate) {
                    $('#predTime option').each(function () {
                        if ($(this).val() < minDate[1]){
                            $(this).remove();
                        }
                    });
                } else if (temp == maxDate) {
                    $('#predTime option').each(function () {
                        if ($(this).val() > maxDate[1]) {
                            $(this).remove();
                        }
                    });
                }
            });
        }
    });
}

function getImgList(path) {
    $.ajax({
        type: 'get',
        url: 'http://localhost:9100/imgFind?path=' + path,
        success : function (data) {
            $('#resultImage').empty();
            console.log(data);
            _arrayImage = data;
            for (let i=0; i<_arrayImage.length; i++){
                $('#resultImage').append('<div class="map-thumb img-dnsc" style="display: none;"><img src="' + _arrayImage[i].path + '" onclick="javascript:imgPopup(this);"></div>');
                $('#baseDate').text($('#predDate').val() + ' ' + $('#predTime').val());
                $('#imageBox').css('display', 'none');
                $('#resultImage').css('display', 'block');
            }
        },
        error: function (error) {
            console.log(error.responseText);
        }
    });
    let result = "";
    return result;
}
// 테스트
$('#btnTest').click(function () {
    getImgList("images/20211011/123456789");
});

// 예측자료생산 버튼 클릭 이벤트
$('#btnImgSearch').click(function () {
    search();
});

// 그리기버튼 클릭 이벤트
$('#btnDraw').click(function() {
    search();
});

// 메뉴얼보기 버튼 클릭 이벤트
$('.btn_manual').click(function() {
    popupCenter('resources/img/thumb/dnsc_manual.pdf', 'DNSC Manual', '1200', '800');
});

// 초기화 버튼 클릭 이벤트
$('#btnReset').click(function () {
    $('#color option:eq(0)').prop("selected", true);
    $('#vstep').val('');
    $('#vmin').val('');
    $('#vmax').val('');
    $('#legendSize option:eq(0)').prop("selected", true);
    $('#legendPosition option:eq(0)').prop("selected", true);
});

// 이미지 다운로드 버튼 클릭 이벤트
$('#btnDataDown').click(function(event) {
    let imgSrc, tokens;

    if(document.getElementById('resultImage').children.length == 0) {
        imgSrc = document.getElementById('resultImage').firstElementChild.getAttribute('src');
        tokens = imgSrc.split('/');
        saveToDisk(imgSrc, tokens[tokens.length - 1]);
        return;
    }

    imgSrc = document.getElementById('resultImage').children[_IMG_IDX_].firstElementChild.getAttribute('src');
    console.log(imgSrc);
    tokens = imgSrc.split('/');
    saveToDisk(imgSrc, tokens[tokens.length - 1]);
});

// prev 버튼 클릭 & 이미지 변경 이벤트
$('.btn_controller_prev').on('click', function(e) {
    moving(-1);
});

// next 버튼 클릭 & 이미지 변경 이벤트
$('.btn_controller_next').on('click', function(e) {
    moving(1);
});

// play&stop 버튼 클릭 & 타이머 작동 이벤트
$('.slide-play-btn').on('click', function(e) {
    if( $('.slide-play-btn').hasClass('active') ) {
        $('.slide-play-btn').removeClass('active');
        $('.slide-play-btn img').attr('src', 'resources/img/ico/btn_controller_play2.gif');
        clearInterval(imageTimer);

    } else {
        $('.slide-play-btn').addClass('active');
        $('.slide-play-btn img').attr('src', 'resources/img/ico/btn_controller_stop2.gif');

        imageTimer = setInterval("playImage()", 500);
    }
});

// image 재생용 setInterval 함수
function playImage() {
    moving(1);
}

let _IMG_IDX_ = 0;
function viewTm(idx, mode) {
    if(document.getElementById('resultImage').children.length == 0) {
        return;
    }

    let viewMode = '';

    if(mode == 1) {
        viewMode = 'visible';
        document.getElementById('timeLabel').children[idx].style.backgroundColor = "#aaffaa";
        document.getElementById('timeBar').children[idx].style.backgroundColor = "#aaffaa";

    } else {
        if(_IMG_IDX_ == idx) {
            viewMode = 'visible';
            document.getElementById('timeLabel').children[idx].style.backgroundColor = "#aaffaa";
            document.getElementById('timeBar').children[idx].style.backgroundColor = "#aaffaa";

        } else {
            viewMode = 'hidden';
            document.getElementById('timeLabel').children[idx].style.backgroundColor = "#ffffff";
            document.getElementById('timeBar').children[idx].style.backgroundColor = "#bbbbbb";
        }
    }

    //document.getElementById('timeLabel').children[idx].style.visibility = viewMode;
}

function viewImg(idx) {
    if(document.getElementById('resultImage').children.length == 0) {
        return;
    }

    //$('.tm-label').css('visibility', 'hidden');

    $('.tm-bar').css('backgroundColor', '#bbbbbb');
    $('.tm-label').css('backgroundColor', '#ffffff');
    $('.img-dnsc').css('display', 'none');

    document.getElementById('resultImage').children[idx + 1].style.display = 'block';

    _IMG_IDX_ = idx;
    viewTm(idx, 1);
}

function moving(idx) {
    if(document.getElementById('resultImage').children.length == 0) {
        return;
    }

    //$('.tm-label').css('visibility', 'hidden');

    _IMG_IDX_ = (_IMG_IDX_ + idx + 49 ) % 49

    viewImg(_IMG_IDX_);
}

function doKey() {
    if(event.keyCode == 37) { //왼쪽
        moving(-1);

    } else if(event.keyCode == 39) { //오른쪽
        moving(1);
    }
}

function doScroll() {
    document.querySelector('#loc_pop_wrap_nc .loc_pop_nc').style.top = (document.documentElement.scrollTop + 150) + 'px';
}

//예측자료 조회
function getJsonData(type, stnId) {
    //console.log(type + ', ' + stnId);
    //var url = 'http://192.168.0.72/~koast/database/' + type + '_' + $('#predItem').val() + '.json'; //test
    let url = _imgURL + type + '_' + $('#predItem').val() + '.json';
    //console.log(url);

    let database; //AWS Database 설정
    if('Capital' == type) {
        database = capitalData;
    } else {
        database = seoulData;
    }

    //aws 명칭 설정
    for(let i = 0; i < database.length; i++) {
        if(stnId != database[i].stn) {
            continue;
        } else {
            $('#ncgraph_title').html('AWS ' + database[i].name + '[' + database[i].stn + ']');
            break;
        }
    }

    let tm = new Array();
    let tmSummary = new Array();
    let baseDate = new Date($('#predDate').val().replace(/-/gi, '/') + ' ' + $('#predTime').val() + ':00');

    let data1 = new Array();
    let data2 = new Array();
    let data2_wd = new Array();//풍향 한글

    let table_html = '<tr><th scope="col"></th>';
    let add_html1 = '';
    let add_html2 = '';

    switch($('#predItem').val()) {
        case 'temperature':
            add_html1 = '<tr><th scope="row">기온</th>';
            break;

        case 'relhumidity':
            add_html1 = '<tr><th scope="row">습도</th>';
            break;

        case 'visibility':
            add_html1 = '<tr><th scope="row">시정</th>';
            break;

        case 'wind':
            add_html1 = '<tr><th scope="row">풍속</th>';
            add_html2 = '<tr><th scope="row">풍향</th>';
            break;

        case 'downward_SW_flux':
            add_html1 = '<tr><th scope="row">태양광</th>';
            break;
    }

    let tmp;
    $.getJSON(url, '', function(result) {
        $.ajaxSetup({cache:false, async:false});

        let val;
        for(let i = 0; i < result.length; i++) { //index로 key가 잡혀있음
            table_html += '<th scope="col">' + i + '</th>';

            //날짜 설정
            tm.push(baseDate.getFullYear() + "년 " + lpad((Number(baseDate.getMonth()) + 1), 2, 0) + "월 " + lpad(baseDate.getDate(), 2, 0) + "일 " + lpad(baseDate.getHours(), 2, 0) + "시");
            tmSummary.push(lpad(baseDate.getHours(), 2, 0) + "H<br/>" + baseDate.getFullYear() + "." + lpad((Number(baseDate.getMonth()) + 1), 2, 0) + "." + lpad(baseDate.getDate(), 2, 0));
            baseDate.setHours(baseDate.getHours() + 1);

            val = result[i][i][stnId][$('#predItem').val()];
            if('wind' == $('#predItem').val()) { //바람
                val = result[i][i][stnId];
                tmp = parseFloat(val["windspeed"]).toFixed(1);
                data1.push(tmp);

                let wd = parseFloat(val["winddirection"]).toFixed(1);
                data2.push({y:0, marker:{symbol:'url(common/img/ico/wind_' + direct_8_en(wd) + '.png)'}});
                data2_wd.push(direct_8(wd));

                add_html1 += '<td>' + tmp + '</td>';
                add_html2 += '<td>' + direct_8(wd) + '</td>';

            } else {
                tmp = parseFloat(val).toFixed(1);
                data1.push(tmp);
                add_html1 += '<td>' + tmp + '</td>';
            }
        }

        table_html += '</tr>';
        if('wind' != $('#predTime').val()){
            add_html1 += '</tr>';
            add_html2 += '</tr>';
        }else{
            add_html1 += '</tr>';
        }

        setData(tm, tmSummary, data1, data2, data2_wd, table_html, add_html1, add_html2);
    });
}

//AWS 지점표시
function setEvent() {
    $('.checkzone').click(function() {
        console.log(document.getElementById('chkCapital').checked);

        if(document.getElementById('chkCapital').checked) {
            $('#alphaCapital').css('display', 'block');
        } else {
            $('#alphaCapital').css('display', 'none');
        }
    });

    $('.checkzone_two').click(function() {
        console.log(document.getElementById('chkSeoul').checked);

        if(document.getElementById('chkSeoul').checked) {
            $('#alphaSeoul').css('display', 'block');
        } else {
            $('#alphaSeoul').css('display', 'none');
        }
    });
}

function close_ncGraph(id) {
    $('#' + id).hide();
}








