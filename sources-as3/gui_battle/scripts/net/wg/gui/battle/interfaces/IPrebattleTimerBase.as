package net.wg.gui.battle.interfaces
{
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public interface IPrebattleTimerBase extends IBattleUIComponent, IDAAPIModule
   {
       
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function hideBackground() : void;
   }
}
