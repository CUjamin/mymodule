%%%-------------------------------------------------------------------
%%% @author cu-jamin
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 二月 2017 下午4:14
%%%-------------------------------------------------------------------
-module(mymodule).
-author("cu-jamin").

%%-behaviour(gen_mod).
-include("logger.hrl").
-include("xmpp.hrl").
-export([startkafkaclent/1,stopkafkaclent/1,handle_muc_xmpp/1,test/1]).

startkafkaclent([Host])->
  kafkaclient:start([Host]).

stopkafkaclent([Host])->
  kafkaclient:stop([Host]).

handle_muc_xmpp([Pkt])->
  kafkaclient:pushmessage(["test",Pkt]).

test([Pkt])->
  ?INFO_MSG("_________THIS IS THE mymodule_____muc_filter_message creating message che ben: ~p",[Pkt]).
