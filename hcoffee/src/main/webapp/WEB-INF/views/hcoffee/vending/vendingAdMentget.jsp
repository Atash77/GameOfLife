<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
 
<html>
<head>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="/hkfsysadmin/static/data/styles.css" type="text/css" rel="stylesheet"/>

	<title>活动统计</title>
    
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
 			$("#btnSubmit").click(function(){
				$("#pageNo").val(1);
				$("#searchForm").attr("action","${ctx}/hcf/vendingAdMentget/list");
				$("#searchForm").submit();
			});
			
			$("#btnClean").click(function(){
				$("#tab").find("input[type=text]").val("");
				$("#channel").get(0).selectedIndex = 0;
	 
				$("#pageNo").val(1);
			});
			
			
			$('#select_createVendingAd').on('hidden.bs.modal', function () {
				$("#select_createVendingAd").css("z-index",'-1');
			})
			
			$('#select_createVendingAd').on('shown.bs.modal', function () {
				$("#select_createVendingAd").css("z-index",'1050');
			})
			
			$('#select_batchAddVendingAd').on('hidden.bs.modal', function () {
				$("#select_batchAddVendingAd").css("z-index",'-1');
			})
			
			$('#select_batchAddVendingAd').on('shown.bs.modal', function () {
				$("#select_batchAddVendingAd").css("z-index",'1050');
			})
			
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						var checkedList = new Array();
			           	$("input[name='vendCodeBox']:checked").each(function(){
			               	checkedList.push("'"+$(this).val()+"'");
			           	});
			           	$("#vendCodeList").val(checkedList.toString());
						$("#searchForm").attr("action","${ctx}/hcf/vendingAdMentget/export");
						$("#searchForm").submit();
					    
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#qbExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						var checkedList = new Array();
			           	$("input[name='vendCodeBox']:checked").each(function(){
			               	checkedList.push("'"+$(this).val()+"'");
			           	});
			           	$("#vendCodeList").val(checkedList.toString());
						$("#searchForm").attr("action","${ctx}/hcf/vendingAdMentget/qbexport");
						$("#searchForm").submit();
					    
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			
		});
		
		/* 分页 */
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/hcf/vendingAdMentget/list");
			$("#searchForm").submit();
        	return false;
        }
				
		$(function(){
			document.onkeydown = function(e){ 
			    var ev = document.all ? window.event : e;
			    if(ev.keyCode==13) {
			    	$("#pageNo").val(1);
					$("#searchForm").attr("action","${ctx}/hcf/vendingAdMentget/list");
					$("#searchForm").submit();
			     }
			}
		});
	
		function selectAll(){   
			//alert($("#all").attr("checked"));
			if($("#all").attr("checked")=="checked"){
				$("[name='vendCodeBox']").attr("checked",'true');//全选
			}else{
				 $("[name='vendCodeBox']").removeAttr("checked");//取消全选
			}
		};
		
		function addVendingAd(){   
			 
			 var adType=$('input:radio[name="adType"]:checked').val();
		     if(adType==1){
		    	 $("#imgButton").show();
			     $("#imgDiv").show();
			     $("#videoButton").hide();
			     $("#videoDiv").hide();
		     }else{
		    	 $("#imgButton").hide();
			     $("#imgDiv").hide();
			     $("#videoButton").show();
			     $("#videoDiv").show();
		     }
		    
		     $("#id").val("");
		     $("#vendCodeId").val("");
		     $("#file1").val("");
	    	 $("#file2").val("");
	    	 $("#file3").val("");
		     $("#preview1").html("");
	    	 $("#preview2").html("");
	    	 $("#preview3").html("");
	    	 $("#video").val("");
		     $("#orderLabel").text("新增机器广告!");
		     $("#vendCodeId").attr("disabled",false);
			 $("#select_createVendingAd").modal("show");
		}
		
		function edit(vendCode){
			$.ajax({
				type:"post",
				url:'${ctx}/hcf/vendingAdMentget/edit',
				data: vendCode,
				dataType:"json",
				contentType:"application/json",
				success:function(data){
					if(data.vendCode!=''){
						$("#id").val(data.id);
						$("#channelName").val(data.channelName);
						$("#communityName").val(data.communityName);
						$("#imgLink1").val(data.imgLink1);
						$("#imgLink2").val(data.imgLink2);
						$("#imgLink3").val(data.imgLink3);
						$("#channelId").attr("disabled",true);
						$("#communityId").attr("disabled",true);
						$("#channelId").attr("disabled",true);
						$("#channelName").attr("disabled",true);
						$("#communityName").attr("disabled",true);
 					    if(data.adType==1){
					    	 $("#batchPreview1").val(data.imgPath1);
					    	 $("#batchPreview2").val(data.imgPath2);
					    	 $("#batchPreview3").val(data.imgPath3);
					    	$("#channelId").select2("data",{"id":data.channel,"text":data.channelName});
						    $("#communityId").select2("data",{"id":data.communityId,"text":data.communityName});
						    $("#vendCodeId").select2("data",{"id":data.vendCode,"text":data.vendCode});
					    	 $(":radio[name=adType][value='1']").attr("checked","true");
					    	 var imgPreview1 = document.getElementById('preview1'); 
						     imgPreview1.innerHTML = '<img src=${ctxFile}/'+ data.imgPath1 +' />';  
						    
						     var imgPreview2 = document.getElementById('preview2'); 
						     imgPreview2.innerHTML = '<img src=${ctxFile}/'+ data.imgPath2 +' />'; 
						    
						     var imgPreview3 = document.getElementById('preview3'); 
						     imgPreview3.innerHTML = '<img src=${ctxFile}/'+ data.imgPath3 +' />'; 
						     //   imgPreview3.innerHTML = '<img src="http://192.168.30.201/'+ data.imgPath3 +'" />'; 
						     
						     $("#imgButton").show();
						     $("#imgDiv").show();
						     $("#videoButton").hide();
						     $("#videoDiv").hide();
					    }else{
					    	$("#channelId").select2("data",{"id":data.channel,"text":data.channelName});
						    $("#communityId").select2("data",{"id":data.communityId,"text":data.communityName});
						    $("#vendCodeId").select2("data",{"id":data.vendCode,"text":data.vendCode});
					    	$("#batchVideo").val(data.videoPath);
					    	var videoPreview = document.getElementById('video');  
					    	videoPreview.innerHTML = '<video width="60" height="80" controls="controls" src=${ctxFile}/'+ data.vedioPath + '  />';
					    	 $(":radio[name=adType][value='2']").attr("checked","true");
					    	 
					    	 $("#imgButton").hide();
						     $("#imgDiv").hide();
						     $("#videoButton").show();
						     $("#videoDiv").show();
					    }
					    $("#orderLabel").text("编辑机器广告!");
					    $("#select_createVendingAd").modal("show");
					}		       	 	
				}
				
			})
		}
		
		
		function selectAll(){   
			//alert($("#all").attr("checked"));
			if($("#all").attr("checked")=="checked"){
				$("[name='vendCodeBox']").attr("checked",'true');//全选
			}else{
				 $("[name='vendCodeBox']").removeAttr("checked");//取消全选
			}
		};
		
		function batchUpgrade(){
			
	    	 $("#batchImgButton").show();
		     $("#batchImgDiv").show();
		     $("#batchVideoButton").hide();
		     $("#batchVideoDiv").hide(); 
			
            //判断至少写了一项
            var checkedNum = $("input[name='vendCodeBox']:checked").length;
            if(checkedNum<2){
                alert("请至少选择2个进行批量更新!");
                return false;
            }
           	var checkedList = new Array();
           	$("input[name='vendCodeBox']:checked").each(function(){
               	checkedList.push($(this).val());
           	});
           	
           	$("#batchVendCode").val(checkedList.toString());
           	$("#select_batchAddVendingAd").modal("show");
           	
           	/* $.ajax({
                type:"POST",
                url:"${ctx}/hcf/vendingMachine/batchUpgrade",
                data:{"delitems":checkedList.toString()},
                datatype:"html",
                success:function(data){
					alert(data.msg);
		       		if(data.code=="0"){
		       			window.location.href="${ctx}/hcf/vendingMachine/list";
		       		}
				}
           	}); */
		}
		

		function occlude(vendCode,adStatus,msg) {
			var data = {}; 
			data.adStatus=adStatus;
			data.vendCode=vendCode;
			$.ajax({
			type:"post",
			url:'${ctx}/hcf/vendingAdMentget/close',
			data:JSON.stringify(data),
			dataType:"json",
			contentType:"application/json",
            success:function(data){
             	
             	if(data.code=="0"){
             		alert(msg);
		       		window.location.href="${ctx}/hcf/vendingAdMentget/list";
		       	}else{
		       		alert(data.msg);
		       	}
             }
         });    
		}
		
		function closeAddVendAd(){
			alert("123");
		}
	</script>
 <style>    
 </style> 
</head>
</head>
<body>
	<form:form id="searchForm" modelAttribute="vendingAdVo" action="${ctx}/hcf/vendingAdMentget/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="vendCodeList" name="vendCodeList" type="hidden" value=""/>
		<table id="tab" class="table table-striped table-bordered table-condensed" style="width: 100%">
			<tr>
				<td width="3%" style="text-align:left">
					<label class="control-label">渠道：</label>
				<form:select path="channel" class="input-xlarge required" style="width:120px;"  id="channel">
						 	<form:option value="" label="全部"/>
						 	<c:forEach items="${channelList}" var="channel" varStatus="indexStatus">
									<form:option value="${channel.channelId}" label="${channel.channelName}"/>
							</c:forEach>
				</form:select>
				</td>
				
		 		<td width="3%" style="text-align:left">
					<label class="control-label">售货机编码：</label>
					<form:input path="vendCode" htmlEscape="false" maxlength="16" class="input-medium"/>
				</td>
				
				<td width="8%" style="text-align:left">
					<label class="control-label">创建时间：</label>
					<input name="startTime" type="text"  maxlength="20" class="input-medium Wdate " value="<fmt:formatDate value="${vendingAdVo.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" readonly="readonly"/>
					--
					<input name="endTime" type="text"  maxlength="20" class="input-medium Wdate " value="<fmt:formatDate value="${vendingAdVo.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" readonly="readonly"/>
		 
				</td>
 
 
				<td  width="8%" style="text-align:left" >
	   				<input id="btnSubmit" class="btn btn-primary" type="button" value="查询" />
	   				<input class="btn btn-primary" type="button" value="新增机器广告" onclick="addVendingAd()"/>
	   				<input class="btn btn-primary" type="button" value="批量更新" onclick="batchUpgrade()"/>
	   				<input id="btnExport" class="btn btn-primary" type="button" value="导出当前页"/>
	   				<input id="qbExport" class="btn btn-primary" type="button" value="导出所有"/>
				</td>
			</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="1%"> <input type="checkbox" id="all" name="all" onclick="selectAll()"></th>
				<th width="1%">序号</th>
				<th width="8%">渠道</th>
				<th width="5%">机器所在社区</th>
				<th width="6%">售货机编码</th>
				<th width="6%">广告类型</th>
				<th width="8%">创建时间</th>
				<th width="8%">广告状态</th>
				<th width="8%">操作</th>
 
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="model" varStatus="bi">
				<tr>
					<td>
						<input type="checkbox" name="vendCodeBox" value="${model.vendCode}">
					</td>
					<td>${bi.count}</td>
					<td>${model.channelName}</td>
					<td>${model.communityName}</td>
					<td>${model.vendCode}</td>
					<td>
					<c:choose>
							<c:when test="${model.adType == 1}">
								图片
							</c:when>
							<c:when test="${model.adType == 2}">
								视频
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${model.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>
					<c:choose>
							<c:when test="${model.adStatus == 1}">
								进行中
							</c:when>
							<c:when test="${model.adStatus == 2}">
								已关闭
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					 
					<td>
					  <a href="javascript:void(0)"  onclick="edit('${model.vendCode}')">编辑 </a>&nbsp;
					  <c:choose>
							<c:when test="${model.adStatus == 1}">
								<a href="javascript:void(0)"  onclick="occlude('${model.vendCode}','${model.adStatus}','关闭成功')">关闭 </a>&nbsp;
							</c:when>
							<c:when test="${model.adStatus == 2}">
								<a href="javascript:void(0)"  onclick="occlude('${model.vendCode}','${model.adStatus}','打开成功')">打开 </a>&nbsp;
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
					  </c:choose>
					  
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination" >${page}</div>
	
	
	<!--  选择创建新增机器广告模式窗口（Modal）-->
	<div class="modal fade" id="select_createVendingAd" tabindex="-1" role="dialog" aria-labelledby="orderLabel" aria-hidden="true"  style="width: 700px;margin-left: -400px;z-index: -1;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >
						&times;
					</button>
					<h4 class="modal-title" id="orderLabel">
						广告管理编辑
					</h4>
				</div>
				<div class="modal-body">	
 				<%@ include  file="createVendingAdMentget.jsp"%>
 
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
		</div>
	</div> 
	
	<!--  选择创建批量增加机器广告模式窗口（Modal）-->
	<div class="modal fade" id="select_batchAddVendingAd" tabindex="-1" role="dialog" aria-labelledby="orderLabel" aria-hidden="true"  style="width: 700px;margin-left: -400px;z-index: -1;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >
						&times;
					</button>
					<h4 class="modal-title" id="batchOrderLabel">
						批量更新机器广告
					</h4>
				</div>
			    
				<div class="modal-body">	
 
 				<%@ include  file="createAdMentget.jsp"%>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
		</div>
	</div> 
</body>
</html>