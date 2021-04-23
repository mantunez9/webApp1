<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" scope="session" type="isdcm.webapp.model.User"/>
<%--
  Created by IntelliJ IDEA.
  User: mantu
  Date: 25/02/2021
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="css/style.css">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta http-equiv="Content-Type"
          content="text/html; charset=windows-1256">
    <title>Video</title>
    <link rel="stylesheet" type="text/css" href="css/dropdown.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <link href="https://unpkg.com/video.js/dist/video-js.min.css" rel="stylesheet">
    <script src="https://unpkg.com/video.js/dist/video.min.js"></script>
    <script src="video/Youtube.min.js"></script>
</head>
<body>
<div class="dropdown">
    <button class="dropbtn">${user.nickName}</button>
    <div class="dropdown-content">
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>
<div class="video-page">
    <div class="video-form">
        <h1>Video Registration</h1>
        <form action="video" method="post">
            <p>
                <label for="titulo">Title: </label>
                <input id="titulo" name="titulo" required="required" type="text" placeholder="title"/>
            </p>
            <p>
                <label for="autor">Author:</label>
                <input id="autor" name="autor" required="required" type="text"
                       placeholder="author"/>
            </p>
            <p>
                <label for="date">Creation date:</label>
                <input id="date" name="date" required="required" type="date" placeholder="DD/MM/YYYY"/>
            </p>
            <p>
                <label for="duracion">Duration time:</label>
                <input id="duracion" name="duracion" required="required" type="text"
                       pattern="^(?:(?:([01]?\d|2[0-3]):)([0-5]?\d):)([0-5]?\d)$"
                       placeholder="mm:ss:nn"/>
            </p>
            <p>
                <label for="reproducciones">Number of reproductions:</label>
                <input id="reproducciones" name="reproducciones" required="required" type="number" min="0"
                       placeholder="number of reproductions"/>
            </p>
            <p>
                <label for="descripcion">Description:</label>
                <input id="descripcion" name="descripcion" required="required" type="text" placeholder="description"/>
            </p>
            <p>
                <label for="formato">Format: </label>
                <input id="formato" name="formato" required="required" type="text" placeholder="mp4"/>
            </p>
            <p>
                <label for="url">URL: </label>
                <input id="url" name="url" type="text" placeholder="www.youtube.com/example"/>
            </p>
            <button type="submit">create</button>
        </form>
    </div>
</div>
<div style="padding: 8% 0 0;">
    <div style="background: #FFFFFF; padding: 15px; text-align: center;">
        <div class="video-form" style="box-shadow: none; max-width: 50%;margin: unset; padding: unset;">
            <h1>Search</h1>
            <form action="video" method="get">
                <p style="display:flex; flex-direction: row;">
                    <label style="width: 15%">By Title: </label>
                    <input id="byTitle" name="byTitle" type="text" placeholder="title" onchange="blockOtherInput('t')"/>
                </p>
                <p style="display:flex; flex-direction: row;">
                    <label style="width: 15%">By Author: </label>
                    <input id="byAuthor" name="byAuthor" type="text" placeholder="author" onchange="blockOtherInput('a')"/>
                </p>
                <p style="display:flex; flex-direction: row;">
                    <label style="width: 15%">By Creation Date: </label>
                    <input id="byCreationDate" name="byCreationDate" type="text" placeholder="YYYY-MM-DD, put XX if month/day is not required" onchange="blockOtherInput('cd')"
                           pattern="(?:(?:([0-9]{4})-)(0[1-9]|1[012]|XX)-)(?:XX)|(?:(?!XX)(?:([0-9]{4})-)(?:0[1-9]|1[0-2])-(?:(0[1-9]|1[0-9]|2[0-9]|3[01]|XX)))"/>
                </p>
                <button type="submit" style="width: 50%;">find</button>
            </form>
            <script>
                function blockOtherInput(id) {
                    var tInput = document.getElementById("byTitle");
                    var aInput = document.getElementById("byAuthor");
                    var cdInput = document.getElementById("byCreationDate");
                    if (id == "t" && tInput.value != "") {
                        aInput.setAttribute("readonly", true);
                        cdInput.setAttribute("readonly", true);
                    } else if (id == "a" && aInput.value != "") {
                        tInput.setAttribute("readonly", true);
                        cdInput.setAttribute("readonly", true);
                    } else if (id == "cd" && cdInput.value != "") {
                        tInput.setAttribute("readonly", true);
                        aInput.setAttribute("readonly", true);
                    } else {
                        tInput.removeAttribute("readonly");
                        aInput.removeAttribute("readonly");
                        cdInput.removeAttribute("readonly");
                    }
                }
            </script>
        </div>
        <table id="videoTable" class="flat-table">
            <h1>List of videos</h1>
            <thead>
            <tr>
                <th onclick="sortTable(0)">Title</th>
                <th onclick="sortTable(1)">Author</th>
                <th onclick="sortTable(2)">Creation date</th>
                <th onclick="sortTable(3)">Time</th>
                <th onclick="sortTable(4)">Number of reproductions</th>
                <th onclick="sortTable(5)">Description</th>
                <th onclick="sortTable(6)">Format</th>
                <th onclick="sortTable(7)">Url</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${videos}" var="video">
                <tr onclick="streamVideo(this)">
                    <td>${video.tittle}</td>
                    <td>${video.author}</td>
                    <td>${video.creationDate}</td>
                    <td>${video.duration}</td>
                    <td>${video.reproduction}</td>
                    <td>${video.description}</td>
                    <td>${video.format}</td>
                    <td>${video.url}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <script>
            function sortTable(n) {
                var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                table = document.getElementById("videoTable");
                switching = true;
                dir = "asc";
                while (switching) {
                    switching = false;
                    rows = table.rows;
                    for (i = 1; i < (rows.length - 1); i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];
                        if (dir === "asc") {
                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        } else if (dir === "desc") {
                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                shouldSwitch = true;
                                break;
                            }
                        }
                    }
                    if (shouldSwitch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                        switchcount++;
                    } else {
                        if (switchcount === 0 && dir === "asc") {
                            dir = "desc";
                            switching = true;
                        }
                    }
                }
            }
        </script>
        <br/>
        <div id="play_video"></div>
        <script>
            function streamVideo(x) {
                var div = document.getElementById("play_video");
                div.innerText = "";
                var table = document.getElementById("videoTable");
                var rows = table.rows;
                var url = rows[x.rowIndex].cells[7].innerHTML;
                if (url) {
                    var video = document.createElement('video');
                    video.setAttribute('id', 'my-player1');
                    video.setAttribute('class', 'video-js vjs-default-skin');
                    video.controls = true;
                    video.setAttribute('preload','auto');
                    video.setAttribute('data-setup', '{"techOrder": ["youtube"]}');

                    var p = document.createElement('p');
                    p.setAttribute('class', 'vjs-no-js');
                    p.innerText = "To view this video please enable JavaScript, and consider upgrading to a web browser that <a href='https://videojs.com/html5-video-support/' target='_blank'> supports HTML5 video</a>"

                    var source = document.createElement('source');
                    source.setAttribute("id", "source")
                    source.setAttribute("src", url);
                    source.setAttribute("type", "video/" + rows[x.rowIndex].cells[6].innerHTML);

                    video.appendChild(source);
                    video.appendChild(p);
                    div.appendChild(video);
                }
            }
        </script>

        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-xl">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Video Playback</h4>
                    </div>
                    <div class="modal-body" >
                            <video id="vid1"
                                    class="video-js vjs-default-skin"
                                    controls
                                    autoplay
                                    width="640" height="264"
                                    data-setup='{ "techOrder": ["youtube"], "sources": [{ "type": "video/youtube", "src": "https://www.youtube.com/watch?v=1KaCVJip7Zw"}], "youtube": { "iv_load_policy": 1 } }'
                            >
                            </video>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script>
            jQuery(document).ready(function($) {
                $('#videoTable').DataTable({
                    searching: false,
                    responsive: true,
                    "autoWidth": false,
                });
                var table = $('#videoTable').DataTable();
                $('#videoTable tbody').on('click', 'tr', function () {
                    $(".modal-body div span").text("");
                    $('#videoDiv').text("");
                    var url = table.row(this).data()[7];
                    console.log(url);
                    console.log(table.row(this).data()[6]);
                    if (url) {
                        // var video = $('<video />', {
                        //     id: 'myVideo',
                        //     src: url,
                        //     type: 'video/youtube',
                        //     controls: true
                        // });
                        // video.appendTo($('#videoDiv'));
                        $("#myModal").modal("show");
                    }
                });
            } );
        </script>
    </div>
</div>
</body>
</html>
