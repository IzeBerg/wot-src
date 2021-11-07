package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleLevelUpViewMeta extends IEventDispatcher
   {
       
      
      function onIntroStartsPlayingS() : void;
      
      function onRibbonStartsPlayingS() : void;
      
      function onCloseBtnClickS() : void;
      
      function onEscapePressS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
