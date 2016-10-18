-module(erlorg_docs_handler).

-include_lib("mixer/include/mixer.hrl").
-mixin([
        {erlorg_base_handler,
         [
          init/3,
          rest_init/2,
          content_types_provided/2,
          resource_exists/2
         ]}
       ]).

-export(
  [
   allowed_methods/2,
   handle_get/2
  ]).

%% cowboy
allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.

%% internal
handle_get(Req, State) ->
  Categories = erlorg_link_categories_repo:list(documentation),
  Vars = #{categories => Categories},
  {ok, Body} = docs_dtl:render(Vars),
  {Body, Req, State}.
