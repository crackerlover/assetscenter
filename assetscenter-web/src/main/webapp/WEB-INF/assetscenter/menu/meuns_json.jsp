<%@page import="java.util.*" %>
<%
	Map<String, String> map = (Map<String, String>)request.getAttribute("map");
%>
[{
	"id":1,
		"text":"Navigation",
		"iconCls":"icon-channels",
		"children":[{
			"id":11,
			"text":"Asset Center",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=asset/asset_view"}
		},{
			"id":12,
			"text":"Order Center",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=order/order_view"}
		},{
			"id":13,
			"text":"Case Center",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=case/case_view"}
		},{
			"id":14,
			"text":"Project Center",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=project/project_view"}
		},{
			"id":15,
			"text":"Team Center",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=team/team_view"}
		}]
	},{
		"id":2,
		"text":"Projects",
		"iconCls":"icon-channels"
		<%
			String dataP = map.get("project_json_data");
			if(!"".equals(dataP)) {
				out.print("," + dataP);
			}
		%>
	},{
		"id":3,
		"text":"Teams",
		"iconCls":"icon-channels"
		<%
			String dataT = map.get("team_json_data");
			if(!"".equals(dataT)) {
				out.print("," + dataT);
			}
		 %>
},{
		"id":4,
		"text":"Operations",
		"iconCls":"icon-channels",
		"children":[{
			"id":41,
			"text":"Access Roles",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=user/user_view"}
		},{
			"id":42,
			"text":"Transfer Record",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=transfer/transfer_view"}
		},{
			"id":43,
			"text":"Project Apply Record",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=project/apply_view"}
		},{
			"id":44,
			"text":"Team Apply Record",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=team/apply_view"}
		},{
			"id":45,
			"text":"Project Assets",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=project/project_assets"}
		},{
			"id":46,
			"text":"Team Assets",
			"iconCls":"icon-rss",
			"attributes":{"url":"requestDispatcher.do?url=team/team_assets"}
		},{
		    "id":47,
		    "text":"Case Types",
		    "iconCls":"icon-rss",
		    "attributes":{"url":"requestDispatcher.do?url=case/type/casetype_view"}
		},{
		    "id":48,
		    "text":"Asset Types",
		    "iconCls":"icon-rss",
		    "attributes":{"url":"requestDispatcher.do?url=asset/type/asset_type_view"}
		},{
		    "id":49,
		    "text":"Return Assets",
		    "iconCls":"icon-rss",
		    "attributes":{"url":"requestDispatcher.do?url=return/asset_view"}
		}]
	},{
		"id":5,
		"text":"System",
		"iconCls":"icon-channels",
		"children":[{
			"id":51,
			"text":"Logout",
			"iconCls":"icon-rss",
			"attributes":{"url":"logout.do"}
		}]
	}]