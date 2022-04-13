package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattlePageMeta extends IEventDispatcher
   {
       
      
      function as_checkDAAPI() : void;
      
      function as_setPostmortemTipsVisible(param1:Boolean) : void;
      
      function as_setComponentsVisibility(param1:Array, param2:Array) : void;
      
      function as_isComponentVisible(param1:String) : Boolean;
      
      function as_getComponentsVisibility() : Array;
      
      function as_toggleCtrlPressFlag(param1:Boolean) : void;
      
      function as_createRoleDescription() : void;
      
      function as_setArtyShotIndicatorFlag(param1:Boolean) : void;
      
      function as_togglePiercingPanel() : void;
   }
}
