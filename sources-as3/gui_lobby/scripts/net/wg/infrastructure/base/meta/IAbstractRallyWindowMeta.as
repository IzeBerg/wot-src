package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAbstractRallyWindowMeta extends IEventDispatcher
   {
       
      
      function canGoBackS() : Boolean;
      
      function onBrowseRalliesS() : void;
      
      function onCreateRallyS() : void;
      
      function onJoinRallyS(param1:Number, param2:int, param3:Number) : void;
      
      function as_loadView(param1:String, param2:String) : void;
      
      function as_enableWndCloseBtn(param1:Boolean) : void;
   }
}
