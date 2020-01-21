param([Parameter(Mandatory = $True)] [string] $url = 'http://www.google.com')

function Response{
    param($string_url)
    $HTTP_Request = [System.Net.WebRequest]::Create($string_url)
    $HTTP_Response = $HTTP_Request.GetResponse()
    $HTTP_Status = [int]$HTTP_Response.StatusCode
    If ($HTTP_Status -eq 200) {
        Write-Output "Reachable"
    }
    Else {
        Write-Output "Unreachable"
    }
    $HTTP_Response.Close()
}
If ($url -match '(http[s]?|[s]?ftp[s]?)(:\/\/)([^\s,]+)') {
    Response $url
}
    Else {
        If('http://' + $url -match '(http[s]?|[s]?ftp[s]?)(:\/\/)([^\s,]+)'){
            Response ('http://' + $url)
        }
        Else{
            Write-Output "URL is invalid"
    }
}
