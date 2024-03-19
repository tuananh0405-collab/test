<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top" id="nav">
    <div class="container">
        <a class="navbar-brand darkText title" href="index.jsp">
            <!--<p class="logo">Doggyoku</p>-->
            <img src=images/logo.jpg width="70px" height="70px" alt="alt" class="logo rounded-circle"/>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto align-items-center w-30">
                <li class="nav-item ">
                    <a class="nav-link nav-choice" href="index.jsp">Home</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link nav-choice" href="aboutus.jsp">About us</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link nav-choice" href="product-pagination">Products</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link nav-choice" href="blog">Blogs</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link nav-choice" href="contactus.jsp">Contact us</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto align-items-center"> 
                <li class="nav-item">

                    <input type="checkbox" id="toggle">
                    <label id="switch" for="toggle">
                        <div id="circle"></div>
                        <div id="text"><i class="fa-solid fa-sun fa-sm"></i> </div>
                        <div id="text2"><i class="fa-solid fa-moon fa-sm"></i> </div>
                    </label>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp"><i class="ri fa-solid fa-cart-shopping fa-lg"></i><span class="count badge badge-danger">${(cart_list.size()>0)?cart_list.size():0}</span></a>
                </li>
                <%
                    if (auth!=null) {
                %>
                <li>
                    <div class="profile">
                        <div class="img-box">
                            <i class="fa-solid fa-user fa-lg"></i>
                        </div>
                    </div>
                    <div class="menu">
                        <ul>
                            <li><a href="profile.jsp"><i class="fa-solid fa-user"></i>&nbsp;Profile</a></li>
                            <li><a href="orders.jsp"><i class="fa-solid fa-list"></i>&nbsp;Order</a></li>
                            <li><a href="logout"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;Sign Out</a></li>
                        </ul>
                    </div>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item">
                    <a class="nav-link log " href="login.jsp">Login</a>
                    <!--                    <div class="navigation">
                    
                                            <a class="button" href="">
                                                <img src="https://pbs.twimg.com/profile_images/378800000639740507/fc0aaad744734cd1dbc8aeb3d51f8729_400x400.jpeg">
                    
                                                <div class="logout">LOGOUT</div>
                    
                                            </a>
                    
                                        </div>-->
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
    <%
    Integer mode = (Integer) request.getSession().getAttribute("mode");
    if(mode == null) mode = 1;
    String currentUrl = request.getRequestURL().toString();
    %>
    <script>

        // Select the target div
        var targetDiv = document.getElementById('nav');

// Add an event listener for the scroll event on the window
        window.addEventListener('scroll', function () {
            // Check if the user has scrolled down at least 100 pixels
            if (window.scrollY > 100) {
                // If scrolled, add the 'scrolled' class to the target div
                targetDiv.classList.add('scrolled');
            } else {
                // If not scrolled, remove the 'scrolled' class from the target div
                targetDiv.classList.remove('scrolled');
            }
        });
        //        test
        const toggle = document.getElementById('toggle');
        const body = document.body;
        const navbar = document.querySelector('.navbar');
        var mode = <%= mode %>

        if (mode === 0) {
            body.classList.remove('light-mode');
            body.classList.add('dark-mode');
            navbar.classList.remove('light-mode');
            navbar.classList.add('dark-mode');
            toggle.checked = true;
        } else {
            body.classList.remove('dark-mode');
            body.classList.add('light-mode');
            navbar.classList.remove('dark-mode');
            navbar.classList.add('light-mode');
            toggle.checked = false;
        }

        toggle.addEventListener('change', function () {
            if (this.checked && mode === 1) {
                body.classList.remove('light-mode');
                body.classList.add('dark-mode');
                navbar.classList.remove('light-mode');
                navbar.classList.add('dark-mode');
                mode = 0;
            } else {
                body.classList.remove('dark-mode');
                body.classList.add('light-mode');
                navbar.classList.remove('dark-mode');
                navbar.classList.add('light-mode');
                mode = 1;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "set-mode", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("mode=" + mode + "&currentUrl=" + window.location.href);
        });

        let profile = document.querySelector('.profile');
        let menu = document.querySelector('.menu');

        profile.onclick = function () {
            menu.classList.toggle('active');
        };
    </script>
    <form id="mode-form" action="set-mode" method="post" style="display: none;">
        <input type="hidden" name="mode" value="<%= mode %>">
        <input type="hidden" name="currentUrl" value="<%= currentUrl %>">
    </form>
    <style type="text/css">
        .dark-mode table{
            background: black;
            color: white;
        }
        .dark-mode section .profilePage{
            background: black;
        }
        .scrolled{
            opacity: 0.8;
            transition: ease-in 0.5s;
        }
        
            .title {
                font-family: "Cairo";
                text-align: center;
                color: #FFF;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                letter-spacing: 1px;
                line-height:2
            }
            .logo{
                background-image: url(https://media.giphy.com/media/26BROrSHlmyzzHf3i/giphy.gif);
                background-size: cover;
                color: transparent;
                -moz-background-clip: text;
                -webkit-background-clip: text;
                text-transform: uppercase;
                margin: 10px 0;
                font-weight: 600;
            }
            .nav-choice{
                font-family: Satisfy, cursive;
                /*font-size: 5em;*/
                /*margin: 1em 0;*/
                color: SandyBrown;
                text-shadow: 0.02em 0.02em 0 Brown, 0 0 0.5em violet;
            }
            /* profile menu */

            .profile {
                position: relative;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 12px;
                cursor: pointer;
                text-align: end;
            }




            .profile .img-box {
                width: 28px;
                height: 28px;
                border-radius: 50%;
            }

            /* menu (the right one) */

            .menu {
                position: absolute;
                top: calc(100% + 24px);
                right: -18px;
                width: 200px;
                min-height: 100px;
                background: #fff;
                box-shadow: 0 10px 20px rgba(0, 0, 0, .2);
                opacity: 0;
                transform: translateY(-10px);
                visibility: hidden;
                transition: 300ms;
            }

            .menu::before {
                content: '';
                position: absolute;
                top: -10px;
                right: 14px;
                width: 20px;
                height: 20px;
                background: #fff;
                transform: rotate(45deg);
                z-index: -1;
            }

            .menu.active {
                opacity: 1;
                transform: translateY(0);
                visibility: visible;
            }

            /* menu links */

            .menu ul {
                position: relative;
                display: flex;
                flex-direction: column;
                z-index: 10;
                background: #fff;
            }

            .menu ul li {
                list-style: none;
                width: 100%;
            }

            .menu ul li:hover {
                background: #eee;
            }

            .menu ul li a {
                text-decoration: none;
                color: #000;
                display: flex;
                align-items: center;
                padding: 15px 20px;
                gap: 6px;
            }

            .menu ul li a i {
                font-size: 1.2em;
            }
            /*test*/
            .log {
                cursor: pointer;
                text-align: center;
                border: 0;
                border-radius: 4px;
                font-weight: 600;
                margin: 0 10px;
                width: 100px;
                padding: 10px 0;
                box-shadow: 0 0 20px rgba(104, 85, 224, 0.2);
                transition: 0.4s;
                /*color: rgb(104, 85, 224);*/
                background-color: rgba(255, 255, 255, 1);
                border: 1px solid rgba(104, 85, 224, 1);
            }
            .log:hover {
                /*            color: white;*/
                /*width:;*/
                box-shadow: 0 0 20px rgba(104, 85, 224, 0.6);
                /*background-color: rgba(104, 85, 224, 1);*/
            }

            .dark-mode .log{
                background: black;
                color: white;
            }
            .navbar-collapse {
                justify-content: right; /* Centers the menu items */
                float: right;
            }

            .nav-history a{
                color: black;
            }
            .dark-mode .nav-history nav{
                background: #222;
            }
            .dark-mode .nav-history nav a{
                color: white;
            }
            .dark-mode .nav-history nav ol{
                background: #333;
                color: white;
            }

            @media (max-width: 767.98px) {
                .navbar-nav.mx-auto {
                    text-align: left !important; /* Aligns the menu items to the left on small screens */
                }

                .navbar-nav.ml-auto {
                    margin-left: auto !important; /* Aligns the toggle button and other items to the right on small screens */
                }
            }
            /*        @import url(https://fonts.googleapis.com/css?family=Oswald:400);
            
                    .navigation {
                        width: 100%;
                        background-color: black;
                    }*/

            /*        img {
                        width: 25px;
                        border-radius: 50px;
                        float: left;
                    }
            
                    .logout {
                        font-size: .8em;
                        font-family: 'Oswald', sans-serif;
                        position: relative;
                        right: -18px;
                        bottom: -4px;
                        overflow: hidden;
                        letter-spacing: 3px;
                        opacity: 0;
                        transition: opacity .45s;
                        -webkit-transition: opacity .35s;
            
                    }
            
                    .button {
                        text-decoration: none;
                        float: right;
                        padding: 12px;
                        margin: 15px;
                        color: white;
                        width: 25px;
                        background-color: black;
                        transition: width .35s;
                        -webkit-transition: width .35s;
                        overflow: hidden
                    }
            
                    a:hover {
                        width: 100px;
                    }
            
                    a:hover .logout{
                        opacity: .9;
                    }
            
                    a {
                        text-decoration: none;
                    }
            */

            /*/*/
            .nav-link{
                font-weight: 600;
                margin-left: 10px;
            }
            .navbar li {
                position: relative;
            }

            .navbar li a {
                /*color: #333;*/
                text-decoration: none;
            }

            .navbar li .nav-choice::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: -5px;
                height: 2px;
                width: 0;
                background-color: #71e215;
                transition: width 0.3s;
            }

            .navbar li a:hover::after,
                .navbar li a.active::after{
                width: 100%;
            }

            .navbar li a.active::after {
                width: 100%;
            }

            i {
                font-size: 42px;
            }

            .count {
                width: 15px;
                height: 15px;
                border-radius: 50%;
                background-color: red;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                position: absolute;
                right: 0;
                top: 0;
                z-index: 99;
            }
            input[type="checkbox"] {
                display: none;
            }

            #switch {
                margin: 0 auto;
                margin-top: 6%;
                position: relative;
                display: block;
                width: 60px;
                height: 30px;
                background-color: rgb(241, 161, 12);
                border-radius: 50px;
                cursor: pointer;
            }

            #circle {
                width: 20px;
                height: 20px;
                background-color: white;
                background-size: 50px;
                position: relative;
                top: 5px;
                left: 5px;
                border: 1px solid white;
                border-radius: 20px;
                transition: 0.4s ease left, 0.4s ease background-position;
                z-index: 2;
            }

            #text, #text2 {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                color: #fff;
                font-size: 15px;
                font-weight: 300;
                margin-left: 40px;
                z-index: 1;
                display: none;
            }

            #text2 {
                margin-left: 10px;
                text-align: right;
            }

            #toggle:checked + #switch #circle {
                left: 37px;
                background-position: -50px 0;
            }

            #toggle:checked + #switch {
                background: #212121;
            }

            #toggle:checked + #switch #text2 {
                display: block;
            }

            #toggle:not(:checked) + #switch #text {
                display: block;
            }

            body.light-mode {
                background-color: #fff;
                color: #333;
            }

            body.dark-mode {
                background-color: #222;
                color: #f1f1f1;
            }

            .navbar.light-mode {
                background-color: #f8f9fa;
            }

            .navbar.dark-mode {
                background-color: #343a40;
            }

            .navbar.dark-mode .nav-link {
                color: #f1f1f1;
            }
            .navbar.dark-mode .nav-link:hover{
                color: gainsboro;
            }
            .navbar.dark-mode .nav-link::after {
                background-color: #f1f1f1;
            }


            .dark-mode .card {
                background-color: #343a40;
                color: #f1f1f1;
            }

            .dark-mode .card-title {
                color: #f1f1f1;
            }

            .dark-mode .card-text {
                color: #ccc;
            }

            .dark-mode .text-muted {
                color: #999 !important;
            }

            .dark-mode .page-link {
                background-color: #343a40;
                color: #f1f1f1;
            }

            .dark-mode .page-item.active .page-link {
                background-color: #007bff;
                color: #fff;
            }



            .dark-mode .aboutContainer {
                background-color: #222;
                color: #f1f1f1;
            }



            .dark-mode .fa {
                color: #ffc107;
            }

            .dark-mode .media-body h5 {
                color: #20c997;
            }



            .dark-mode .bg-light {
                background-color: #343a40 !important;
                color: #f1f1f1;
            }

            .dark-mode .card-header {
                background-color: #222;
            }

            .dark-mode label {
                color: #f1f1f1;
            }

            .dark-mode select {
                background-color: #495057;
                color: #f1f1f1;
            }

            .dark-mode option {
                background-color: #343a40;
                color: #f1f1f1;
            }

            .dark-mode .fa-grid-2,
            .dark-mode .fa-grid {
                color: #f1f1f1;
            }

            .dark-mode .darkText{
                color: white;
            }
            .dark-mode .darkText:hover{
                color: gainsboro;
            }
            .dark-mode .categoryDisplay{
                color: white;
            }
            .subhead{
                padding-top: 10px;
            }
            .section-title h2:before,
                .section-title h2:after {
                content: "";
                width: 50px;
                height: 2px;
                background: black;
                display: inline-block;
            }

            .section-title h2:before {
                margin: 0 15px 10px 0;
            }

            .section-title h2:after {
                margin: 0 0 10px 15px;
            }
            .dark-mode .section-title h2:before, .dark-mode
                .section-title h2:after {

                background: white;
            }
        </style>
    </nav>