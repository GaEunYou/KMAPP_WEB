let _imgURL = '';
let _timestemp = '';
let _logCount = 0;
let _tot = 0;
let _load = 0;
let _anal = 0;
let _img = 0;
let _timer;
let _logInfo = new Array();
let _MIN_DATE_ ='';
let _MAX_DATE_ ='';

function stopLogInfo() {
    clearInterval(_timer);
    $('#logModal').modal('hide');
}

let flag = true;
function getLogInfo() {
    _timer = setInterval(function() {
        if(flag) {
            flag = false;
        } else {
            return;
        }

        let param = 'sno=' + _timestemp;
        $.getJSON('apps/logProcess.php', param, function(result) {
            $.ajaxSetup({cache:false});

            if(result.resultCode == '9999') { //check error
                alert(result.resultMsg);
                stopLogInfo();
                flag = true;
                return;
            }

            let logData = result.resultMsg;
            let info = null;

            if(logData.length == 0) { //check log contents
                flag = true;
                return;
            }

            let offset = 0;
            if(_logCount != 0) { //이전 길이가 있는가?
                if(_logCount == logData.length) { //이전 길이와 같은가?
                    flag = true;
                    return;

                } else { //이전 길이와 다르다면?
                    offset = _logCount;
                    _logCount = logData.length;
                }

            } else {
                _logCount = logData.length;
            }

            //console.log('offset:' + offset + ' _logCount:' + _logCount + ' logData.length:' + logData.length);

            for(let i = offset; i < logData.length; i++) {
                info = logData[i].split('|');

                switch(info[0]) {
                    /*
                    case 'OPT': //옵션설정 완료
                        $('#opt').children('.timeline-badge').html('<i class="fa fa-check"></i>');
                        break;
                    */

                    case 'TOT': //총 분석파일 개수
                        _tot = parseInt(info[1]);
                        $('#load').children().eq(0).text('자료 로딩중... (0/' + _tot + ')');
                        break;

                    case 'LOAD': //분석파일 읽은 개수
                        _load += 1;

                        if(_tot == _load) {
                            $('#load').children().eq(0).text('자료 로딩완료! (' + _load + '/' + _tot + ')');
                            $('#load').children().eq(1).attr('class', 'img img-complete');

                        } else {
                            $('#load').children().eq(0).text('자료 로딩중... (' + _load + '/' + _tot + ')');
                        }
                        break;

                    case 'ANAL': //분석한 파일 개수
                        _anal += 1;
                        if(info[1] != 'complete') {
                            $('#anal').children().eq(0).text('자료 로딩중... (' + _anal + '/1)');

                        } else {
                            $('#anal').children().eq(0).text('자료 분석완료! (' + _anal + '/1)');
                            $('#anal').children().eq(1).attr('class', 'img img-complete');
                        }
                        break;

                    case 'IMG': //분석자료 이미지 생산
                        $('#img').children().eq(0).text('분석자료 이미지 생산완료!');
                        $('#img').children().eq(1).attr('class', 'img img-complete');

                        var imgFilename = info[1].split('/');
                        $('#dvImageArea').empty();
                        $('#dvImageArea').append('<img src="' + _imgURL + imgFilename[imgFilename.length - 1] + '">');

                        stopLogInfo();
                        $('#load').css('display', 'block');
                        $('#anal').css('display', 'block');
                        break;

                    case 'ERR': //로그 오류메시지
                        alert(info[1]);
                        stopLogInfo();
                        break;
                }
            }

            flag = true;
        });
    }, 1000);
}

function search() {
    let value = '';
    let param = '';

    let analFile = $('input[name="analFile"]:checked').val();
    console.log(analFile);
    if('vert' == analFile) {
        if(checkValue($('#analLevel').val())) {
            alert('고도(m) 값은 필수 입니다');
            $('#analLevel').focus();
            return;
        }
    }

    //선택 시간확인
    if(0 == $('input[name="analTime[]"]:checked').size()) {
        alert('시간(UTC) 값은 필수 입니다');
        return;
    }

    //시작, 종료일 확인
    if(checkValue($('#analStart').val())) {
        alert('[시작일] 값은 필수 입니다');
        return;
    }

    if(checkValue($('#analEnd').val())) {
        alert('[종료일] 값은 필수 입니다');
        return;
    }

    //시작, 종료일 크기 비교
    if($('#analStart').val() > $('#analEnd').val()) {
        alert('[시작일]이 [종료일] 이전 날짜 입니다.');
        return;
    }

    //분석 방법에 따른 날짜 설정
    switch($('#periodType').val()) {
        case 'months': //월별
            $('#analStart').val()
            $('#analEnd').val()
            break;

        case 'years': //년별
            break;
    }

    let vstep = $('#vstep').val();
    let vmin = $('#vmin').val();
    let vmax = $('#vmax').val();

    if(!isEmpty(vstep) || !isEmpty(vmin) || !isEmpty(vmax)) {
        if(isEmpty(vstep)) {
            alert('[간격] 값이 없습니다.');
            $('#vstep').focus();
            return;
        }

        if(isEmpty(vmin)) {
            alert('[최소] 값이 없습니다.');
            $('#vmin').focus();
            return;
        }

        if(isEmpty(vmax)) {
            alert('[최대] 값이 없습니다.');
            $('#vmax').focus();
            return;
        }
    }

    if(!isEmpty(vstep) && !isEmpty(vmin) && !isEmpty(vmax)) { //모든 값이 비어있는지 않다면
        if(!$.isNumeric(vstep)) {
            alert('[간격] 값이 숫자가 아닙니다.');
            $('#vstep').focus();
            return;
        }

        if(!$.isNumeric(vmin)) {
            alert('[최소] 값이 숫자가 아닙니다.');
            $('#vmin').focus();
            return;
        }

        if(!$.isNumeric(vmax)) {
            alert('[최대] 값이 숫자가 아닙니다.');
            $('#vmax').focus();
            return;
        }

        if(vmin >= vmax) {
            alert('[최소] 값은 [최대] 값보다 작아야 합니다.');
            $('#vmin').focus();
            return;
        }
    }

    param = $('#frmAnal').serialize() + '&' + $('#frmColor').serialize();
    console.log(param);

    startSpinner('__CONTENT_BODY__');
    $.getJSON('apps/optionProcess.php', param, function(result) {
        $.ajaxSetup({cache:false});

        //응답이 왔으면 spinner 종료
        __SUBMIT_FLAG__ = true;
        if(typeof __SPINNER__ != 'undefined') {
            __SPINNER_PANEL__.remove();
            __SPINNER__.stop();
        }

        console.log(result);
        if(result.resultCode == '0000') {
            /* "images/20200909/1599644330/" */
            _imgURL = result.resultMsg;
            _timestemp = _imgURL.split('/')[2];

            //변수 초기화
            _logCount = 0;
            _tot = 0;
            _load = 0;
            _anal = 0;
            _img = 0;
            _timer = null;
            _logInfo = new Array();

            //로그모달 내용 초기화
            $('#load').children().eq(0).text('자료 로딩중... (0/0)');
            $('#load').children().eq(1).attr('class', 'img img-loading');
            $('#anal').children().eq(0).text('자료 분석중... (0/0)');
            $('#anal').children().eq(1).attr('class', 'img img-loading');
            $('#img').children().eq(0).text('분석자료 이미지 생산중... (0/1)');
            $('#img').children().eq(1).attr('class', 'img img-loading');

            //로그모달 표출
            $('#logModal').modal({backdrop: 'static', keyboard: false});

            //log 조회 기능 실행
            getLogInfo();

        } else { //성공이 아니라면 오류메시지 출력
            alert(result.resultCode);
        }
    });
}

$('#btnSearch').click(function(event) { //분석자료 생산
    search();
});

$('#btnDraw').click(function(event) { //그래픽 옵션 수정
    if(_timestemp == undefined || _timestemp == null || _timestemp == '') {
        alert('[생성된 분석자료가 없습니다.]');
        return;
    }

    var param = 'sno=' + _timestemp + '&' + $('#frmColor').serialize();

    startSpinner('__CONTENT_BODY__');
    $.getJSON('apps/updateImgOption.php', param, function(result) {
        $.ajaxSetup({cache:false});

        //응답이 왔으면 spinner 종료
        __SUBMIT_FLAG__ = true;
        if(typeof __SPINNER__ != 'undefined') {
            __SPINNER_PANEL__.remove();
            __SPINNER__.stop();
        }

        console.log(result);
        if(result.resultCode == '0000') {
            //변수 초기화
            _logCount = 0;
            _tot = 0;
            _load = 0;
            _anal = 0;
            _img = 0;
            _timer = null;
            _logInfo = new Array();

            //로그모달 내용 초기화
            $('#load').css('display', 'none');
            $('#anal').css('display', 'none');
            $('#img').children().eq(0).text('분석자료 이미지 생산중... (0/1)');
            $('#img').children().eq(1).attr('class', 'img img-loading');

            //로그모달 표출
            $('#logModal').modal({backdrop: 'static', keyboard: false});

            //log 조회 기능 실행
            getLogInfo();

        } else { //성공이 아니라면 오류메시지 출력
            alert(result.resultCode);
        }
    });
});

$('#btnDataDown').click(function(event) { //이미지 다운로드 (추후 데이터 다운로드)
    let imgSrc = $('#dvImageArea img:first-child').attr('src');
    let a = document.createElement('a');
    let filename = imgSrc.split('/');

    a.href = imgSrc;
    a.download = filename[filename.length - 1];

    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
});

$('#btnReset').click(function(event) { //그래픽 옵션 초기화
    $('#frmColor')[0].reset();
});

$('#analLevel').keyup(function(event) {
    $(this).val($(this).val().replace(/[^0-9.]/g, ''));
});

$('input[name="chkAll"]').click(function(event) {
    let checkList = $('input[name="analTime[]"]').toArray();
    let isChecked = $('input[name="chkAll"]').is(":checked");

    checkList.forEach(function(entry) {
        entry.checked = ( isChecked ) ? true : false;
    });
});

$('input[name="analTime[]"]').click(function(event) {
    let chkAll = $('input[name="chkAll"]')[0];
    if( event.target.checked === false ) {
        chkAll.checked = false;
    } else {
        let checkList = $('input[name="analTime[]"]').toArray();
        let isAll = true;

        checkList.forEach(function(entry) {
            if( entry.checked === false ) isAll = false;
        });
        chkAll.checked = isAll;
    }
});

function analDateInfo() {
    $.ajax({
        url: "http://localhost:8080/common/analDateInfo/anal",
        type: 'get',
        dataType: 'json',
        success: function (res) {
            _MIN_DATE_ = res.data.minDate;
            _MAX_DATE_ = res.data.maxDate;

            $('#analStart').datetimepicker({
                format: 'YYYY-MM-DD',
                allowInputToggle: true,
                minDate : _MIN_DATE_,
                maxDate : _MAX_DATE_
            });

            $('#analEnd').datetimepicker({
                format: 'YYYY-MM-DD',
                allowInputToggle: true,
                minDate : _MIN_DATE_,
                maxDate : _MAX_DATE_
            });

            $('#periodType').change(function (event) {
                $('#analStart').data('DateTimePicker').date(null);
                $('#analEnd').data('DateTimePicker').date(null);

                let periodFormat = '';
                let minViewMode = $(this).val();
                $('#analStart').data('DateTimePicker').viewMode(minViewMode);
                $('#analEnd').data('DateTimePicker').viewMode(minViewMode);

                switch ($(this).val()) {
                    case 'days':
                        periodFormat = 'YYYY-MM-DD';
                        $('#analStart').data('DateTimePicker').format(periodFormat);
                        $('#analEnd').data('DateTimePicker').format(periodFormat);

                        $('#analStart').data('DateTimePicker').minDate(_MIN_DATE_);
                        $('#analStart').data('DateTimePicker').maxDate(_MAX_DATE_);
                        $('#analEnd').data('DateTimePicker').minDate(_MIN_DATE_);
                        $('#analEnd').data('DateTimePicker').maxDate(_MAX_DATE_);
                        break;

                    case 'months':
                        periodFormat = 'YYYY-MM';
                        $('#analStart').data('DateTimePicker').format(periodFormat);
                        $('#analEnd').data('DateTimePicker').format(periodFormat);

                        $('#analStart').data('DateTimePicker').minDate(_MIN_DATE_.substring(0, 7));
                        $('#analStart').data('DateTimePicker').maxDate(_MAX_DATE_.substring(0, 7));
                        $('#analEnd').data('DateTimePicker').minDate(_MIN_DATE_.substring(0, 7));
                        $('#analEnd').data('DateTimePicker').maxDate(_MAX_DATE_.substring(0, 7));
                        break;

                    case 'years':
                        periodFormat = 'YYYY';
                        $('#analStart').data('DateTimePicker').format(periodFormat);
                        $('#analEnd').data('DateTimePicker').format(periodFormat);

                        $('#analStart').data('DateTimePicker').minDate(_MIN_DATE_.split('-')[0]);
                        $('#analStart').data('DateTimePicker').maxDate(_MAX_DATE_.split('-')[0]);
                        $('#analEnd').data('DateTimePicker').minDate(_MIN_DATE_.split('-')[0]);
                        $('#analEnd').data('DateTimePicker').maxDate(_MAX_DATE_.split('-')[0]);
                        break;
                }
            });

            function calcPredDate(type, objValue) {
                let rtnValue = '';
                switch ($('#periodType').val()) {
                    case 'months':
                        let tokens = objValue.split('-');
                        if ('START' == type) {
                            objValue = objValue + '-01';
                        } else if ('END' == type) {
                            let lastDate = new Date(tokens[0], tokens[1], 0);
                            objValue = objValue + '-' + lastDate.getDate();
                        }
                        break;

                    case 'years':
                        if ('START' == type) {
                            objValue = objValue + '-01-01';
                        } else if ('END' == type) {
                            let lastDate;
                            let tokens = _MAX_DATE_.split('-');
                            if (objValue < tokens[0]) {
                                lastDate = new Date(objValue, 12, 0);
                                objValue = objValue + '-12-' + lastDate.getDate();
                            } else if (objValue == tokens[0]) {
                                objValue = _MAX_DATE_;
                            }
                        }
                        break;

                    default:
                        return '';
                        break;
                }

                if (_MIN_DATE_ > objValue) {
                    rtnValue = _MIN_DATE_;
                } else if (_MAX_DATE_ < objValue) {
                    rtnValue = _MAX_DATE_;
                } else {
                    rtnValue = objValue;
                }
                return rtnValue;
            }

            $('#analEnd').on('dp.change', function (event) {
                let rtnValue = calcPredDate('END', $(this).val());
                if (!isEmpty(rtnValue)) {
                    $(this).val(rtnValue);
                }
            });

            $('#analStart').on('dp.change', function (event) {
                let rtnValue = calcPredDate('START', $(this).val());
                if (!isEmpty(rtnValue)) {
                    $(this).val(rtnValue);
                }
            });
        }
    });
}

$('.pred-Date-addon2').click(function() {
    $('#analEnd').data("DateTimePicker").show();
});

$('.pred-Date-addon1').click(function() {
    $('#analStart').data("DateTimePicker").show();
});

$('.box-radio input').on('click', function (){
    let par = $(this).closest('.box-radio')
    if ($(this).prop('checked', true)) {
        if (par.hasClass('relative01')){
            $('.relative02-group input').prop('checked',false);
            $('.relative01-group .inp:first-child input').prop('checked',true);
            document.getElementById('analLevel').placeholder = '';
        }
        if (par.hasClass('relative02')){
            $('.relative01-group input').prop('checked',false);
            $('.relative02-group .inp:first-child input').prop('checked',true);
            document.getElementById('analLevel').placeholder = '5 ~ 2991.6';
        }
    }
});

$('.relative01-group input').on('click', function (){
    document.getElementById('analLevel').placeholder = '';
    $('.relative02-group input').prop('checked',false);
    $('.relative02 input').prop('checked',false);
    $('.relative01 input').prop('checked',true);
});

$('.relative02-group input').on('click', function (){
    if('temperature' == this.value) {
        document.getElementById('analLevel').placeholder = '5 ~ 2991.6';
    } else if('wind' == this.value) {
        document.getElementById('analLevel').placeholder = '2.5 ~ 2893.3';
    }

    $('.relative01-group input').prop('checked',false);
    $('.relative01 input').prop('checked',false);

    $('.relative02 input').prop('checked',true);
});

$('.btn_manual').click(function() {
    popupCenter('kmapp_manual', 'KMAPP Manual', '1200', '800');
});

