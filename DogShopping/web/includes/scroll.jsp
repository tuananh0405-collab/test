<style>
    #scrollToTopBtn {
        font-size: 30px;
        position: fixed;
        right:5%;
        bottom:20px;
        cursor: pointer;
        display: none;
        border: none;
        background: none;
    }

    #scrollToTopBtn:hover {
        transform: scale(1.2);
    }
</style>
<div id="scrollToTopBtn" title="Go to top" onclick="scrollUp()"><i class="fa fa-angle-double-up"></i></div>
<script type="text/javascript">
    function doImage(id) {
        window.location = "product-detail?id=" + id;
    }

    let backToTop = false;

    function scrollListener() {
        if (window.scrollY > 150) {
            scrollToTopBtn.style.display = "block";
        } else {
            scrollToTopBtn.style.display = "none";
        }
    }

    function scrollUp() {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    }

    window.addEventListener("scroll", scrollListener);

</script>