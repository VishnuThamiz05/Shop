
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
table>tbody>tr>td, .table>tfoot>tr>td {
	vertical-align: middle;
}

@media screen and (max-width: 600px) {
	table#cart tbody td .form-control {
		width: 20%;
		display: inline !important;
	}
	.actions .btn {
		width: 36%;
		margin: 1.5em 0;
	}
	.actions .btn-info {
		float: left;
	}
	.actions .btn-danger {
		float: right;
	}
	table#cart thead {
		display: none;
	}
	table#cart tbody td {
		display: block;
		padding: .6rem;
		min-width: 320px;
	}
	table#cart tbody tr td:first-child {
		background: #333;
		color: #fff;
	}
	table#cart tbody td:before {
		content: attr(data-th);
		font-weight: bold;
		display: inline-block;
		width: 8rem;
	}
	h3.hidden {
		visibility: hidden
	}
	table#cart tfoot td {
		display: block;
	}
	table#cart tfoot td .btn {
		display: block;
	}
}
</style>
<script>
	$(document).ready(function() {
		update_amounts();
		// Fix: Invalid selector for the select fields
		$('select[name=qty]').change(update_amounts);
	});
	function update_amounts() {
		var total = 0.0;
		$('#cart > tbody  > tr')
			.each(
				function() {
					var qty = $(this).find('option:selected').val();
					// Fix: price is in text, not in a form field
					// and it must be cleaned from the pound sign
					var uname = $(this).find('option:selected').val();
					var pname = $(this).find('#pn').text();
					var cid = $(this).find('#iid').text();
					var price = $(this).find('.price').text().replace(
						/[^\d.]/, '');
					var amount = (qty * price);
					total += amount;
					$(this).find('.subtotal').text('Rs.' + amount);
					if (uname >= 1) {

						$.ajax({
							type : 'GET',
							url : '${pageContext.request.contextPath}/addquty/'
								+ uname
								+ '/'
								+ pname
								+ '/'
								+ cid,

							success : function(msg) {
								$(".status").html(msg);

							}
						});
					} else {
						$(".status")
							.html(
								"<font color=red>Quantity should be <b></b> greater than Three.</font>");

					}
				});
		//	$("a").click(function() {
		//	$("#w3s").attr("href", "check_orders/" + total); //sum--> total
		//	});
		//just update the total to sum  
		$('.total1').text(total); //sum --> total

	}
</script>


<title>My Cart</title>
</head>


<body>

	<c:if test="${n==0 }">
		<div>
			<p align="center">
				Your cart is empty Go back and Purchase <a href="productdisplay">Products</a>
			</p>
		</div>
	</c:if>


	<c:if test="${n!=0 }">
		<div class="container">
			<table id="cart" class="table table-hover table-condensed">
				<thead>
					<tr>
						<th style="width: 35%">Product</th>
						<th style="width: 15%">Product Image</th>
						<!--  	<th style="width:50%">Image</th>-->
						<th style="width: 10%">Price</th>
						<th style="width: 8%">Quantity</th>
						<th style="width: 22%" class="text-center">Subtotal</th>
						<th style="width: 10%"></th>
					</tr>

				</thead>
				<tbody>

					<c:forEach items="${cartitems}" var="cartitem">
						<tr>
							<td data-th="Product">

								<div class="row">

									<div class="col-sm-10">
										<h3 class="hidden" id="iid">${cartitem.citemid}</h3>
										<h4 class="nomargin" id="pn">${cartitem.prodname}</h4>


									</div>
								</div>
							</td>
							<td>
								<h4>
									<img src="<c:url value="/images/${cartitem.proid }.jpg"/>"
										style="height: 60px; width: 135px"
										alt="Error on loading images" />
								</h4>
							</td>
							<td data-th="Price"><span id="price" class="price">${cartitem.price}</span></td>

							<!-- 	<td data-th="Quantity"><input type="number" name="qty"
							id="quty">  -->

							<td><select class="form-control" name="qty" id="quty">
									<option selected="selected">${cartitem.quantity}</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
									<option value="32">32</option>
									<option value="33">33</option>
									<option value="34">34</option>
									<option value="35">35</option>
									<option value="36">36</option>
									<option value="37">37</option>
									<option value="38">38</option>
									<option value="39">39</option>
									<option value="40">40</option>
									<option value="41">41</option>
									<option value="42">42</option>
									<option value="43">43</option>
									<option value="44">44</option>
									<option value="45">45</option>
									<option value="46">46</option>
									<option value="47">47</option>
									<option value="48">48</option>
									<option value="49">49</option>
									<option value="50">50</option>


							</select> <span class="status"></span></td>

							<td data-th="Subtotal" class="text-center" id="amount"><span
								id="subtotal" class="subtotal"><i class="fa fa-inr"
									aria-hidden="true"></i>0</span></td>
							<td class="actions" data-th=""><a
								href=<c:url value="/deleteCartItem/${cartitem.citemid}"/>
								class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i></a></td>

							<c:if test="${cartitem.quantity <1000}"></c:if>

						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr class="visible-xs">
						<td class="text-center"><strong></strong></td>
					</tr>
					<tr>
						<td><a href="productdisplay" class="btn btn-warning"><i
								class="fa fa-angle-left"></i> Continue Shopping</a></td>
						<td colspan="2" class="hidden-xs"></td>
						<td class="hidden-xs text-center"><strong>Total:</strong>
						<td class="total1"></td>
						<c:if test="${n!=0}">
							<td class=""><a href="shipment" id="w3s"
								class="btn btn-success btn-block">Proceed To Checkout</a></td>
						</c:if>



					</tr>
				</tfoot>

			</table>

			<c:if test="${n!=0}">
				<div>
						<input id="coupon-string" type="text" name="couponid"
							placeholder="Enter The coupons"> <button
							id="coupon-button" type="button" value="Coupon ID"
							class="btn btn-success">Coupon code</button>
							<span id ="coupon-status"></span>
				</div>
			</c:if>
		</div>
	</c:if>

	<script>
	
		$("#coupon-button").click(function(event) {
			event.preventDefault();
			$("#coupon-status").text("");
			var couponcode = $("#coupon-string").val();
			$.getJSON("/shop/checkcouponid?couponid=" + couponcode, function(data) {
			console.log(data.result == "Invalid"? true : false);
			 if(data.result != "Invalid" && data != null){
				var discountPercent = data.result;
				var total = $(".total1").text();
				console.log(total);
				var discountamt = (total / 100) * discountPercent;
				//var normaldiscount=(total - discountPercent);
				$(".total1").text("Original amount: " + total + " Discounted amount: " + discountamt);
			 }
			 
			 else{
				 $("#coupon-status").text("Invalid coupon code");			 
			 }
				 
			});
		});
		
	</script>

</body>

</html>