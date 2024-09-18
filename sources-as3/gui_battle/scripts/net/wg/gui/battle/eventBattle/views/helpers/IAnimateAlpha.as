package net.wg.gui.battle.eventBattle.views.helpers
{
   import scaleform.clik.motion.Tween;
   
   public interface IAnimateAlpha
   {
       
      
      function animateAlpha(param1:Number, param2:Number, param3:uint) : void;
      
      function onAlphaTweenComplete(param1:Tween) : void;
      
      function clearTweens() : void;
   }
}
