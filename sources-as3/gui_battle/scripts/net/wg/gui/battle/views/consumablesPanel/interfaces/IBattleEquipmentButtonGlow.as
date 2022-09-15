package net.wg.gui.battle.views.consumablesPanel.interfaces
{
   import net.wg.infrastructure.interfaces.IMovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IBattleEquipmentButtonGlow extends IDisposable, IMovieClip
   {
       
      
      function setBindKeyText(param1:String) : void;
      
      function showGlow(param1:int, param2:Boolean = true) : void;
      
      function hideGlow(param1:Boolean = true) : void;
   }
}
