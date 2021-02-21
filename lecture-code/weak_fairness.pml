

active proctype user1()
{byte count=0;
 do
::(count==0)->progress:count=1
::(count==1)->count=0
od}

active proctype user2()
{byte count=0;
 do
::(count==0)->count=1
::(count==1)->count=0
od}

/*active proctype user3()
{byte count=0;
 do
::(count==0)->count=1
::(count==1)->count=0
od}*/
