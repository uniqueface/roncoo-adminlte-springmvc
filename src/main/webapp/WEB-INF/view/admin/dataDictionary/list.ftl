<div class="row">
	<div class="col-xs-12">
		<div class="box">
			<div class="box-header">
				<h3 class="box-title">数据字典列表</h3>
				<div class="box-tools pull-right">
					<a id="dictionary_add" class="btn btn-sm btn-primary"  target="modal" modal="lg" href="${ctx}/admin/dataDictionary/add">添加</a>
				</div>
			</div>
			<div class="box-body">
				<div class="clearfix">
					<div class="col-md-4">
						<div class="input-group date ">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right" id="tableParam">
						</div>
					</div>
					<div class="col-md-4">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-search"></i></span>
							<input type="text" class="form-control" id="search">
						</div>
					</div>
					<div class="col-md-4">
						<button type="submit" id="submitExample4" class="btn btn-primary">查询</button>
					</div>
				</div>
				<table id="dataDictionary_tab" class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>序号</th>
							<th>字段名</th>
							<th>排序</th>
							<th>备注</th>
							<th>创建时间</th>
							<th>操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
	//Date picker
	$('#tableParam').datepicker({
		autoclose : true
	});
	
	//初始化表格
	var No=0;
	var dataDictionary_tab = $('#dataDictionary_tab').DataTable({
		"dom" : 'itflp',
		"processing" : true,
		"searching" : false,
		"serverSide" : true, //启用服务器端分页
		"bInfo" : false,
		"language" : {
			"url" : "plugins/datatables/language.json"
		},
		"ajax" : {
			"url" : "${ctx}/admin/dataDictionary/page",
			"type" : "post"
		},
		"columns" : [ 
		              {"data" : null},
		              {"data" : "fieldName"}, 
		              {"data" : "sort"},
		              {"data" : "remark"},
		              {"data" : null}, 
		              {"data" : null} 
		              ],
		"columnDefs" : [ 
					{
					    targets: 0,
					    data: null,
					    render: function (data) {
					    	No=No+1;
					        return No;
					    }
					},
					{
					    targets: 4,
					    data: "createTime",
					    render: function (data) {
					        return new Date(parseInt(data.createTime) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
					    }
					},
		                 {
			"targets" : -1,
			"data" : null,
			"render" : function(data) {
				return '<a class="btn btn-xs btn-primary" target="modal" modal="lg" href="${ctx}/admin/dataDictionary/view?id='+data.id+'">查看</a>&nbsp;<a class="btn btn-xs btn-info" target="modal" modal="lg" href="${ctx}/admin/dataDictionary/edit?id='+data.id+'">修改</a>&nbsp;<a class="btn btn-xs btn-primary" target="navTab" href="${ctx}/admin/dataDictionaryList/list?id='+data.id+'&fieldCode='+data.fieldCode+'">明细</a>&nbsp;<a class="btn btn-xs btn-default btn-del" data-body="确认要删除吗？" target="ajaxTodo" href="${ctx}/admin/dataDictionary/delete?id='+ data.id + '&fieldCode='+data.fieldCode+'">删除</a>'
			}
		} ]
	}).on('preXhr.dt', function ( e, settings, data ) {
		No=0;
    } );
	
	//点击删除确认时，删除后刷新;
    $(".btn-del").on("click",function(){
    	reloadTable(dataDictionary_tab);
    });
    
    $("#dictionary_add").click(function(){
    	list_ajax = dataDictionary_tab;
    });
    
});
</script>
