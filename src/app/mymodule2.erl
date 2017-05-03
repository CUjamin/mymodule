%%%-------------------------------------------------------------------
%%% @author cu-jamin
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 三月 2017 上午7:14
%%%-------------------------------------------------------------------
-module(mymodule2).
-author("cu-jamin").

-protocol({xep, 313, '0.5.1'}).
-protocol({xep, 334, '0.2'}).

-behaviour(gen_mod).


-include("xmpp.hrl").
-include("logger.hrl").
-include("mod_muc_room.hrl").
-include("ejabberd_commands.hrl").
-include("mod_mam.hrl").
-define(DEF_PAGE_SIZE, 50).
-define(MAX_PAGE_SIZE, 250).
%% API
-export([start/2, stop/1,depends/2]).

-export([muc_filter_message/5,mod_opt_type/1]).

start(Host, Opts) ->
  IQDisc = gen_mod:get_opt(iqdisc, Opts, fun gen_iq_handler:check_type/1,
    one_queue),
  Mod = gen_mod:db_mod(Host, Opts, ?MODULE),
  Mod:init(Host, Opts),
  init_cache(Opts),
  gen_iq_handler:add_iq_handler(ejabberd_local, Host,
    ?NS_MAM_TMP, ?MODULE, process_iq_v0_2, IQDisc),
  gen_iq_handler:add_iq_handler(ejabberd_sm, Host,
    ?NS_MAM_TMP, ?MODULE, process_iq_v0_2, IQDisc),
  gen_iq_handler:add_iq_handler(ejabberd_local, Host,
    ?NS_MAM_0, ?MODULE, process_iq_v0_3, IQDisc),
  gen_iq_handler:add_iq_handler(ejabberd_sm, Host,
    ?NS_MAM_0, ?MODULE, process_iq_v0_3, IQDisc),
  gen_iq_handler:add_iq_handler(ejabberd_local, Host,
    ?NS_MAM_1, ?MODULE, process_iq_v0_3, IQDisc),
  gen_iq_handler:add_iq_handler(ejabberd_sm, Host,
    ?NS_MAM_1, ?MODULE, process_iq_v0_3, IQDisc),
  ejabberd_hooks:add(muc_filter_message, Host, ?MODULE,
    muc_filter_message, 50),
  case gen_mod:get_opt(assume_mam_usage, Opts,
    fun(B) when is_boolean(B) -> B end, false) of
    true ->
      ejabberd_hooks:add(message_is_archived, Host, ?MODULE,
        message_is_archived, 50);
    false ->
      ok
  end,
  ejabberd_commands:register_commands(get_commands_spec()),
  ok.

stop(Host) ->
  ejabberd_hooks:delete(muc_filter_message, Host, ?MODULE,
    muc_filter_message, 50),
  gen_iq_handler:remove_iq_handler(ejabberd_local, Host, ?NS_MAM_TMP),
  gen_iq_handler:remove_iq_handler(ejabberd_sm, Host, ?NS_MAM_TMP),
  gen_iq_handler:remove_iq_handler(ejabberd_local, Host, ?NS_MAM_0),
  gen_iq_handler:remove_iq_handler(ejabberd_sm, Host, ?NS_MAM_0),
  gen_iq_handler:remove_iq_handler(ejabberd_local, Host, ?NS_MAM_1),
  gen_iq_handler:remove_iq_handler(ejabberd_sm, Host, ?NS_MAM_1),
  case gen_mod:get_module_opt(Host, ?MODULE, assume_mam_usage,
    fun(B) when is_boolean(B) -> B end, false) of
    true ->
      ejabberd_hooks:delete(message_is_archived, Host, ?MODULE,
        message_is_archived, 50);
    false ->
      ok
  end,
  ejabberd_commands:unregister_commands(get_commands_spec()),
  ok.
depends(_Host, _Opts) ->
  [].

-spec muc_filter_message(message(), mod_muc_room:state(),
    jid(), jid(), binary()) -> message().
muc_filter_message(Pkt, #state{config = Config} = MUCState,
    RoomJID, From, FromNick) ->
  mymodule:handle_muc_message(Pkt),
  ?INFO_MSG("muc_filter_message creating message hahahahahahahahah by mod_man che ben: ~p",[Pkt]),
      Pkt.

get_commands_spec() ->
  [#ejabberd_commands{name = delete_old_mam_messages, tags = [purge],
    desc = "Delete MAM messages older than DAYS",
    longdesc = "Valid message TYPEs: "
    "\"chat\", \"groupchat\", \"all\".",
    module = ?MODULE, function = delete_old_messages,
    args = [{type, binary}, {days, integer}],
    result = {res, rescode}}].

init_cache(Opts) ->
  MaxSize = gen_mod:get_opt(cache_size, Opts,
    fun(I) when is_integer(I), I>0 -> I end,
    1000),
  LifeTime = gen_mod:get_opt(cache_life_time, Opts,
    fun(I) when is_integer(I), I>0 -> I end,
    timer:hours(1) div 1000),
  cache_tab:new(archive_prefs, [{max_size, MaxSize},
    {life_time, LifeTime}]).

mod_opt_type(assume_mam_usage) ->
  fun (B) when is_boolean(B) -> B end;
mod_opt_type(cache_life_time) ->
  fun (I) when is_integer(I), I > 0 -> I end;
mod_opt_type(cache_size) ->
  fun (I) when is_integer(I), I > 0 -> I end;
mod_opt_type(db_type) -> fun(T) -> ejabberd_config:v_db(?MODULE, T) end;
mod_opt_type(default) ->
  fun (always) -> always;
    (never) -> never;
    (roster) -> roster
  end;
mod_opt_type(iqdisc) -> fun gen_iq_handler:check_type/1;
mod_opt_type(request_activates_archiving) ->
  fun (B) when is_boolean(B) -> B end;
mod_opt_type(_) ->
  [assume_mam_usage, cache_life_time, cache_size, db_type, default, iqdisc,
    request_activates_archiving].

