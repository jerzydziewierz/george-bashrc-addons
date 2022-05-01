function make_link()
{
echo -e -n "\e]8;;$1\a$2\e]8;;\a"
}

echo -n "| $(make_link https://eu.actitime.com/stl-tech 'Time tracker') "
echo -n "| $(make_link https://stltech.atlassian.net/jira/your-work 'Jira') "
echo -n "| $(make_link https://bitbucket.org/dashboard/overview 'Bitbucket') "
echo -n "| $(make_link https://console.paperspace.com/grey/machines 'paperspace') "
echo -n "| "