<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="GBK">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>΢�Żص�����</title>
    <!-- �� Bootstrap ���� CSS �ļ� -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">


<!-- ��������Ϊ�����û���Ϣ -->
<!-- ��������Ϊ�����û���Ϣ -->
<!-- ��������Ϊ�����û���Ϣ -->
<!-- ��������Ϊ�����û���Ϣ -->
<!-- ��������Ϊ�����û���Ϣ -->




 <script language="jscript" runat="server">  
    Array.prototype.get = function(x) { return this[x]; };  
    function parseJSON(strJSON) { return eval("(" + strJSON + ")"); }  
    function contain(src,str) {return src.indexOf(str) >= 0; }
</script>  

<%

' ΢����Ȩ�ص���Ҫ����û���Ϣ��Ҫ���²���
' 1��ͨ��code��ȡaccess_token��
' 2��ͨ��access_token���ýӿڻ�ȡ�û���Ϣ

' ˵����refresh_tokenӵ�нϳ�����Ч�ڣ�30�죩����refresh_tokenʧЧ�ĺ���Ҫ�û�������Ȩ�����ԣ��뿪������refresh_token��������ʱ�����29��ʱ�������ж�ʱ���Զ�ˢ�²����������


' ������

Public Function GetData(url)

    Dim request
    Dim rs
    set request = Server.CreateObject("Msxml2.ServerXMLHTTP.6.0")
    request.Open "GET", url, False
    request.send
    
    rs = request.ResponseText

    GetData = rs

End Function 

' ����������


' ��վ��Ϣ
dim appid
dim appsec

appid = "xxx"
appsec = "xxx"

'���յ�΢�Żش��Ĳ��������ڻ�ȡ�û�����
dim code
dim state
code = request.querystring("CODE")
state = request.querystring("STATE")

' ΢�ŷ����ַ
dim tokenurl
dim userinfourl

tokenurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="& appid &"&secret="& appsec 
userinfourl = "https://api.weixin.qq.com/sns/userinfo?"

' ������ݣ����ڵ��ԣ������������û���Ϣ����������ݿ�
' ������ݣ����ڵ��ԣ������������û���Ϣ����������ݿ�
' ������ݣ����ڵ��ԣ������������û���Ϣ����������ݿ�
dim html

html = html & "<h1>΢�ŵ�¼�ص��������û�</h1>"

if isEmpty(code) Then
    html = "code is null."
else 
    dim rs 
    

    tokenurl = tokenurl & "&code="& code &"&grant_type=authorization_code"
    rs  = GetData(tokenurl)

    html = html & "<h2>��һ��������CODE��ȡTOKEN</h2>token url : " & tokenurl 
    html = html & "<hr/>token url response : " & rs 


    ' ������ؽ������errcode�������
    if contain(rs,"errcode") Then
        ' {"errcode":40029,"errmsg":"invalid code"}
        html = html & "<hr/> ��ȡtoken ʧ��. ���ص�¼ <a href=""http://api.3d66.com/tplogin/login_wx.asp"">http://api.3d66.com/tplogin/login_wx.asp</a>"
    else

        ' { 
        ' "access_token":"ACCESS_TOKEN", 
        ' "expires_in":7200, 
        ' "refresh_token":"REFRESH_TOKEN",
        ' "openid":"OPENID", 
        ' "scope":"SCOPE" 
        ' }

        ' ��ȡ��token�ˣ����Խ�token�����������ݿ���
        ' ʹ��token��openidȥ��ȡ�û���Ϣ��
        
        set json = parseJSON(rs)
        dim json
        dim access_token
        dim refresh_token
        dim openid
        
        access_token = json.access_token
        refresh_token = json.refresh_token
        openid = json.openid

        html = html & "<hr/><h3>���������</h3><table class='table'><tr><th>access_token</th><td>" & access_token & "</td> </tr>"
        html = html & "<tr><th>refresh_token </th><td>" & refresh_token & "</td> </tr>"
        html = html & "<tr><th>openid </th><td> " & openid & "</td> </tr></table>"

        userinfourl = userinfourl & "access_token=" & access_token & "&openid=" & openid
        html = html & "<hr/><h2>�ڶ���������TOKEN��OPENID��ȡ�û���Ϣ</h2>userinfo url : " & userinfourl 

        rs = GetData(userinfourl)
        html = html & "<hr/>userinfo url response : " & rs 

        ' �������errcode����ȡ�û���Ϣʧ��
        if contain(rs,"errcode") then 
            html = html & "<hr/> ��ȡ�û���Ϣʧ��. ���ص�¼ <a href=""http://api.3d66.com/tplogin/login_wx.asp"">http://api.3d66.com/tplogin/login_wx.asp</a>"
        else 

            ' {
            ' "openid": "oIhOdv4smUBmovJkp6mP8gzoqS6w",
            ' "nickname": "��",
            ' "sex": 1,
            ' "language": "zh_CN",
            ' "city": "Chaoyang",
            ' "province": "Beijing",
            ' "country": "CN",
            ' "headimgurl": "http://wx.qlogo.cn/mmopen/iawHyYlDnQpk5sf5JOI6CyPDibs2DPnRpicjODicpcch2H6P5SVlILjrAC6FLFXPUws9llQ19DoqVKDsUUjNoSDLklaUFibU44ZCG/0",
            ' "privilege": [],
            ' "unionid": "oE0_9wQXFkMpM-4955gEhgD7-RVw"
            ' }

            set json = parseJSON(rs)

            dim nickname
            dim sex
            dim city
            dim province
            dim country
            dim headimgurl
            
            nickname = json.nickname
            sex = json.sex
            city = json.city
            province = json.province
            country = json.country
            headimgurl = json.headimgurl

            html = html & "<hr/><h3>���������</h3><table class='table'><tr><th>nickname</th><td>" & nickname & "</td> </tr>"
            html = html & "<tr><th>headimgurl </th><td><img width='250' src='" & headimgurl & "'/></td> </tr>"
            html = html & "<tr><th>sex </th><td>" & sex & "</td> </tr>"
            html = html & "<tr><th>city </th><td>" & city & "</td> </tr>"
            html = html & "<tr><th>province </th><td>" & province & "</td> </tr>"
            html = html & "<tr><th>country </th><td>" & country & "</td> </tr></table>"

            html = html & "<hr/><h2>�������������û���Ϣ������ת����ҳ</h2> <hr/>"  


        end if
    end if
end if

response.write(html)

%>




<br/>
<br/>
<br/>
</div>
</body>
</html>
 