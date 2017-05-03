%%%-------------------------------------------------------------------
%%% @author cujamin
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 五月 2017 下午3:44
%%%-------------------------------------------------------------------
-module(kafkaclient).
-author("cujamin").

-include("xmpp.hrl").
-include("logger.hrl").
%% API
-export([start/1,stop/1,pushmessage/1]).


start([Host])->
  ?INFO_MSG(" [ kafka client start ... Host : ~s ] ",[Host]),
  application:load(gproc),         %%加载gproc
  application:load(kafkamocker),      %%加载kafkamocker
  application:load(ekaf),         %%加载ekaf
  application:set_env(ekaf, ekaf_bootstrap_broker, {"localhost", 9092}),%%设置参数(ip,port)
  application:start(gproc),         %%启动gproc
  application:start(kafkamocker),       %%启动kafkamocker
  application:start(ekaf),
  ?INFO_MSG(" [ kafka client start OK ] ",[]),
  ok.

stop([Host])->
  ?INFO_MSG(" [ kafka client stop ... Host : ~s ] ",[Host]),
  application:unset_env(ekaf, ekaf_bootstrap_broker, {"localhost", 9092}),%%设置参数(ip,port)
  application:stop(gproc),         %%启动gproc
  application:stop(kafkamocker),       %%启动kafkamocker
  application:stop(ekaf),
  application:unload(gproc),         %%加载gproc
  application:unload(kafkamocker),      %%加载kafkamocker
  application:unload(ekaf),         %%加载ekaf
  ?INFO_MSG(" [ kafka client stop OK ] ",[]),
  ok.

pushmessage([Topic,MSG])->
  publishxmpp([Topic,MSG]).

publishxmpp([Topic,#message{type = groupchat, from = From , to = To,body = Body, subject = Subj}])->
  SentTopic = unicode:characters_to_binary(Topic,utf8),
  SentMessage = checkxmppbody(Body),
  ekaf:produce_sync(SentTopic,SentMessage).

checkxmppbody([#text{lang = Lang, data = Data}])->Data.