package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISubtitlesWindowMeta extends IEventDispatcher
   {
       
      
      function as_showSubtitle(param1:String) : void;
      
      function as_hideSubtitle() : void;
   }
}
