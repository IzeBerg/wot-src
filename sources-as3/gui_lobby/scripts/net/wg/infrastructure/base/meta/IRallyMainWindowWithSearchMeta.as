package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRallyMainWindowWithSearchMeta extends IEventDispatcher
   {
       
      
      function onAutoMatchS(param1:String, param2:Array) : void;
      
      function autoSearchApplyS(param1:String) : void;
      
      function autoSearchCancelS(param1:String) : void;
      
      function as_autoSearchEnableBtn(param1:Boolean) : void;
      
      function as_changeAutoSearchState(param1:Object) : void;
      
      function as_changeAutoSearchBtnsState(param1:Boolean, param2:Boolean) : void;
      
      function as_hideAutoSearch() : void;
      
      function as_changeAutoSearchMainLabel(param1:String) : void;
      
      function as_changeAutoSearchTimeDirection(param1:int) : void;
      
      function as_changeAutoSearchCountDownSeconds(param1:int) : void;
   }
}
