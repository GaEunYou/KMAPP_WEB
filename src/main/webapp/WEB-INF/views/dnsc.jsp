<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%-- header --%>
<%@include file="common/header.jsp"%>

<body>
    <!-- wrap -->
    <div id="wrap">

        <!-- header -->
        <div id="header">
            <div class="header-inner">
                <h1 class="logo">
                    <a href="index">
                        <img src="resources/img/logo/logo01.png" alt="책임운영기관 국립기상과학원">
                        <strong>KMAPP 예측 시스템</strong>
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
                    <div class="nav nav2">
                        <div class="tit-wrap">
                            <h2>예측자료 생산</h2>
                        </div>
                        <div class="form-tag">
                            <form id="frmPred" name="frmPred">
                                <strong class="col-tit col-tit-br">날짜</strong>
                                <div class="form-group input-group input-append date date-ymdhm" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control" name="predDate" id="predDate" />
                                    <span class="input-group-addon add-on pred-Date-addon3">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <strong class="col-tit col-tit-br">시간 UTC</strong>
                                <select style="width:100%;" id="predTime" name="predTime">
                                    <option value="00">00</option>
                                    <option value="06">06</option>
                                    <option value="12">12</option>
                                    <option value="18">18</option>
                                </select>
                                <strong class="col-tit col-tit-br">구분</strong>
                                <select style="width:100%;" id="predType" name="predType">
                                    <option value="surf">지표자료</option>
                                </select>
                                <strong class="col-tit col-tit-br">항목</strong>
                                <select style="width:100%;" id="predItem" name="predItem">
                                    <option value="temperature">기온(℃)</option>
                                    <option value="relhumidity">습도(%)</option>
                                    <option value="visibility">시정(km)</option>
                                    <option value="wind">바람(m/s)</option>
                                    <option value="downward_SW_flux">태양광(W/㎡)</option>
                                </select>
                                <strong class="col-tit col-tit-br">고도(m)</strong>
                                <input type="text" class="form-control" name="predLevel" id="predLevel" value="1.5" readonly />
                                <strong class="col-tit col-tit-br">영역</strong>
                                <select style="width:100%;" name="predArea" id="predArea">
                                    <option value="Seoul">서울</option>
                                    <option value="Daejeon">대전</option>
                                    <option value="Daegu">대구</option>
                                    <option value="Busan">부산</option>
                                    <option value="Gwangju">광주</option>
                                    <option value="Jeju">제주</option>
                                    <option value="Incheon">인천</option>
                                    <option value="Ulsan">울산</option>
                                </select>
                            </form>
                        </div>
                        <div class="btn-wrap">
                            <button type="button" class="btn-large btn-blue" id="btnImgSearch">예측자료 생산</button>
                            <button type="button" class="btn-large btn-blue" id="btnTest">파일 경로보기</button>

                        </div>
                    </div>

                    <div class="section section2 mt0">
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

                    <div class="section section3" style="padding-top: 0px;">
                        <div id="dvImageArea" style="margin-bottom: 15px;">
                            <table border="0" cellspacing="0" cellpadding="0" style="text-align: center; border-spacing: 2px;">
                                <tr>
                                    <td colspan="20" style="text-align:left;">
                                        <span>날짜 : </span><span id="baseDate">YYYY-MM-DD HH</span>&nbsp;시
                                    </td>
                                    <td colspan="29" style="font-size:0; text-align:right;">
                                        <a href="#none" class="btn_controller_prev"><img src="resources/img/ico/btn_controller_prev2.gif" alt="이전" class="big"></a>
                                        <a href="#none" class="slide-play-btn on"><img src="resources/img/ico/btn_controller_play2.gif" alt="재생" class="big"></a>
                                        <a href="#none" class="btn_controller_next"><img src="resources/img/ico/btn_controller_next2.gif" alt="다음" class="big"></a>
                                    </td>
                                </tr>
                                <tr id="timeBar" height="17" bgcolor="#bbbbbb" style="font-family:Verdana; font-size:3pt; cursor:hand;">
                                    <td class="tm-bar" onclick="viewImg(0);" onmouseout="viewTm(0,0);" onmouseover="viewTm(0,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(1);" onmouseout="viewTm(1,0);" onmouseover="viewTm(1,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(2);" onmouseout="viewTm(2,0);" onmouseover="viewTm(2,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(3);" onmouseout="viewTm(3,0);" onmouseover="viewTm(3,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(4);" onmouseout="viewTm(4,0);" onmouseover="viewTm(4,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(5);" onmouseout="viewTm(5,0);" onmouseover="viewTm(5,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(6);" onmouseout="viewTm(6,0);" onmouseover="viewTm(6,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(7);" onmouseout="viewTm(7,0);" onmouseover="viewTm(7,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(8);" onmouseout="viewTm(8,0);" onmouseover="viewTm(8,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(9);" onmouseout="viewTm(9,0);" onmouseover="viewTm(9,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(10);" onmouseout="viewTm(10,0);" onmouseover="viewTm(10,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(11);" onmouseout="viewTm(11,0);" onmouseover="viewTm(11,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(12);" onmouseout="viewTm(12,0);" onmouseover="viewTm(12,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(13);" onmouseout="viewTm(13,0);" onmouseover="viewTm(13,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(14);" onmouseout="viewTm(14,0);" onmouseover="viewTm(14,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(15);" onmouseout="viewTm(15,0);" onmouseover="viewTm(15,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(16);" onmouseout="viewTm(16,0);" onmouseover="viewTm(16,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(17);" onmouseout="viewTm(17,0);" onmouseover="viewTm(17,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(18);" onmouseout="viewTm(18,0);" onmouseover="viewTm(18,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(19);" onmouseout="viewTm(19,0);" onmouseover="viewTm(19,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(20);" onmouseout="viewTm(20,0);" onmouseover="viewTm(20,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(21);" onmouseout="viewTm(21,0);" onmouseover="viewTm(21,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(22);" onmouseout="viewTm(22,0);" onmouseover="viewTm(22,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(23);" onmouseout="viewTm(23,0);" onmouseover="viewTm(23,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(24);" onmouseout="viewTm(24,0);" onmouseover="viewTm(24,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(25);" onmouseout="viewTm(25,0);" onmouseover="viewTm(25,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(26);" onmouseout="viewTm(26,0);" onmouseover="viewTm(26,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(27);" onmouseout="viewTm(27,0);" onmouseover="viewTm(27,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(28);" onmouseout="viewTm(28,0);" onmouseover="viewTm(28,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(29);" onmouseout="viewTm(29,0);" onmouseover="viewTm(29,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(30);" onmouseout="viewTm(30,0);" onmouseover="viewTm(30,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(31);" onmouseout="viewTm(31,0);" onmouseover="viewTm(31,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(32);" onmouseout="viewTm(32,0);" onmouseover="viewTm(32,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(33);" onmouseout="viewTm(33,0);" onmouseover="viewTm(33,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(34);" onmouseout="viewTm(34,0);" onmouseover="viewTm(34,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(35);" onmouseout="viewTm(35,0);" onmouseover="viewTm(35,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(36);" onmouseout="viewTm(36,0);" onmouseover="viewTm(36,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(37);" onmouseout="viewTm(37,0);" onmouseover="viewTm(37,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(38);" onmouseout="viewTm(38,0);" onmouseover="viewTm(38,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(39);" onmouseout="viewTm(39,0);" onmouseover="viewTm(39,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(40);" onmouseout="viewTm(40,0);" onmouseover="viewTm(40,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(41);" onmouseout="viewTm(41,0);" onmouseover="viewTm(41,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(42);" onmouseout="viewTm(42,0);" onmouseover="viewTm(42,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(43);" onmouseout="viewTm(43,0);" onmouseover="viewTm(43,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(44);" onmouseout="viewTm(44,0);" onmouseover="viewTm(44,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(45);" onmouseout="viewTm(45,0);" onmouseover="viewTm(45,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(46);" onmouseout="viewTm(46,0);" onmouseover="viewTm(46,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(47);" onmouseout="viewTm(47,0);" onmouseover="viewTm(47,1);" >&nbsp;</td>
                                    <td class="tm-bar" onclick="viewImg(48);" onmouseout="viewTm(48,0);" onmouseover="viewTm(48,1);" >&nbsp;</td>
                                </tr>
                                <tr id='timeLabel'>
                                    <td class="tm-label">00</td><td class="tm-label">01</td><td class="tm-label">02</td><td class="tm-label">03</td><td class="tm-label">04</td>
                                    <td class="tm-label">05</td><td class="tm-label">06</td><td class="tm-label">07</td><td class="tm-label">08</td><td class="tm-label">09</td>
                                    <td class="tm-label">10</td><td class="tm-label">11</td><td class="tm-label">12</td><td class="tm-label">13</td><td class="tm-label">14</td>
                                    <td class="tm-label">15</td><td class="tm-label">16</td><td class="tm-label">17</td><td class="tm-label">18</td><td class="tm-label">19</td>
                                    <td class="tm-label">20</td><td class="tm-label">21</td><td class="tm-label">22</td><td class="tm-label">23</td><td class="tm-label">24</td>
                                    <td class="tm-label">25</td><td class="tm-label">26</td><td class="tm-label">27</td><td class="tm-label">28</td><td class="tm-label">29</td>
                                    <td class="tm-label">30</td><td class="tm-label">31</td><td class="tm-label">32</td><td class="tm-label">33</td><td class="tm-label">34</td>
                                    <td class="tm-label">35</td><td class="tm-label">36</td><td class="tm-label">37</td><td class="tm-label">38</td><td class="tm-label">39</td>
                                    <td class="tm-label">40</td><td class="tm-label">41</td><td class="tm-label">42</td><td class="tm-label">43</td><td class="tm-label">44</td>
                                    <td class="tm-label">45</td><td class="tm-label">46</td><td class="tm-label">47</td><td class="tm-label">48</td>
                                </tr>
                            </table>
                        </div>

                        <div id="imageBox" class="map-thumb" style="display: block;">
                            <img id="default" src="resources/img/thumb/seoul.png" alt="예측영역 이미지" onclick="javascript:imgPopup(this);">
                        </div>
                        <div id="resultImage" class="map-thumb" style="display: none;"></div>
                        <div style="margin-top: 10px;padding-bottom: 5px; border-bottom: 2px solid #e6e6e6;"></div>
                    </div>
                </div>
            </div>
            <!-- //content -->

            <%-- footer --%>
            <%@include file="common/footer.jsp"%>
        </div>
    </div>
    <!-- //wrap -->

    <!-- 지점표시 -->
    <!--<map id="capitalMap" name="capitalMap">
        <area shape="rect" coords="405,28,419,38" href="javascript:getJsonData('Capital', 504);" alt="504">
        <area shape="rect" coords="320,49,331,61" href="javascript:getJsonData('Capital', 598);" alt="598">
        <area shape="rect" coords="401,89,412,100" href="javascript:getJsonData('Capital', 599);" alt="599">
        <area shape="rect" coords="357,104,370,117" href="javascript:getJsonData('Capital', 532);" alt="532">
        <area shape="rect" coords="223,99,234,109" href="javascript:getJsonData('Capital', 506);" alt="506">
        <area shape="rect" coords="229,124,240,136" href="javascript:getJsonData('Capital', 589);" alt="589">
        <area shape="rect" coords="175,158,186,169" href="javascript:getJsonData('Capital', 427);" alt="427">
        <area shape="rect" coords="392,161,405,173" href="javascript:getJsonData('Capital', 541);" alt="541">
        <area shape="rect" coords="338,145,349,155" href="javascript:getJsonData('Capital', 406);" alt="406">
        <area shape="rect" coords="338,161,348,170" href="javascript:getJsonData('Capital', 424);" alt="424">
        <area shape="rect" coords="368,170,378,180" href="javascript:getJsonData('Capital', 407);" alt="407">
        <area shape="rect" coords="300,156,309,167" href="javascript:getJsonData('Capital', 416);" alt="416">
        <area shape="rect" coords="277,162,287,173" href="javascript:getJsonData('Capital', 540);" alt="540">
        <area shape="rect" coords="325,175,334,186" href="javascript:getJsonData('Capital', 414);" alt="414">
        <area shape="rect" coords="248,198,260,209" href="javascript:getJsonData('Capital', 404);" alt="404">
        <area shape="rect" coords="232,207,242,219" href="javascript:getJsonData('Capital', 110);" alt="110">
        <area shape="rect" coords="218,240,229,250" href="javascript:getJsonData('Capital', 429);" alt="429">
        <area shape="rect" coords="246,244,258,253" href="javascript:getJsonData('Capital', 423);" alt="423">
        <area shape="rect" coords="354,190,363,203" href="javascript:getJsonData('Capital', 408);" alt="408">
        <area shape="rect" coords="367,192,375,202" href="javascript:getJsonData('Capital', 409);" alt="409">
        <area shape="rect" coords="398,192,408,204" href="javascript:getJsonData('Capital', 569);" alt="569">
        <area shape="rect" coords="392,206,401,215" href="javascript:getJsonData('Capital', 402);" alt="402">
        <area shape="rect" coords="422,206,434,220" href="javascript:getJsonData('Capital', 428);" alt="428">
        <area shape="rect" coords="364,218,376,231" href="javascript:getJsonData('Capital', 413);" alt="413">
        <area shape="rect" coords="311,198,320,210" href="javascript:getJsonData('Capital', 108);" alt="108">
        <area shape="rect" coords="299,199,308,210" href="javascript:getJsonData('Capital', 412);" alt="412">
        <area shape="rect" coords="343,211,353,225" href="javascript:getJsonData('Capital', 421);" alt="421">
        <area shape="rect" coords="321,212,332,220" href="javascript:getJsonData('Capital', 419);" alt="419">
        <area shape="rect" coords="294,213,304,221" href="javascript:getJsonData('Capital', 411);" alt="411">
        <area shape="rect" coords="271,221,280,236" href="javascript:getJsonData('Capital', 405);" alt="405">
        <area shape="rect" coords="285,223,294,237" href="javascript:getJsonData('Capital', 510);" alt="510">
        <area shape="rect" coords="299,225,308,236" href="javascript:getJsonData('Capital', 418);" alt="418">
        <area shape="rect" coords="316,227,326,241" href="javascript:getJsonData('Capital', 415);" alt="415">
        <area shape="rect" coords="373,233,384,242" href="javascript:getJsonData('Capital', 403);" alt="403">
        <area shape="rect" coords="340,247,348,260" href="javascript:getJsonData('Capital', 401);" alt="401">
        <area shape="rect" coords="287,244,301,254" href="javascript:getJsonData('Capital', 410);" alt="410">
        <area shape="rect" coords="266,252,273,263" href="javascript:getJsonData('Capital', 895);" alt="895">
        <area shape="rect" coords="281,260,292,270" href="javascript:getJsonData('Capital', 417);" alt="417">
        <area shape="rect" coords="317,260,328,270" href="javascript:getJsonData('Capital', 425);" alt="425">
        <area shape="rect" coords="303,265,312,277" href="javascript:getJsonData('Capital', 509);" alt="509">
        <area shape="rect" coords="329,276,340,285" href="javascript:getJsonData('Capital', 590);" alt="590">
        <area shape="rect" coords="312,271,319,281" href="javascript:getJsonData('Capital', 116);" alt="116">
        <area shape="rect" coords="385,284,394,297" href="javascript:getJsonData('Capital', 572);" alt="572">
        <area shape="rect" coords="447,274,456,286" href="javascript:getJsonData('Capital', 546);" alt="546">
        <area shape="rect" coords="308,299,318,311" href="javascript:getJsonData('Capital', 894);" alt="894">
        <area shape="rect" coords="298,319,308,330" href="javascript:getJsonData('Capital', 896);" alt="896">
        <area shape="rect" coords="313,328,324,339" href="javascript:getJsonData('Capital', 897);" alt="897">
        <area shape="rect" coords="254,364,266,377" href="javascript:getJsonData('Capital', 545);" alt="545">
        <area shape="rect" coords="320,377,330,388" href="javascript:getJsonData('Capital', 119);" alt="119">
        <area shape="rect" coords="429,368,441,381" href="javascript:getJsonData('Capital', 549);" alt="549">
        <area shape="rect" coords="350,416,361,428" href="javascript:getJsonData('Capital', 550);" alt="550">
        <area shape="rect" coords="245,414,257,425" href="javascript:getJsonData('Capital', 571);" alt="571">
        <area shape="rect" coords="415,462,427,475" href="javascript:getJsonData('Capital', 575);" alt="575">
        <area shape="rect" coords="364,242,372,251" href="javascript:getJsonData('Capital', 400);" alt="400">
        <area shape="rect" coords="316,241,327,249" href="javascript:getJsonData('Capital', 889);" alt="889">
    </map>

    <map id="seoulMap" name="seoulMap">
        <area shape="rect" coords="302,109,312,120" href="javascript:getJsonData('Seoul', 406);" alt="406">
        <area shape="rect" coords="211,137,221,149" href="javascript:getJsonData('Seoul', 416);" alt="416">
        <area shape="rect" coords="298,144,310,155" href="javascript:getJsonData('Seoul', 424);" alt="424">
        <area shape="rect" coords="269,181,282,193" href="javascript:getJsonData('Seoul', 414);" alt="414">
        <area shape="rect" coords="368,165,380,178" href="javascript:getJsonData('Seoul', 407);" alt="407">
        <area shape="rect" coords="335,215,347,227" href="javascript:getJsonData('Seoul', 408);" alt="408">
        <area shape="rect" coords="362,214,375,225" href="javascript:getJsonData('Seoul', 409);" alt="409">
        <area shape="rect" coords="207,235,221,249" href="javascript:getJsonData('Seoul', 412);" alt="412">
        <area shape="rect" coords="235,234,246,245" href="javascript:getJsonData('Seoul', 108);" alt="108">
        <area shape="rect" coords="90,233,100,244" href="javascript:getJsonData('Seoul', 404);" alt="404">
        <area shape="rect" coords="52,251,66,265" href="javascript:getJsonData('Seoul', 110);" alt="110">
        <area shape="rect" coords="195,262,208,272" href="javascript:getJsonData('Seoul', 411);" alt="411">
        <area shape="rect" coords="141,289,155,302" href="javascript:getJsonData('Seoul', 405);" alt="405">
        <area shape="rect" coords="173,292,185,306" href="javascript:getJsonData('Seoul', 510);" alt="510">
        <area shape="rect" coords="206,295,220,308" href="javascript:getJsonData('Seoul', 418);" alt="418">
        <area shape="rect" coords="257,257,271,272" href="javascript:getJsonData('Seoul', 419);" alt="419">
        <area shape="rect" coords="313,263,324,277" href="javascript:getJsonData('Seoul', 421);" alt="421">
        <area shape="rect" coords="426,253,436,264" href="javascript:getJsonData('Seoul', 402);" alt="402">
        <area shape="rect" coords="362,280,374,295" href="javascript:getJsonData('Seoul', 413);" alt="413">
        <area shape="rect" coords="246,300,257,314" href="javascript:getJsonData('Seoul', 415);" alt="415">
        <area shape="rect" coords="184,335,198,349" href="javascript:getJsonData('Seoul', 410);" alt="410">
        <area shape="rect" coords="248,326,259,338" href="javascript:getJsonData('Seoul', 889);" alt="889">
        <area shape="rect" coords="87,338,99,348" href="javascript:getJsonData('Seoul', 423);" alt="423">
        <area shape="rect" coords="166,374,177,384" href="javascript:getJsonData('Seoul', 417);" alt="417">
        <area shape="rect" coords="219,389,232,401" href="javascript:getJsonData('Seoul', 509);" alt="509">
        <area shape="rect" coords="253,375,266,387" href="javascript:getJsonData('Seoul', 425);" alt="425">
        <area shape="rect" coords="301,345,311,361" href="javascript:getJsonData('Seoul', 401);" alt="401">
        <area shape="rect" coords="359,327,371,340" href="javascript:getJsonData('Seoul', 400);" alt="400">
        <area shape="rect" coords="375,310,388,323" href="javascript:getJsonData('Seoul', 403);" alt="403">
    </map>

    <map id="busanMap" name="busanMap">
        <area shape="rect" coords="540,274,548,284" href="javascript:getJsonData('Busan', 296);" alt="296">
        <area shape="rect" coords="644,445,652,453" href="javascript:getJsonData('Busan', 942);" alt="942">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 937);" alt="937">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 938);" alt="938">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 950);" alt="950">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 910);" alt="910">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 939);" alt="939">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 923);" alt="923">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 941);" alt="941">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 160);" alt="160">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 940);" alt="940">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Busan', 904);" alt="904">
    </map>

    <map id="daeguMap" name="daeguMap">
        <area shape="rect" coords="524,313,536,324" href="javascript:getJsonData('Daegu', 860);" alt="860">
        <area shape="rect" coords="409,349,417,358" href="javascript:getJsonData('Daegu', 846);" alt="846">
        <area shape="rect" coords="274,637,281,644" href="javascript:getJsonData('Daegu', 828);" alt="828">
        <area shape="rect" coords="487,276,495,286" href="javascript:getJsonData('Daegu', 845);" alt="845">
    </map>

    <map id="daejeonMap" name="daejeonMap">
        <area shape="rect" coords="540,274,548,284" href="javascript:getJsonData('Daejeon', 648);" alt="648">
        <area shape="rect" coords="644,445,652,453" href="javascript:getJsonData('Daejeon', 643);" alt="643">
        <area shape="rect" coords="479,514,490,524" href="javascript:getJsonData('Daejeon', 642);" alt="642">
    </map>

    <map id="gwangjuMap" name="gwangjuMap">
        <area shape="rect" coords="527,487,537,495" href="javascript:getJsonData('Gwangju', 788);" alt="788">
        <area shape="rect" coords="274,492,282,500" href="javascript:getJsonData('Gwangju', 708);" alt="708">
        <area shape="rect" coords="616,474,625,485" href="javascript:getJsonData('Gwangju', 722);" alt="722">
        <area shape="rect" coords="561,561,571,567" href="javascript:getJsonData('Gwangju', 689);" alt="689">
        <area shape="rect" coords="453,263,462,270" href="javascript:getJsonData('Gwangju', 783);" alt="783">
        <area shape="rect" coords="748,528,755,537" href="javascript:getJsonData('Gwangju', 316);" alt="316">
    </map>

    <map id="ulsanMap" name="ulsanMap">
        <area shape="rect" coords="758,512,766,522" href="javascript:getJsonData('Ulsan', 901);" alt="901">
        <area shape="rect" coords="320,510,330,520" href="javascript:getJsonData('Ulsan', 854);" alt="854">
        <area shape="rect" coords="653,742,664,750" href="javascript:getJsonData('Ulsan', 924);" alt="924">
        <area shape="rect" coords="328,290,339,300" href="javascript:getJsonData('Ulsan', 900);" alt="900">
        <area shape="rect" coords="651,615,660,623" href="javascript:getJsonData('Ulsan', 954);" alt="954">
        <area shape="rect" coords="660,195,671,208" href="javascript:getJsonData('Ulsan', 943);" alt="943">
        <area shape="rect" coords="686,483,694,492" href="javascript:getJsonData('Ulsan', 898);" alt="898">
        <area shape="rect" coords="759,247,767,256" href="javascript:getJsonData('Ulsan', 949);" alt="949">
    </map>

    <map id="incheonMap" name="incheonMap">
        <area shape="rect" coords="512,635,521,647" href="javascript:getJsonData('Incheon', 664);" alt="664">
        <area shape="rect" coords="386,686,396,698" href="javascript:getJsonData('Incheon', 662);" alt="662">
        <area shape="rect" coords="487,475,498,485" href="javascript:getJsonData('Incheon', 665);" alt="665">
        <area shape="rect" coords="437,400,450,410" href="javascript:getJsonData('Incheon', 508);" alt="508">
        <area shape="rect" coords="738,396,749,408" href="javascript:getJsonData('Incheon', 649);" alt="649">
        <area shape="rect" coords="693,315,704,327" href="javascript:getJsonData('Incheon', 511);" alt="511">
        <area shape="rect" coords="523,208,533,219" href="javascript:getJsonData('Incheon', 500);" alt="500">
        <area shape="rect" coords="384,86,398,97" href="javascript:getJsonData('Incheon', 502);" alt="502">
        <area shape="rect" coords="655,251,666,261" href="javascript:getJsonData('Incheon', 570);" alt="570">
        <area shape="rect" coords="669,469,681,481" href="javascript:getJsonData('Incheon', 512);" alt="512">
        <area shape="rect" coords="268,630,277,642" href="javascript:getJsonData('Incheon', 513);" alt="513">
        <area shape="rect" coords="80,209,87,220" href="javascript:getJsonData('Incheon', 663);" alt="663">
        <area shape="rect" coords="633,516,646,528" href="javascript:getJsonData('Incheon', 631);" alt="631">
        <area shape="rect" coords="583,369,593,379" href="javascript:getJsonData('Incheon', 543);" alt="543">
        <area shape="rect" coords="395,606,406,619" href="javascript:getJsonData('Incheon', 654);" alt="654">
        <area shape="rect" coords="78,97,87,106" href="javascript:getJsonData('Incheon', 501);" alt="501">
        <area shape="rect" coords="310,200,319,212" href="javascript:getJsonData('Incheon', 656);" alt="656">
        <area shape="rect" coords="418,333,429,347" href="javascript:getJsonData('Incheon', 577);" alt="577">
    </map>

    <map id="jejuMap" name="jejuMap">
        <area shape="rect" coords="414,530,424,538" href="javascript:getJsonData('Jeju', 884);" alt="884">
        <area shape="rect" coords="749,287,759,301" href="javascript:getJsonData('Jeju', 725);" alt="725">
        <area shape="rect" coords="670,355,682,369" href="javascript:getJsonData('Jeju', 892);" alt="892">
        <area shape="rect" coords="516,307,525,321" href="javascript:getJsonData('Jeju', 330);" alt="330">
        <area shape="rect" coords="562,326,571,335" href="javascript:getJsonData('Jeju', 751);" alt="751">
        <area shape="rect" coords="491,414,504,424" href="javascript:getJsonData('Jeju', 782);" alt="782">
        <area shape="rect" coords="390,527,400,538" href="javascript:getJsonData('Jeju', 980);" alt="980">
        <area shape="rect" coords="267,339,278,347" href="javascript:getJsonData('Jeju', 893);" alt="893">
        <area shape="rect" coords="416,435,423,445" href="javascript:getJsonData('Jeju', 871);" alt="871">
        <area shape="rect" coords="398,420,409,432" href="javascript:getJsonData('Jeju', 868);" alt="868">
        <area shape="rect" coords="292,435,303,446" href="javascript:getJsonData('Jeju', 883);" alt="883">
        <area shape="rect" coords="319,390,328,399" href="javascript:getJsonData('Jeju', 727);" alt="727">
        <area shape="rect" coords="476,370,485,383" href="javascript:getJsonData('Jeju', 866);" alt="866">
        <area shape="rect" coords="396,404,408,418" href="javascript:getJsonData('Jeju', 753);" alt="753">
        <area shape="rect" coords="442,426,454,439" href="javascript:getJsonData('Jeju', 870);" alt="870">
        <area shape="rect" coords="555,513,566,526" href="javascript:getJsonData('Jeju', 780);" alt="780">
        <area shape="rect" coords="536,463,546,474" href="javascript:getJsonData('Jeju', 885);" alt="885">
        <area shape="rect" coords="425,444,435,456" href="javascript:getJsonData('Jeju', 965);" alt="965">
        <area shape="rect" coords="451,356,462,368" href="javascript:getJsonData('Jeju', 329);" alt="329">
        <area shape="rect" coords="418,347,428,360" href="javascript:getJsonData('Jeju', 865);" alt="865">
        <area shape="rect" coords="423,420,433,434" href="javascript:getJsonData('Jeju', 867);" alt="867">
        <area shape="rect" coords="327,538,336,548" href="javascript:getJsonData('Jeju', 328);" alt="328">
        <area shape="rect" coords="215,404,225,417" href="javascript:getJsonData('Jeju', 779);" alt="779">
        <area shape="rect" coords="580,413,588,425" href="javascript:getJsonData('Jeju', 890);" alt="890">
        <area shape="rect" coords="642,442,653,454" href="javascript:getJsonData('Jeju', 792);" alt="792">
        <area shape="rect" coords="397,445,406,458" href="javascript:getJsonData('Jeju', 869);" alt="869">
        <area shape="rect" coords="347,330,358,341" href="javascript:getJsonData('Jeju', 863);" alt="863">
        <area shape="rect" coords="219,652,230,663" href="javascript:getJsonData('Jeju', 726);" alt="726">
        <area shape="rect" coords="222,607,232,618" href="javascript:getJsonData('Jeju', 855);" alt="855">
        <area shape="rect" coords="188,541,197,550" href="javascript:getJsonData('Jeju', 793);" alt="793">
        <area shape="rect" coords="248,485,262,497" href="javascript:getJsonData('Jeju', 752);" alt="752">
        <area shape="rect" coords="614,252,624,262" href="javascript:getJsonData('Jeju', 861);" alt="861">
        <area shape="rect" coords="689,291,699,301" href="javascript:getJsonData('Jeju', 781);" alt="781">
        <area shape="rect" coords="615,336,627,348" href="javascript:getJsonData('Jeju', 862);" alt="862">
    </map>

    -->

    <div id="popupLabel" style="padding:5px; position: fixed; color:#fff; background-color:#2f7dcc;"></div>

    <!-- Log Modal -->
    <div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="logModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="section">
                    <div class="tit-wrap">
                        <h2>예측자료 생산 진행상황</h2>
                        <button type="button" class="modal-close" data-dismiss="modal"><img src="resources/img/ico/btn-gnb-close.svg" alt=""></button>
                        <button type="button" class="modal-close" data-dismiss="modal"><img src="resources/images/20211011/123456789/Busan_downward_SW_flux_surface_dnsc_SWDN_004.nc.1631675708.png" alt=""></button>
                    </div>
                    <div class="modal-body-scroll">
                        <ul class="log-list">
                            <li id="load">
                                <strong>요청자료 생성중...</strong>
                                <div class="img img-loading"><span class="blind">진행중</span></div>
                            </li>
                            <li id="vismaster">
                                <strong>예측자료 생성중...</strong>
                                <div class="img img-loading"><span class="blind">진행중</span></div>
                            </li>
                            <li id="img1">
                                <strong>예측자료 이미지 생산중...</strong>
                                <div class="img img-loading"><span class="blind">진행중 (0/0)</span></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 시계열 팝업 -->
    <div class="loc_pop_wrap_nc" id="loc_pop_wrap_nc" style="display: none;">
        <h5 id="stitle" class="blind">시계열 팝업</h5>
        <div class="loc_pop_nc" id="loc_pop_nc">
            <div class="loc_pop_top_nc" id="graphdiv">
                <span id="ncgraph_title"> AWS 명칭</span>
                <a href="#;" class="pop_close_nc" id="pop_close_nc" onclick="close_ncGraph('loc_pop_wrap_nc');">닫음</a>
            </div>

            <div class="loc_pop_inner_nc">
                <span id="ncgraph_title2" style="float:right; display:inline-block;font-size:13px; color:#666;"></span>
                <div class="graph_nc" id="ncgraph" style="width:100%; height:300px;" tabindex="0"></div>
                <div class="tbl_wrap" style="display:none;" id="ncdiv">
                    <table class="table03" id="nctable" tabindex="0">
                        <thead></thead>
                        <tbody><tr><th scope="col"></th></tr></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%-- script --%>
    <script src="resources/js/dnsc.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            predDateInfo();
            setInterval(function () {//30초30000
                if (_flag) { //_flag==true
                    getFileLogInfo();
                }
            },3000);
        });
    </script>

</body>
</html>
