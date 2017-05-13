<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){

    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('.tree li.parent_li > span').on('click', function (e) {

        var children = $(this).parent('li.parent_li').find(' > ul > li');

        if (children.is(":visible")) {

            children.hide('fast');

            $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');

        } else {

            children.show('fast');

            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');

        }

        e.stopPropagation();

    });

});

</script>




</head>
<body>
<div class="tree well">

<ul>

	<li>

		<span><i class="icon-folder-open"></i> Parent</span> <a href="">Goes somewhere</a>

		<ul>

			<li>

				<span><i class="icon-minus-sign"></i> Child</span> <a href="">Goes somewhere</a>

				<ul>

					<li>

						<span><i class="icon-leaf"></i> Grand Child</span> <a href="">Goes somewhere</a>

					</li>

				</ul>

			</li>

			<li>

				<span><i class="icon-minus-sign"></i> Child</span> <a href="">Goes somewhere</a>

				<ul>

					<li>

						<span><i class="icon-leaf"></i> Grand Child</span> <a href="">Goes somewhere</a>

					</li>

					<li>

						<span><i class="icon-minus-sign"></i> Grand Child</span> <a href="">Goes somewhere</a>

						<ul>

							<li>

								<span><i class="icon-minus-sign"></i> Great Grand Child</span> <a href="">Goes somewhere</a>

								<ul>

									<li>

										<span><i class="icon-leaf"></i> Great great Grand Child</span> <a href="">Goes somewhere</a>

									</li>

									<li>

										<span><i class="icon-leaf"></i> Great great Grand Child</span> <a href="">Goes somewhere</a>

									</li>

								 </ul>

							</li>

							<li>

								<span><i class="icon-leaf"></i> Great Grand Child</span> <a href="">Goes somewhere</a>

							</li>

							<li>

								<span><i class="icon-leaf"></i> Great Grand Child</span> <a href="">Goes somewhere</a>

							</li>

						</ul>

					</li>

					<li>

						<span><i class="icon-leaf"></i> Grand Child</span> <a href="">Goes somewhere</a>

					</li>

				</ul>

			</li>

		</ul>

	</li>

	<li>

		<span><i class="icon-folder-open"></i> Parent2</span> <a href="">Goes somewhere</a>

		<ul>

			<li>

				<span><i class="icon-leaf"></i> Child</span> <a href="">Goes somewhere</a>

			</li>

		</ul>

	</li>

</ul>

</div>


</body>
</html>