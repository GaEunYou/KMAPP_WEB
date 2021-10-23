<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%-- header --%>
<%@include file="common/header.jsp"%>

<body id="__CONTENT_BODY__">
    <!-- wrap -->
    <div id="wrap">

        <!-- header -->
        <div id="header">
            <div class="header-inner">
                <h1 class="logo">
                    <a href="index">
                        <img src="resources/img/logo/logo01.png" alt="책임운영기관 국립기상과학원">
                        <strong>KMAPP 분석 시스템</strong>
                    </a>
                    <button type="button" class="btn_manual">
                        <img src="resources/img/ico/ico_manual.png" alt="매뉴얼" class="ico_manual">매뉴얼 보기
                    </button>
                </h1>
            </div>
        </div>
        <!-- //header -->

        <!-- container -->
        <div id="container">
            <!-- content -->
            <div id="content">
                <div class="content">
                    <div class="nav">
                        <div class="tit-wrap">
                            <h2>분석자료 생산</h2>
                        </div>
                        <div class="form-tag">
                            <form id="frmAnal" name="frmAnal">
                                <div class="col">
                                    <label class="inp box-radio relative01">
                                        <input type="radio" id="analFile" name="analFile" value="surf" checked>
                                        <b>지표자료</b>
                                    </label>
                                    <div class="mt10 relative01-group">
                                        <label class="inp"><input type="radio" name="analItem" checked value="temperature"><b>기온(℃)<i></i></b></label>
                                        <label class="inp"><input type="radio" name="analItem" value="relhumidity"><b>습도(%)<i></i></b></label>
                                        <label class="inp"><input type="radio" name="analItem" value="visibility"><b>시정(km)<i></i></b></label>
                                        <label class="inp ml0 mt10"><input type="radio" name="analItem" value="wind"><b>바람(m/s)<i></i></b></label>
                                        <label class="inp mt10"><input type="radio" name="analItem" value="downward_SW_flux"><b>태양광(W/㎡)<i></i></b></label>
                                    </div>
                                    <label class="inp box-radio mt10 relative02">
                                        <input type="radio" id="analFile" name="analFile" value="vert">
                                        <b>연직자료</b>
                                    </label>
                                    <div class="mt10 relative02-group">
                                        <label class="inp"><input type="radio" name="analItem" value="temperature"><b>기온(℃)<i></i></b></label>
                                        <label class="inp"><input type="radio" name="analItem" value="wind"><b>바람(m/s)<i></i></b></label>
                                    </div>
                                </div>
                                <div class="col">
                                    <label class="inp inp-text">
                                        <b>고도(m)</b>
                                        <input type="text" name="analLevel" id="analLevel">
                                    </label>
                                </div>
                                <div class="col">
                                    <strong class="col-tit">시간(UTC)</strong>
                                    <div class="mt10">
                                        <label class="inp"><input type="checkbox" name="chkAll" checked><b>전체<i></i></b></label>
                                        <label class="inp"><input type="checkbox" name="analTime[]" value="00" checked><b>00<i></i></b></label>
                                        <label class="inp"><input type="checkbox" name="analTime[]" value="03" checked><b>03<i></i></b></label>
                                        <label class="inp"><input type="checkbox" name="analTime[]" value="06" checked><b>06<i></i></b></label>
                                        <label class="inp"><input type="checkbox" name="analTime[]" value="09" checked><b>09<i></i></b></label>
                                        <br>
                                        <label class="inp ml0 mt10"><input type="checkbox" name="analTime[]" value="12" checked><b>12<i></i></b></label>
                                        <label class="inp mt10"><input type="checkbox" name="analTime[]" value="15" checked><b>15<i></i></b></label>
                                        <label class="inp mt10"><input type="checkbox" name="analTime[]" value="18" checked><b>18<i></i></b></label>
                                        <label class="inp mt10"><input type="checkbox" name="analTime[]" value="21" checked><b>21<i></i></b></label>
                                    </div>
                                </div>
                                <div class="col">
                                    <strong class="col-tit">분석방법</strong>
                                    <select name="analType" id="analType">
                                        <option value="avg" selected>평균</option>
                                        <option value="max">최대</option>
                                        <option value="min">최소</option>
                                    </select>
                                    <strong class="col-tit">기간</strong>
                                    <select name="periodType" id="periodType">
                                        <option value="days" selected>일별</option>
                                        <option value="months">월별</option>
                                        <option value="years">년별</option>
                                    </select>
                                    <strong class="col-tit">시작</strong>
                                    <div class="form-group input-group input-append date date-ymdhm" data-date-format="yyyy-mm-dd">
                                        <input type="text" class="form-control" name="analStart" id="analStart" />
                                        <span class="input-group-addon add-on pred-Date-addon1">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                    </div>
                                    <strong class="col-tit">종료</strong>
                                    <div class="form-group input-group input-append date date-ymdhm" data-date-format="yyyy-mm-dd">
                                        <input type="text" class="form-control" name="analEnd" id="analEnd" />
                                        <span class="input-group-addon add-on pred-Date-addon2">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                    </div>
                                    <strong class="col-tit">영역</strong>
                                    <select name="analArea" id="analArea">
                                        <option value="Hkor" selected>대한민국</option>
                                        <option value="Seoul">서울</option>
                                        <option value="Daejeon">대전</option>
                                        <option value="Daegu">대구</option>
                                        <option value="Busan">부산</option>
                                        <option value="Gwangju">광주</option>
                                        <option value="Jeju">제주</option>
                                        <option value="Incheon">인천</option>
                                        <option value="Ulsan">울산</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="btn-wrap">
                            <button type="button" class="btn-large btn-blue" id="btnSearch">분석자료 생산</button>
                        </div>
                    </div>
                    <div class="section mt0">
                        <form id="frmColor" name="frmColor">
                            <div class="tit-wrap">
                                <h2>그래픽 옵션</h2>
                            </div>
                            <div class="form-tag form-flex mt20">
                                <strong class="col-tit">색상</strong>
                                <select id="color" name="color">
                                    <option value="None" selected>Default</option>
                                    <option value="BlueRed">Blue-Red</option>
                                    <option value="BlueYellowRed">Blue-Yellow-Red</option>
                                    <option value="WhiteBlue">White-Blue</option>
                                    <option value="WhiteYellowOrangeRed">White-Yellow-Orange-Red</option>
                                </select>
                                <strong class="col-tit">간격</strong>
                                <input type="text" class="ac" style="flex:1 0 55px;max-width:55px;" id="vstep" name="vstep" >
                                <strong class="col-tit">최소</strong>
                                <input type="text" class="ac" style="flex:1 0 55px;max-width:55px;" id="vmin" name="vmin" >
                                <strong class="col-tit">최대</strong>
                                <input type="text" class="ac" style="flex:1 0 55px;max-width:55px;" id="vmax" name="vmax">
                                <strong class="col-tit">크기</strong>
                                <select style="flex:1 0 65px;max-width:65px;" id="legendSize" name="legendSize">
                                    <option value="1" selected>1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                                <strong class="col-tit">위치</strong>
                                <select style="flex:1 0 100px;max-width:100px;" id="legendPosition" name="legendPosition">
                                    <option value="vertical">세로막대</option>
                                    <option value="horizontal">가로막대</option>
                                </select>
                            </div>
                            <div class="btn-wrap mt20">
                                <div class="fr">
                                    <button type="button" class="btn-large btn-blue" id="btnDraw">그리기</button>
                                    <button type="button" class="btn-large btn-blue" id="btnDataDown">이미지 다운로드</button>
                                    <button type="button" class="btn-large btn-blue" id="btnReset">옵션설정 초기화</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="section">
                        <div class="map-thumb" id="dvImageArea">
                            <img class="NO-CACHE" src="resources/img/thumb/kmapp.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
            <!-- //content -->

            <%-- footer --%>
            <%@include file="common/footer.jsp"%>

        </div>
    </div>
    <!-- //wrap -->

    <!-- Log Modal -->
    <div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="section">
                    <div class="tit-wrap">
                        <h2>분석자료 생산 진행상황</h2>
                        <button type="button" class="modal-close" data-dismiss="modal"><img src="resources/img/ico/btn-gnb-close.svg" alt=""></button>
                    </div>
                    <div class="modal-body-scroll">
                        <ul class="log-list">
                            <li id="load">
                                <strong>자료 로딩중... (0/0)</strong>
                                <div class="img img-complete"><span class="blind">완료</span></div>
                            </li>
                            <li id="anal">
                                <strong>자료 분석중... (0/0)</strong>
                                <div class="img img-loading"><span class="blind">완료</span></div>
                            </li>
                            <li id="img">
                                <strong>분석자료 이미지 생산중... (0/1)</strong>
                                <div class="img img-loading"><span class="blind">완료</span></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- script --%>
    <script src="resources/js/kmapp.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            analDateInfo();
        });
    </script>

</body>
</html>
